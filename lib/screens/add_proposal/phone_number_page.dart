import 'package:crm_merchant/components/generate_rand_number.dart';
import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/home/offer_confirmation_page.dart';
import 'package:crm_merchant/services/create_request_service.dart';

class AddProposalPhoneNumberPage extends StatefulWidget {
  const AddProposalPhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<AddProposalPhoneNumberPage> createState() =>
      _AddProposalPhoneNumberPageState();
}

class _AddProposalPhoneNumberPageState
    extends State<AddProposalPhoneNumberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kHeight(20.0).h),
            StepsField(context, 1),
            SizedBox(height: kHeight(20.0).h),
            TitleOfPage("Создать заявку", kWidth(126.0).w),
            SizedBox(height: kHeight(25.0).h),
            _titleAnimation(context),
            SizedBox(height: kHeight(50.0).h),
            _titleField(context),
            SizedBox(height: kHeight(15.0).h),
            _inputField(context),
            SizedBox(height: kHeight(52.0).h),
            _button(context),
            SizedBox(height: kHeight(53.0).h),
          ],
        ),
      ),
    );
  }

  Padding _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kButHorPad),
      child: ListenableButton(
       context,
                            'continue',
        () {
          if (context
                  .read<AddProposalProvider>()
                  .addProposalPhoneNumber
                  .text
                  .length ==
              17) {
            context.read<AddProposalProvider>().getPhoneNumber();
            GetRandNum();
            print(GetRandNum.checkSMS);
            phoneNumVarElement =
                context.read<AddProposalProvider>().addProposalPhoneNumber.text;
            Get.to(const OfferConfirmationPage());
            context.read<AddProposalProvider>().hasnotError();
          } else {
            context.read<AddProposalProvider>().hasError();
          }
        },
        context.watch<AddProposalProvider>().addProposalPhoneNumber,
        17,
      ),
    );
  }

  Padding _titleField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kMainPadding),
      child: Text(
        context.watch<AddProposalProvider>().isError
            ? "Недопустимый номер телефона"
            : "Введите номер телефона клиента ",
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: context.watch<AddProposalProvider>().isError
                  ? kMainColor
                  : kBlackTextColor,
            ),
      ),
    );
  }

  InputField _inputField(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().addProposalPhoneNumber,
      "Введите ваш номер телефона",
      "Недопустимый номер телефона",
      TextInputType.number,
      17,
      "+ 998** *** ** ** ",
      "+ 998## ### ## ##",
      {"#": RegExp(r'[0-9]')},
    );
  }

  Padding _titleAnimation(BuildContext context) {
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
              color: context.watch<AddProposalProvider>().isError
                  ? kErrorAnimationColor
                  : kMainColor,
            ),
          ),
          Positioned(
            child: ElasticInRight(
              duration: const Duration(seconds: 5),
              child: SvgPicture.asset(
                context.watch<AddProposalProvider>().isError
                    ? "assets/icons/error-document.svg"
                    : "assets/icons/document.svg",
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
