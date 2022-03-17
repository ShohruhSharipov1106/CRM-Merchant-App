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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: kHeight(20.0).h),
          _titleAnimation(),
          SizedBox(height: kHeight(20.0).h),
          _subtitleField(),
          SizedBox(height: kHeight(25.0).h),
          _headlineText(context),
          SizedBox(height: kHeight(15.0).h),
          _cardNumber(context),
          _cardExpirationDate(context),
          SizedBox(height: kHeight(22.0).h),
          // ADD IF VALIDATE THEN NEXT PAGE
          _button(),
          SizedBox(height: kHeight(53.0).h),
        ],
      ),
    );
  }

  InputField _cardExpirationDate(BuildContext context) {
    return InputField(
      context.watch<AddProposalProvider>().cardExpirationDate,
      "Введите срок действия карты",
      TextInputType.number,
      (v) {
        if (v!.length < 4) return "";
        return null;
      },
      5,
      "**/**",
      "**/**",
      {"*": RegExp(r'[0-9]')},
    );
  }

  InputField _cardNumber(BuildContext context) {
    return InputField(
      context.watch<AddProposalProvider>().cardNumber,
      "Введите номер карты",
      TextInputType.number,
      (v) {
        if (v!.length < 21) return "";
        return null;
      },
      22,
      "****  ****  ****  **** ",
      "****  ****  ****  ****",
      {"*": RegExp(r'[0-9]')},
    );
  }

  Padding _button() {
    return Padding(
      padding: const EdgeInsets.only(left: kButHorPad),
      child: MainButton(
        "Выслать код",
        () => Get.to(AddProposalSmsConfirmationPage()),
      ),
    );
  }

  Padding _headlineText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kMainPadding),
      child: Text(
        "Введите данные карты",
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }

  Padding _subtitleField() {
    return const Padding(
      padding: EdgeInsets.only(left: kInpHorPad),
      child: Text(
        "Укажите Вашу зарплатную карту для проведения скоринга. На карте \nдолжна быть сумма для первоначального взноса (150 000 UZS) ",
        style: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w400,
          color: kBlackTextColor,
        ),
      ),
    );
  }

  Padding _titleAnimation() {
    return Padding(
      padding: EdgeInsets.only(left: kWidth(120.0).w),
      child: Stack(
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
    );
  }
}
