import 'dart:io';

import 'package:crm_merchant/constants/exports.dart';

import 'package:crm_merchant/screens/face_id/camera_view.dart';
import 'package:crm_merchant/screens/face_id/painters/face_detector_painter.dart';

import '../../main.dart';

class CameraFaceIDPage extends StatefulWidget {
  const CameraFaceIDPage({Key? key}) : super(key: key);

  @override
  State<CameraFaceIDPage> createState() => _CameraFaceIDPageState();
}

class _CameraFaceIDPageState extends State<CameraFaceIDPage> {
  int faceLength = 0;
  String? facePath;
  bool hasFace = false;
  File? _image;
  ImagePicker? _imagePicker;
  late final Function(InputImage inputImage) onImage;
  FaceDetector faceDetector = GoogleMlKit.vision.faceDetector(
    const FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
    ),
  );
  bool isBusy = false;
  CustomPaint? customPaint;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  // @override
  // void initState() {
  //   super.initState();
  //   _controller = CameraController(cameras[1], ResolutionPreset.max);
  //   _controller.initialize().then((_) {
  //     if (!mounted) {
  //       return;
  //     }
  //     setState(() {});
  //   });
  //   _initializeControllerFuture = _controller.initialize();
  // }

  @override
  void dispose() {
    _controller.dispose();
    faceDetector.close();
    super.dispose();
  }

  XFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          const Center(
            child: Text(
              "Проведите идетификация  ",
              style: TextStyle(
                fontSize: 24.0,
                color: kWhiteColor,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: kHeight(565.0).h,
            width: kWidth(396.0).w,
            margin: EdgeInsets.symmetric(
              vertical: kHeight(42.0).h,
              horizontal: kWidth(16.0).w,
            ),
            padding: EdgeInsets.symmetric(
              vertical: kHeight(25.0).h,
              horizontal: kWidth(34.0).w,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  hasFace
                      ? "assets/icons/oval-frame.png"
                      : "assets/icons/unselected-oval-frame.png",
                ),
                fit: BoxFit.cover,
              ),
              color: kBlackTextColor,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.elliptical(
                  kWidth(360.0).w,
                  kHeight(515.0).h,
                ),
              ),
              // child: CameraPreview(_controller),
           child:   CameraView(
                title: 'Face Detector',
                customPaint: customPaint,
                onImage: (inputImage) {
                  processImage(inputImage);
                  _controller.takePicture();
                },
                initialDirection: CameraLensDirection.front,
              ),
            ),
          ),
          _subtitleText(context),
          SizedBox(height: kHeight(50.0).h),
          MainButton(
            "Сделать фото",
            () async {
              // Take the Picture in a try / catch block. If anything goes wrong,
              // catch the error.
              try {
                // Ensure that the camera is initialized.
                await _initializeControllerFuture;

                // Attempt to take a picture and get the file `image`
                // where it was saved.
                final image = await _controller.takePicture();

                // If the picture was taken, display it on a new screen.
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DisplayPictureScreen(
                      // Pass the automatically generated path to
                      // the DisplayPictureScreen widget.
                      imagePath: image.path,
                    ),
                  ),
                );
              } catch (e) {
                // If an error occurs, log the error to the console.
                print(e);
              }
            },
          ),
        ],
      ),
    );
  }

  Text _subtitleText(BuildContext context) {
    return Text(
      "Пожалуйста держите голову прямо ",
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
    debugPrint('Found ${faces.length} faces');
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
          } else {
            hasFace = false;
          }
        },
      );
    }
  }

  Future _getImage(ImageSource source) async {
    final pickedFile = await _imagePicker?.pickImage(source: source);
    if (pickedFile != null) {
      _processPickedFile(pickedFile);
    } else {
      debugPrint('No image selected.');
    }
    setState(() {});
  }

  Future _processPickedFile(XFile? pickedFile) async {
    final path = pickedFile?.path;
    if (path == null) {
      return;
    }
    setState(() {
      _image = File(path);
    });
    final inputImage = InputImage.fromFilePath(path);
    onImage(inputImage);
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = _controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException {
      return null;
    }
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
