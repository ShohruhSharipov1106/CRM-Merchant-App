import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:crm_merchant/screens/add_proposal/identification_page.dart';
import 'package:crm_merchant/screens/camera_id/face_id/camera_view.dart';
import 'package:crm_merchant/screens/camera_id/face_id/face_not_match_page.dart';
import 'package:crm_merchant/screens/camera_id/painters/face_detector_painter.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as imglib;
import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/services/face_id_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:merge_images/merge_images.dart';

class CameraFaceIDPage extends StatefulWidget {
  const CameraFaceIDPage({Key? key}) : super(key: key);

  @override
  State<CameraFaceIDPage> createState() => _CameraFaceIDPageState();
}

class _CameraFaceIDPageState extends State<CameraFaceIDPage> {
  String? deviceId;
  int faceLength = 0;
  bool hasFace = false;
  late final Function(InputImage inputImage) onImage;
  FaceDetector faceDetector = GoogleMlKit.vision.faceDetector(
    const FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
    ),
  );
  bool isBusy = false;
  CustomPaint? customPaint;

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    faceDetector.close();
    super.dispose();
  }

  bool _showloader = false;
  Uint8List? imageDatas;
  Image takeImage = Image.asset('assets/icons/ellipse.png');
  bool takePicture = false;
  CameraImage? imgCamera;
  String? _base64;
  Uint8List? bytes;

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint("Couldn't check connectivity status error: $e");
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == ConnectivityResult.mobile ||
            _connectionStatus == ConnectivityResult.wifi ||
            _connectionStatus == ConnectivityResult.ethernet
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: kBlackTextColor,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: kWhiteColor,
                  size: 24.0,
                ),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _titleText(),
                Container(
                  height: kHeight(565.0).h,
                  width: kWidth(396.0).w,
                  margin: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 16,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 25,
                    horizontal: 34,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        hasFace
                            ? "assets/icons/oval-frame.png"
                            : "assets/icons/unselected-oval-frame.png",
                      ),
                      fit: BoxFit.fitHeight,
                    ),
                    color: kBlackTextColor,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(
                        kWidth(396.0).w,
                        kHeight(565.0).h,
                      ),
                    ),
                    child: takePicture
                        ? takeImage
                        : CameraView(
                            title: 'Face Detector',
                            customPaint: customPaint,
                            onImage: (inputImage, _imgCamera) {
                              imgCamera = _imgCamera;
                              processImage(inputImage);
                            },
                            initialDirection: CameraLensDirection.front,
                          ),
                  ),
                ),
                _subtitleText(context),
                SizedBox(height: kHeight(30).h),
                MainButton(
                  context,
                  "take_photo",
                  () async {
                    setState(() {
                      _showloader = true;
                    });
                    if (takePicture) {
                      setState(() {
                        takePicture = false;
                        _showloader = true;
                      });
                    } else {
                      setState(() {
                        takePicture = true;
                        _showloader = true;
                      });
                      if ((imageDatas?.length ?? 0) > 0) {
                        takeImage =
                            (await convertYUV420toImageColor(imgCamera!))!;
                      }
                      ui.Image image =
                          await ImagesMergeHelper.loadImageFromProvider(
                              takeImage.image);

                      bytes = await ImagesMergeHelper.imageToUint8List(image);

                      String uint8ListTob64(Uint8List uint8list) {
                        String base64String = base64Encode(uint8list);
                        String header = "data:image/png;base64,";
                        return header + base64String;
                      }

                      Future<Uint8List> uint8ListComporessList(
                          Uint8List list) async {
                        var result =
                            await FlutterImageCompress.compressWithList(
                          list,
                          minHeight: 1080,
                          minWidth: 720,
                          quality: 72,
                          rotate: 270,
                          format: CompressFormat.png,
                        );
                        return result;
                      }

                      Uint8List compressUint8List =
                          await uint8ListComporessList(bytes!);

                      _base64 = uint8ListTob64(compressUint8List);
                      await _sendFaceApi(_base64!).whenComplete(
                        () => setState(() {
                          _showloader = false;
                        }),
                      );
                    }
                  },
                  showLoader: _showloader,
                ),
              ],
            ),
          )
        : const NoInternetPage();
  }

  Center _titleText() {
    return const Center(
      child: LocaleText(
        "check_identification",
        style: TextStyle(
          fontSize: 24.0,
          color: kWhiteColor,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  LocaleText _subtitleText(BuildContext context) {
    return LocaleText(
      "keep_head_straight",
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontSize: 10.0,
            color: kWhiteColor,
          ),
      textAlign: TextAlign.center,
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final faces = await faceDetector.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = FaceDetectorPainter(
          faces,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(
        () {
          if (faces.length == 1) {
            hasFace = true;
            if ((inputImage.bytes?.length ?? 0) > 0 && takePicture == false) {
              imageDatas = inputImage.bytes;
            }
          } else {
            hasFace = false;
          }
        },
      );
    }
  }

  Future<Image?> convertYUV420toImageColor(CameraImage image) async {
    try {
      final int width = image.width;
      final int height = image.height;
      final int uvRowStride = image.planes[1].bytesPerRow;
      final int? uvPixelStride = image.planes[1].bytesPerPixel;

      var img = imglib.Image(width, height);

      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          final int uvIndex =
              uvPixelStride! * (x / 2).floor() + uvRowStride * (y / 2).floor();
          final int index = y * width + x;

          final yp = image.planes[0].bytes[index];
          final up = image.planes[1].bytes[uvIndex];
          final vp = image.planes[2].bytes[uvIndex];
          // Calculate pixel color
          int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
          int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
              .round()
              .clamp(0, 255);
          int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
          // color: 0x FF  FF  FF  FF
          //           A   B   G   R
          img.data[index] = (0xFF << 24) | (b << 16) | (g << 8) | r;
        }
      }
      imglib.PngEncoder pngEncoder = imglib.PngEncoder(level: 0, filter: 0);
      List<int> png = pngEncoder.encodeImage(img);

      return Image.memory(Uint8List.fromList(png));
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
    return null;
  }

  Future _sendFaceApi(String _base64) async {
    deviceId = await _getId();
    FaceIdService.sendFacetoId(
      context
          .read<AddProposalProvider>()
          .serialNumberOfpassport
          .text
          .removeAllWhitespace
          .toUpperCase(),
      "${context.read<AddProposalProvider>().dateOfBirth.text.substring(6)}-${context.read<AddProposalProvider>().dateOfBirth.text.substring(3, 5)}-${context.read<AddProposalProvider>().dateOfBirth.text.substring(0, 2)}T00:00:00.000Z",
      _base64,
      deviceId!,
    )
        .then((value) => {
              print(value),
              if (value.resultCode == 1 || value.resultCode == 200)
                {
                  context.read<AddProposalProvider>().getClientDatas(value),
                  Get.to(const IdentificationPage())
                }
              else
                {Get.to(const FaceNotMatch())}
            })
        .onError((error, stackTrace) => {Get.to(const FaceNotMatch())});
  }
}
