import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/camera_id/face_id/camera_face_id_page.dart';

class AddProposalPassportPage extends StatelessWidget {
  const AddProposalPassportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: kHeight(20.0).h),
              StepsField(context, 4),
              const SizedBox(height: 20.0),
              TitleOfPage("enter_your_details"),
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
      ),
    );
  }

  ValueListenableBuilder _buttonField(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
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
                    9) {
              Get.to(const CameraFaceIDPage());
              context.read<AddProposalProvider>().hasnotError();
            } else {
              context.read<AddProposalProvider>().hasError();
            }
          },
          context.watch<AddProposalProvider>().dateOfBirth,
          v.text.length == 9 ? 10 : 30,
        );
      },
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
      9,
      "* * * * * * * * *",
      "##*******",
      {
        "#": RegExp(r'[A-Za-zЁёА-я]'),
        "*": RegExp(r'[0-9]'),
      },
    );
  }

  SizedBox _titleField(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
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
      ),
    );
  }

  LocaleText _subtitleField() {
    return const LocaleText(
      "passport_page_subtitle",
      style: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w400,
        color: kBlackTextColor,
      ),
    );
  }

  Stack _animationField(BuildContext context) {
    return Stack(
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
    );
  }
}
