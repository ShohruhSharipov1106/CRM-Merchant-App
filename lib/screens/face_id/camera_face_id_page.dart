import 'package:crm_merchant/constants/exports.dart';

class CameraFaceIDPage extends StatelessWidget {
  const CameraFaceIDPage({Key? key}) : super(key: key);

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
            color: kBlackTextColor,
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/unselected-oval-frame.png"),
                fit: BoxFit.cover,
              ),
              color: kBlackTextColor,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.elliptical(
                    kWidth(360.0).w,
                    kHeight(515.0).h,
                  ),
                ),
                color: kWhiteColor,
              ),
            ),
          ),
          Text(
            "Пожалуйста держите голову прямо ",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 10.0,
                  color: kWhiteColor,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: kHeight(50.0).h),
          MainButton(
            "Сделать фото",
            () {},
          
          ),
        ],
      ),
    );
  }
}
