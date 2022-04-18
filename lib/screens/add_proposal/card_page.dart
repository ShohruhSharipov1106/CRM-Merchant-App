import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/sms_confirmation_page.dart';

class AddProposalCardPage extends StatelessWidget {
  const AddProposalCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kHeight(20.0).h),
            StepsField(context, 2),
            SizedBox(height: kHeight(20.0).h),
            TitleOfPage("Введите ваши данные", kWidth(88.0).w),
            SizedBox(height: kHeight(5.0).h),
            _titleAnimation(context),
            SizedBox(height: kHeight(20.0).h),
            _subtitleField(),
            SizedBox(height: kHeight(25.0).h),
            _headlineText(context),
            SizedBox(height: kHeight(15.0).h),
            Form(
              key: context.watch<AddProposalProvider>().formKey,
              child: Column(
                children: [
                  _cardNumber(context),
                  _cardExpirationDate(context),
                ],
              ),
            ),
            SizedBox(height: kHeight(22.0).h),
            _button(context),
            SizedBox(height: kHeight(53.0).h),
          ],
        ),
      ),
    );
  }

  Padding _titleAnimation(BuildContext context) {
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
              color: context.watch<AddProposalProvider>().isError
                  ? kErrorAnimationColor
                  : kMainColor,
            ),
          ),
          Positioned(
            child: FlipInX(
              duration: const Duration(seconds: 5),
              child: SvgPicture.asset(
                context.watch<AddProposalProvider>().isError
                    ? "assets/icons/error-card.svg"
                    : "assets/icons/card.svg",
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

  InputField _cardExpirationDate(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().cardExpirationDate,
      "Введите срок действия карты",
      "Неверный срок действия карты ",
      TextInputType.number,
      5,
      "**/**",
      "**/**",
      {"*": RegExp(r'[0-9]')},
    );
  }

  InputField _cardNumber(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().cardNumber,
      "Введите номер карты",
      "Неверный номер карты",
      TextInputType.number,
      22,
      "****  ****  ****  **** ",
      "****  ****  ****  ****",
      {"*": RegExp(r'[0-9]')},
    );
  }

  Padding _button(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: kButHorPad),
      child: ValueListenableBuilder<TextEditingValue>(
          valueListenable: context.read<AddProposalProvider>().cardNumber,
          builder: (context, v, child) {
            return ListenableButton(
              "Выслать код",
              () {
                if (context
                            .read<AddProposalProvider>()
                            .cardNumber
                            .text
                            .length ==
                        22 &&
                    context
                            .read<AddProposalProvider>()
                            .cardExpirationDate
                            .text
                            .length ==
                        5) {
                  Get.to(const AddProposalSmsConfirmationPage());
                  context.read<AddProposalProvider>().cardNumber.clear();
                  context
                      .read<AddProposalProvider>()
                      .cardExpirationDate
                      .clear();
                  context.read<AddProposalProvider>().hasnotError();
                } else {
                  context.read<AddProposalProvider>().hasError();
                }
              },
              context.watch<AddProposalProvider>().cardExpirationDate,
              v.text.length == 22 ? 5 : 10,
            );
          }),
    );
  }

  Padding _headlineText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kMainPadding),
      child: Text(
        context.watch<AddProposalProvider>().isError
            ? "Неверные данные карты"
            : "Введите данные карты",
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: context.watch<AddProposalProvider>().isError
                  ? kMainColor
                  : kBlackTextColor,
            ),
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
}
