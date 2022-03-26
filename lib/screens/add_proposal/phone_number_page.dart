import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/card_page.dart';

class AddProposalPhoneNumberPage extends StatelessWidget {
  const AddProposalPhoneNumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kHeight(20.0).h),
            const StepsField(),
            SizedBox(height: kHeight(20.0).h),
            TitleOfPage("Создать заявку", kWidth(126.0).w),
            SizedBox(height: kHeight(25.0).h),
            _titleAnimation(),
            SizedBox(height: kHeight(50.0).h),
            _titleField(context),
            SizedBox(height: kHeight(15.0).h),
            _inputField(context),
            SizedBox(height: kHeight(52.0).h),
            // ADD IF VALIDATE THEN NEXT PAGE
            _button(context),
            SizedBox(height: kHeight(53.0).h),
          ],
        ),
      ),
    );
  }

  Padding _titleField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kMainPadding),
      child: Text(
        "Введите номер телефона клиента ",
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }

  InputField _inputField(BuildContext context) {
    return InputField(
      context.watch<AddProposalProvider>().addProposalPhoneNumber,
      "Введите ваш номер телефона",
      TextInputType.number,
      (v) {
        if (v!.length < 11) return "";
        return null;
      },
      12,
      "** *** ** ** ",
      "## ### ## ##",
      {"#": RegExp(r'[0-9]')},
      hasPrefix: true,
    );
  }

  Padding _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kButHorPad),
      child: MainButton(
        "Продолжить",
        () {
          Get.to(AddProposalCardPage());
          context.read<StepsProvider>().incrementStep();
        },
      ),
    );
  }

  Padding _titleAnimation() {
    return Padding(
      padding: EdgeInsets.only(left: kWidth(100.0).w),
      child: Stack(
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
    );
  }
}
