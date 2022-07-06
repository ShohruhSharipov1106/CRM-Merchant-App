
import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/main.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart'
    as mlkit_commons;

enum ScreenMode { liveFeed, gallery }

class DocumentCameraView extends StatefulWidget {
  const DocumentCameraView(
      {Key? key,
      required this.title,
      required this.customPaint,
      this.text,
      required this.onImage,
      this.initialDirection = CameraLensDirection.back})
      : super(key: key);

  final String title;
  final CustomPaint? customPaint;
  final String? text;
  final Function(mlkit_commons.InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<DocumentCameraView> {
  final ScreenMode _mode = ScreenMode.liveFeed;
  CameraController? _controller;
  int _cameraIndex = 0;

  @override
  void initState() {
    super.initState();

    if (cameras.any(
      (element) =>
          element.lensDirection == widget.initialDirection &&
          element.sensorOrientation == 90,
    )) {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere((element) =>
            element.lensDirection == widget.initialDirection &&
            element.sensorOrientation == 90),
      );
    } else {
      _cameraIndex = cameras.indexOf(
        cameras.firstWhere(
          (element) => element.lensDirection == widget.initialDirection,
        ),
      );
    }

    _startLiveFeed();
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    Widget body;
    if (_mode == ScreenMode.liveFeed) {
      body = _liveFeedBody();
    } else {
      body = _galleryBody();
    }
    return body;
  }

  Widget _liveFeedBody() {
    if (_controller?.value.isInitialized == false) {
      return Container();
    }

    final size = MediaQuery.of(context).size;
    // calculate scale depending on screen and camera ratios
    // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    var scale = size.aspectRatio * _controller!.value.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;

    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Transform.scale(
            scale: scale,
            child: Center(
              child: CameraPreview(_controller!),
            ),
          ),
          if (widget.customPaint != null) widget.customPaint!,
        ],
      ),
    );
  }

  Widget _galleryBody() {
    return Container();
  }

  
  Future _startLiveFeed() async {
    final camera = cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }

      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  
  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex];
    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
            mlkit_commons.InputImageRotation.rotation0deg;

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ??
            mlkit_commons.InputImageFormat.nv21;

    final planeData = image.planes.map(
      (Plane plane) {
        return mlkit_commons.InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = mlkit_commons.InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage = mlkit_commons.InputImage.fromBytes(
        bytes: bytes, inputImageData: inputImageData);

    widget.onImage(inputImage);
  }
}
