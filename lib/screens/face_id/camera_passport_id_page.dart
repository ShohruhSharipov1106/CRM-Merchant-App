import 'package:crm_merchant/constants/exports.dart';

class CameraPassportIDPage extends StatelessWidget {
  const CameraPassportIDPage({Key? key}) : super(key: key);

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
          const Center(
            child: Text(
              "Идетификация по паспорту",
              style: TextStyle(
                fontSize: 24.0,
                color: kWhiteColor,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: kHeight(50.0).h,
              horizontal: kWidth(kMainPadding).w,
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
          Text(
            "Сделайте фото с камеры для идентификации по паспорту",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 10.0,
                  color: kWhiteColor,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: kHeight(50.0).h),
          MainButton(
            "Сделать фото",
            () => Get.to(const CameraPassportIDPage()),
         
          ),
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