import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/camera_id/document_id/camera_address_page.dart';
import 'package:crm_merchant/screens/camera_id/document_id/passport_converter_page.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart'
    as mlkit_commons;
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:io';

class CameraPassportIDPage extends StatefulWidget {
  const CameraPassportIDPage({Key? key}) : super(key: key);

  @override
  State<CameraPassportIDPage> createState() => _CameraPassportIDPageState();
}

class _CameraPassportIDPageState extends State<CameraPassportIDPage> {
  String? deviceId;
  final TextRecognizer _textRecognizer = TextRecognizer();
  bool _canProcess = true;
  bool _isBusy = false;
  String? _text;

  @override
  void dispose() async {
    _canProcess = false;
    _textRecognizer.close();
    super.dispose();
  }

  bool _showloader = false;

  File? _scannedImage;

  openImageScanner(BuildContext context) async {
    var image = await DocumentScannerFlutter.launch(
      context,
      labelsConfig: {
        ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL:
            Locales.string(context, 'next'),
        ScannerLabelsConfig.ANDROID_OK_LABEL: "OK",
        ScannerLabelsConfig.PICKER_CAMERA_LABEL:
            Locales.string(context, 'camera'),
        ScannerLabelsConfig.PICKER_GALLERY_LABEL:
            Locales.string(context, 'galery'),
        ScannerLabelsConfig.ANDROID_BMW_LABEL:
            Locales.string(context, 'b_and_m'),
        ScannerLabelsConfig.ANDROID_ORIGINAL_LABEL:
            Locales.string(context, 'orginal'),
        ScannerLabelsConfig.ANDROID_ROTATE_LEFT_LABEL:
            Locales.string(context, 'left'),
        ScannerLabelsConfig.ANDROID_ROTATE_RIGHT_LABEL:
            Locales.string(context, 'right'),
        ScannerLabelsConfig.ANDROID_SAVE_BUTTON_LABEL:
            Locales.string(context, "save"),
        ScannerLabelsConfig.ANDROID_LOADING_MESSAGE:
            Locales.string(context, 'loading'),
        ScannerLabelsConfig.ANDROID_SCANNING_MESSAGE:
            Locales.string(context, 'scanning'),
      },
    );
    if (image != null) {
      _scannedImage = image;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final ctxRead = context.read<AddProposalProvider>();
    PassportData passData;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBlackTextColor,
      appBar: _appBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: kWidth(10.0).w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _title(context),
            SizedBox(height: kHeight(10.0).h),
            _subtitle(context),
            Padding(
              padding: EdgeInsets.only(
                top: kHeight(21.0).h,
                bottom: kHeight(50.0).h,
                left: 15,
                right: 17,
              ),
              child: CustomPaint(
                foregroundPainter: BorderPainter(_scannedImage),
                child: Stack(
                  children: [
                    Container(
                      height: kHeight(515.0).h,
                      width: kWidth(368.0).w,
                      margin: EdgeInsets.symmetric(
                        vertical: kHeight(15.0).h,
                        horizontal: kWidth(14.0).w,
                      ),
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: _scannedImage != null
                            ? Image.file(
                                _scannedImage!,
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                    ),
                    Positioned(
                      child: Visibility(
                        visible: _scannedImage != null ? true : false,
                        child: IconButton(
                          onPressed: () async {
                            setState(() {
                              _scannedImage!.delete();
                              _scannedImage = null;
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: kWhiteColor,
                            size: 24.0,
                          ),
                        ),
                      ),
                      right: kWidth(30.0).w,
                      top: kHeight(25.0).h,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            MainButton(
              context,
              _scannedImage != null ? "next" : "take_photo",
              () async {
                if (_scannedImage != null) {
                  setState(() {
                    _showloader = true;
                  });
                  Uint8List _bytes = _scannedImage!.readAsBytesSync();
                  String uint8ListTob64(Uint8List uint8list) {
                    String base64String = base64Encode(uint8list);
                    String header = "data:image/png;base64,";
                    return header + base64String;
                  }

                  Future<Uint8List> uint8ListComporessList(
                      Uint8List list) async {
                    var result = await FlutterImageCompress.compressWithList(
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
                      await uint8ListComporessList(_bytes);
                  pasportBase64 = uint8ListTob64(compressUint8List);

                  await processImage(
                          mlkit_commons.InputImage.fromFile(_scannedImage!))
                      .then(
                        (value) => {
                          if (_text!.isNotEmpty || _text != null)
                            {
                              passData = PassportConverterHelper()
                                  .convertByLine(_text ?? ""),
                              ctxRead.name.text = passData.ismi,
                              ctxRead.surname.text = passData.familiyasi,
                              ctxRead.dadname.text = passData.otaIsmi,
                              ctxRead.gender =
                                  passData.jinsi == "M" ? "Erkak" : "Ayol",
                              ctxRead.nationality = passData.millat,
                              ctxRead.pinfl.text = passData.pinfl,
                              ctxRead.givenDate.text = passData.berilganSana,
                              ctxRead.givenBy.text = passData.kimBergan,
                              ctxRead.expiryDate.text = passData.amalMuddati,
                              Get.to(const CameraAddressPage()),
                            },
                        },
                      )
                      .whenComplete(() => setState(() {
                            _showloader = false;
                          }));
                } else {
                  openImageScanner(context);
                }
              },
              showLoader: _showloader,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Future<void> processImage(mlkit_commons.InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final recognizedText = await _textRecognizer.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
    } else {
      _text = recognizedText.text;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  LocaleText _subtitle(BuildContext context) {
    return LocaleText(
      "identification_by_passport_subtitle",
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            fontSize: 10.0,
            color: kWhiteColor,
          ),
      textAlign: TextAlign.center,
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: kWhiteColor,
          size: 24.0,
        ),
      ),
    );
  }

  AutoSizeText _title(BuildContext context) {
    return AutoSizeText(
      Locales.string(context, "identification_by_passport") +
          "\n" +
          Locales.string(context, "passport_photo"),
      style: TextStyle(
        fontSize: clientMainData.read("locale") == 'uz' ? 22.0 : 24.0,
        color: kWhiteColor,
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class BorderPainter extends CustomPainter {
  final File? _scannedImage;
  BorderPainter(this._scannedImage);
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height; // for convenient shortage
    double sw = size.width; // for convenient shortage
    double cornerSide = sh * 0.1; // desirable value for corners side

    Paint paint = Paint()
      ..color = _scannedImage != null ? kGreenLabelColor : kWhiteColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path()
      ..moveTo(cornerSide, 0)
      ..quadraticBezierTo(0, 0, 0, cornerSide)
      ..moveTo(0, sh - cornerSide)
      ..quadraticBezierTo(0, sh, cornerSide, sh)
      ..moveTo(sw - cornerSide, sh)
      ..quadraticBezierTo(sw, sh, sw, sh - cornerSide)
      ..moveTo(sw, cornerSide)
      ..quadraticBezierTo(sw, 0, sw - cornerSide, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}
