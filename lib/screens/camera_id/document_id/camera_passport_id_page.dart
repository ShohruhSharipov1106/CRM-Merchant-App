import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/camera_id/document_id/camera_address_page.dart';

class CameraPassportIDPage extends StatefulWidget {
  const CameraPassportIDPage({Key? key}) : super(key: key);

  @override
  State<CameraPassportIDPage> createState() => _CameraPassportIDPageState();
}

class _CameraPassportIDPageState extends State<CameraPassportIDPage> {
  // final TextRecognizer _textRecognizer = TextRecognizer();
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;

  @override
  void dispose() async {
    _canProcess = false;
    // _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Center(
            child: Text(
              Locales.string(context, "identification_by_passport") +
                  "\n" +
                  Locales.string(context, "passport_photo"),
              style: const TextStyle(
                fontSize: 24.0,
                color: kWhiteColor,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: kHeight(10.0).h),
          LocaleText(
            "identification_by_passport_subtitle",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 10.0,
                  color: kWhiteColor,
                ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: kHeight(20.0).h,
              bottom: kHeight(50.0).h,
              left: kWidth(kMainPadding).w,
              right: kWidth(kMainPadding).w,
            ),
            child: CustomPaint(
              foregroundPainter: BorderPainter(),
              child: Container(
                height: kHeight(515.0).h,
                width: kWidth(368.0).w,
                margin: EdgeInsets.symmetric(
                  vertical: kHeight(15.0).h,
                  horizontal: kWidth(14.0).w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: kWhiteColor,
                ),
              ),
            ),
          ),
          SizedBox(height: kHeight(20.0).h),
          MainButton(
            context,
            "take_photo",
            () => Get.off(const CameraAddressPage()),
          ),
        ],
      ),
    );
  }

  // Future<void> processImage(InputImage inputTextImage) async {
  //   if (!_canProcess) return;
  //   if (_isBusy) return;
  //   _isBusy = true;
  //   setState(() {
  //     _text = '';
  //   });
  //   final recognizedText = await _textRecognizer.processImage(inputTextImage);
  //   if (inputTextImage.inputImageData?.size != null &&
  //       inputTextImage.inputImageData?.imageRotation != null) {
  //     final painter = TextRecognizerPainter(
  //         recognizedText,
  //         inputTextImage.inputImageData!.size,
  //         inputTextImage.inputImageData!.imageRotation);
  //     _customPaint = CustomPaint(painter: painter);
  //   } else {
  //     _text = 'Recognized text:\n\n${recognizedText.text}';
  //     // TODO: set _customPaint to draw boundingRect on top of image
  //     _customPaint = null;
  //   }
  //   _isBusy = false;
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }
}

// class BorderPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     double sh = size.height; // for convenient shortage
//     double sw = size.width; // for convenient shortage
//     double cornerSide = sh * 0.1; // desirable value for corners side

//     Paint paint = Paint()
//       ..color = kWhiteColor
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     Path path = Path()
//       ..moveTo(cornerSide, 0)
//       ..quadraticBezierTo(0, 0, 0, cornerSide)
//       ..moveTo(0, sh - cornerSide)
//       ..quadraticBezierTo(0, sh, cornerSide, sh)
//       ..moveTo(sw - cornerSide, sh)
//       ..quadraticBezierTo(sw, sh, sw, sh - cornerSide)
//       ..moveTo(sw, cornerSide)
//       ..quadraticBezierTo(sw, 0, sw - cornerSide, 0);

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(BorderPainter oldDelegate) => false;

//   @override
//   bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
// }