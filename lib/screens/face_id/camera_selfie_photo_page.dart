import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/full_personal_information_page.dart';

class CameraSelfiePhotoPage extends StatefulWidget {
  const CameraSelfiePhotoPage({Key? key}) : super(key: key);

  @override
  State<CameraSelfiePhotoPage> createState() => _CameraSelfiePhotoPageState();
}

class _CameraSelfiePhotoPageState extends State<CameraSelfiePhotoPage> {
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
                  Locales.string(context, "selfie_photo"),
              style: const TextStyle(
                fontSize: 24.0,
                color: kWhiteColor,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          LocaleText(
            "identification_by_passport_subtitle",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 10.0,
                  color: kWhiteColor,
                ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 50,
              left: 16,
              right: 16,
            ),
            child: CustomPaint(
              foregroundPainter: BorderPainter(),
              child: Container(
                height: kHeight(450.0).h,
                width: kWidth(368.0).w,
                margin: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: kWhiteColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          MainButton(context, "take_photo", () {
            Get.to(const FullPersonalInformationPage());
          }),
        ],
      ),
    );
  }
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height; // for convenient shortage
    double sw = size.width; // for convenient shortage
    double cornerSide = sh * 0.1; // desirable value for corners side

    Paint paint = Paint()
      ..color = kWhiteColor
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
