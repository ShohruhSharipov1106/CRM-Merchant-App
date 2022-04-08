import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/make_proposal_page.dart';

class IdentificationPage extends StatelessWidget {
  const IdentificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kHeight(20.0).h),
            Container(
              height: kHeight(32.0).h,
              padding: EdgeInsets.only(left: kWidth(kMainPadding).w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    child: const Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 21.0,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  TitleOfPage("Идентификация", kWidth(90.0).w),
                ],
              ),
            ),
            SizedBox(height: kHeight(10.0).h),
            _titleAnimation(),
            SizedBox(height: kHeight(11.0).h),
            _titleField(context),
            SizedBox(height: kHeight(20.0).h),
            _mainBody(context),
            SizedBox(height: kHeight(310.0).h),
            _button(context),
            SizedBox(height: kHeight(20.0).h),
          ],
        ),
      ),
    );
  }

  Container _mainBody(BuildContext context) {
    return Container(
            height: kHeight(235.0).h,
            width: kWidth(316.0).w,
            margin: EdgeInsets.symmetric(horizontal: kWidth(56.0).w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: kWhiteColor,
            ),
            padding: EdgeInsets.symmetric(horizontal: kWidth(kMainPadding).w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _pieceOfInformations(
                  context,
                  "Ф.И.О",
                  "VIKTOR KAMAROV VIKTOROVICH",
                ),
                _pieceOfInformations(
                  context,
                  "Адрес прописки",
                  " г.Ташкент,Садыка Азимова,1/28",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _pieceOfInformations(
                      context,
                      "Номер паспорта",
                      "АА1564457",
                    ),
                    _pieceOfInformations(
                      context,
                      "Дата рождения",
                      "11.04.2020",
                    ),
                  ],
                ),
                _pieceOfInformations(
                  context,
                  "Номер телефона",
                  "+998 90 900 90 90",
                ),
              ],
            ),
          );
  }

  Column _pieceOfInformations(
    BuildContext context,
    String title,
    String informText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontSize: 10.0,
              ),
        ),
        SizedBox(height: kHeight(5.0).h),
        Text(
          informText,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
      ],
    );
  }

  Padding _titleField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kMainPadding),
      child: Text(
        "Проверьте свои данные",
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }

  Padding _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kButHorPad),
      child: MainButton(
        "Продолжить",
        () {
          Get.to(const MakeProposalPage());
        },
      ),
    );
  }

  Padding _titleAnimation() {
    return Padding(
      padding: EdgeInsets.only(left: kWidth(130.0).w),
      child: Stack(
        children: [
          SizedBox(
            height: kHeight(130.0).h,
            width: kWidth(165.0).w,
            child: SvgPicture.asset(
              "assets/icons/main_icon.svg",
              height: kHeight(121.07).h,
              width: kWidth(130.05).w,
            ),
          ),
          Positioned(
            child: FadeIn(
              duration: const Duration(seconds: 5),
              child: SvgPicture.asset(
                "assets/icons/passport.svg",
                height: kHeight(86.5).h,
                width: kWidth(86).w,
              ),
            ),
            left: 0,
            bottom: 0,
          ),
          Positioned(
            child: FadeInDown(
              duration: const Duration(seconds: 5),
              child: SvgPicture.asset(
                "assets/icons/check.svg",
                height: kHeight(25.0).h,
                width: kWidth(25.0).w,
              ),
            ),
            right: kWidth(75.0).w,
            bottom: kHeight(75.0).h,
          ),
        ],
      ),
    );
  }
}
