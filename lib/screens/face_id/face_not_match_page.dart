import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/face_id/camera_passport_id_page.dart';

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
            child: Text(
              "Не удалось подтвердить жизненость",
              style: TextStyle(
                fontSize: 20.0,
                color: kMainColor,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: kHeight(54.0).h,
              horizontal: kWidth(94.0),
            ),
            child: SvgPicture.asset(
              "assets/icons/face_not_match.svg",
              height: kHeight(236.0).h,
              width: kWidth(239.0).w,
            ),
          ),
          Text(
            """Протрите фронтальную камера смартфона

Убедитесь, что в комнате достаточно 
светло и на камере отчетливо видно
Ваше лицо

Держите смартфон на уровне лица, 
убедитесь, что все лицо помещается 
в кадре""",
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: kHeight(20.0).h),
          MainButton(
            "Сделать фото",
            () => Get.back(),
          ),
          SizedBox(height: kHeight(15.0).h),
          Text(
            "Или",
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: kHeight(15.0).h),
          MainButton(
            "Сделать фото паспотра",
            () => Get.to(const CameraPassportIDPage()),
          ),
          SizedBox(height: kHeight(15.0).h),
          MainButton(
            "Загрузить фото паспорта",
            () => Get.to(const CameraPassportIDPage()),
          ),
        ],
      ),
    );
  }
}
