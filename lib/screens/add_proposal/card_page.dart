import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/sms_confirmation_page.dart';

class AddProposalCardPage extends StatelessWidget {
  const AddProposalCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addProposalAppBar(
        context,
        "Введите ваши данные",
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: kHeight(20.0).h),
          Stack(
            children: [
              SizedBox(
                height: kHeight(122.06).h,
                width: kWidth(172.0).w,
                child: SvgPicture.asset(
                  "assets/icons/main_icon.svg",
                  height: kHeight(122.06).h,
                  width: kWidth(131.12).w,
                ),
              ),
              Positioned(
                child: FlipInX(
                  duration: const Duration(seconds: 5),
                  child: SvgPicture.asset(
                    "assets/icons/card.svg",
                    height: kHeight(110.28).h,
                    width: kWidth(110.29).w,
                  ),
                ),
                left: 0,
                bottom: 0,
              ),
            ],
          ),
          SizedBox(height: kHeight(20.0).h),
          SizedBox(height: kHeight(25.0).h),
          Padding(
            padding: const EdgeInsets.only(left: kMainPadding),
            child: Text(
              "Введите данные карты",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          SizedBox(height: kHeight(15.0).h),
          SizedBox(height: kHeight(22.0).h),
          Padding(
            padding: const EdgeInsets.only(left: kButHorPad),
            child: MainButton(
              "Выслать код",
              () => Get.to(AddProposalSmsConfirmationPage()),
            ),
          ),
          SizedBox(height: kHeight(53.0).h),
        ],
      ),
    );
  }
}
