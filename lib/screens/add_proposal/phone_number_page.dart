import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/card_page.dart';

class AddProposalPhoneNumberPage extends StatelessWidget {
  const AddProposalPhoneNumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: addProposalAppBar(
          context,
          "Создать заявку",
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: kHeight(50.0).h),
            Stack(
              children: [
                SizedBox(
                  height: kHeight(175).h,
                  width: kWidth(210.0).w,
                  child: SvgPicture.asset(
                    "assets/icons/main_icon.svg",
                    height: kHeight(168.88).h,
                    width: kWidth(194.0).w,
                  ),
                ),
                Positioned(
                  child: ElasticInRight(
                    duration: const Duration(seconds: 5),
                    child: SvgPicture.asset(
                      "assets/icons/document.svg",
                      height: kHeight(174.21).h,
                      width: kWidth(156.0).w,
                    ),
                  ),
                  left: -kWidth(3.0).w,
                  bottom: -kHeight(4.0).h,
                ),
              ],
            ),
            SizedBox(height: kHeight(50.0).h),
            Padding(
              padding: const EdgeInsets.only(left: kMainPadding),
              child: Text(
                "Введите номер телефона клиента ",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            SizedBox(height: kHeight(15.0).h),
            SizedBox(height: kHeight(52.0).h),
            Padding(
              padding: const EdgeInsets.only(left: kButHorPad),
              child: MainButton(
                "Продолжить",
                () => Get.to(AddProposalCardPage()),
              ),
            ),
            SizedBox(height: kHeight(53.0).h),
          ],
        ),
      ),
    );
  }
}
