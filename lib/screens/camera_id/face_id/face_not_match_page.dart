import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/camera_id/document_id/camera_passport_id_page.dart';
import 'package:crm_merchant/screens/camera_id/face_id/camera_face_id_page.dart';

class FaceNotMatch extends StatelessWidget {
  const FaceNotMatch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: LocaleText(
              "failed_viability",
              style: TextStyle(
                fontSize: 20.0,
                color: kMainColor,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 27,
              horizontal: 94,
            ),
            child: SvgPicture.asset(
              "assets/icons/face_not_match.svg",
              height: kHeight(236.0).h,
              width: kWidth(239.0).w,
            ),
          ),
          LocaleText(
            "subtitle_take_photo",
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(fontSize: 15.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50.0),
          MainButton(
            context,
            "take_photo",
            () => Get.off(const CameraFaceIDPage()),
          ),
          const SizedBox(height: 30.0),
          MainButton(
            context,
            "take_passport_photo",
            () => Get.to(const CameraPassportIDPage()),
          ),
        ],
      ),
    );
  }
}
