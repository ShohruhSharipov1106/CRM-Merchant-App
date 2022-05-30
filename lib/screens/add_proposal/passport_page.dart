import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/camera_id/face_id/camera_face_id_page.dart';
class AddProposalPassportPage extends StatelessWidget {
  const AddProposalPassportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            StepsField(context, 4),
            const SizedBox(height: 20.0),
            TitleOfPage("enter_your_details", kWidth(65.0).w),
            const SizedBox(height: 5.0),
            _animationField(context),
            const SizedBox(height: 20.0),
            _subtitleField(),
            const SizedBox(height: 25.0),
            _titleField(context),
            const SizedBox(height: 4.0),
            _serialNumberOfpassport(context),
            _dateOfBirth(context),
            const SizedBox(height: 10.0),
            _buttonField(context),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }

  Padding _buttonField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: kWidth(kButHorPad).w),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable:
            context.watch<AddProposalProvider>().serialNumberOfpassport,
        builder: (context, v, child) {
          return ListenableButton(
            context,
            "go_identification",
            () {
              if (context.read<AddProposalProvider>().dateOfBirth.text.length ==
                      10 &&
                  context
                          .read<AddProposalProvider>()
                          .serialNumberOfpassport
                          .text
                          .length ==
                      25) {
                Get.to(const CameraFaceIDPage());
                context.read<AddProposalProvider>().hasnotError();
              } else {
                context.read<AddProposalProvider>().hasError();
              }
            },
            context.watch<AddProposalProvider>().dateOfBirth,
            v.text.length == 25 ? 10 : 30,
          );
        },
      ),
    );
  }

  CalendarInputField _dateOfBirth(BuildContext context) {
    return CalendarInputField(
      context,
      context.watch<AddProposalProvider>().dateOfBirth,
      "birthday",
      "error_birthday",
      "**/**/****",
      "dd/MM/yyyy",
      DateTime(1900),
      DateTime.now(),
    );
  }

  InputField _serialNumberOfpassport(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().serialNumberOfpassport,
      "serial_number_passport",
      "serial_number_passport_error",
      TextInputType.visiblePassword,
      25,
      "*  *  *  *  *  *  *  *  * ",
      "#  #  *  *  *  *  *  *  *",
      {
        "#": RegExp(r'[A-Za-zЁёА-я]'),
        "*": RegExp(r'[0-9]'),
      },
    );
  }

  Padding _titleField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: kWidth(kMainPadding).w),
      child: LocaleText(
        context.watch<AddProposalProvider>().isError
            ? "error_passport_details"
            : "passport_details",
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: context.watch<AddProposalProvider>().isError
                  ? kMainColor
                  : kBlackTextColor,
            ),
      ),
    );
  }

  Padding _subtitleField() {
    return Padding(
      padding: EdgeInsets.only(left: kWidth(65.0).w),
      child: const LocaleText(
        "passport_page_subtitle",
        style: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w400,
          color: kBlackTextColor,
        ),
      ),
    );
  }

  Padding _animationField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: kWidth(130.0).w),
      child: Stack(
        children: [
          SizedBox(
            height: kHeight(122.06).h,
            width: kWidth(168.0).w,
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
            child: FadeInRight(
              duration: const Duration(seconds: 5),
              child: SvgPicture.asset(
                context.watch<AddProposalProvider>().isError
                    ? "assets/icons/error-passport.svg"
                    : "assets/icons/passport.svg",
                height: kHeight(88.87).h,
                width: kWidth(88.16).w,
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
