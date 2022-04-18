import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/identification_page.dart';

class PassportIdentificationPage extends StatelessWidget {
  const PassportIdentificationPage({Key? key}) : super(key: key);

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
        leadingWidth: 15.0,
        title: Text(
          "Идентификация по паспорту",
          style: Theme.of(context).textTheme.headlineLarge,
          overflow: TextOverflow.visible,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kHeight(50.0).h),
            Padding(
              padding: EdgeInsets.only(
                left: kMainPadding,
                top: kHeight(20.0).h,
                bottom: kHeight(15.0).h,
              ),
              child: Text(
                "1.Загрузите фото паспорта  ",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            _photoField(),
            Padding(
              padding: EdgeInsets.only(
                left: kMainPadding,
                top: kHeight(20.0).h,
                bottom: kHeight(15.0).h,
              ),
              child: Text(
                "2.Загрузите фото прописки",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            _photoField(),
            Padding(
              padding: EdgeInsets.only(
                left: kMainPadding,
                top: kHeight(20.0).h,
                bottom: kHeight(15.0).h,
              ),
              child: Text(
                "3.Загрузите фото паспорта на фоне лица",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            _photoField(),
            Padding(
              padding: EdgeInsets.only(
                top: kHeight(50.0).h,
                left: kWidth(78.0).w,
              ),
              child: MainButton("Продолжить", () {
                Get.to(const IdentificationPage());
              }),
            ),
          ],
        ),
      ),
    );
  }

  Container _photoField() {
    return Container(
      height: kHeight(60).h,
      width: kWidth(60.0).w,
      margin: EdgeInsets.only(left: kWidth(31.0).w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: kWhiteColor,
        border: Border.all(
          color: kBlackTextColor,
          width: 1.0,
        ),
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.add,
        size: 28.0,
        color: kBlackTextColor,
      ),
    );
  }
}
