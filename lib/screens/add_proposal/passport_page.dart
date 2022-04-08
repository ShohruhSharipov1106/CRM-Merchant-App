import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/face_id/camera_face_id_page.dart';
import 'package:flutter/material.dart';

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
            SizedBox(height: kHeight(20.0).h),
            StepsField(context, 4),
            SizedBox(height: kHeight(20.0).h),
            TitleOfPage("Введите ваши данные", kWidth(88.0).w),
            SizedBox(height: kHeight(5.0).h),
            _animationField(context),
            SizedBox(height: kHeight(20.0).h),
            _subtitleField(),
            SizedBox(height: kHeight(25.0).h),
            _titleField(context),
            SizedBox(height: kHeight(4.0).h),
            _serialNumberOfpassport(context),
            _dateOfBirth(context),
            SizedBox(height: kHeight(7.0).h),
            _buttonField(context),
            SizedBox(height: kHeight(53.0).h),
          ],
        ),
      ),
    );
  }

  Padding _buttonField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kButHorPad),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable:
            context.watch<AddProposalProvider>().serialNumberOfpassport,
        builder: (context, v, child) {
          return ListenableButton(
            "Аутентификация по лицу",
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

  InputField _dateOfBirth(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().dateOfBirth,
      "Дата рождения ",
      "Недопустимая дата рождения",
      TextInputType.number,
      16,
      "**/**/****",
      "**/%%/####",
      {
        // "@": RegExp(r'[0-3]'),
        "*": RegExp(r'[0-9]'),
        "%": RegExp(r'[0-9]'),
        "#": RegExp(r'[0-9]'),
      },
    );
  }

  InputField _serialNumberOfpassport(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().serialNumberOfpassport,
      "Введите серийный номер паспорта",
      "Неверный срок действия карты ",
      TextInputType.visiblePassword,
      26,
      "*  *  *  *  *  *  *  *  * ",
      "#  #  *  *  *  *  *  *  *",
      {
        "#": RegExp(r'[A-Za-z]'),
        "*": RegExp(r'[0-9]'),
      },
      capitalText: true,
    );
  }

  Padding _titleField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kMainPadding),
      child: Text(
        context.watch<AddProposalProvider>().isError
            ? "Неверные паспортные данные"
            : "Введите паспортные данные",
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
        "Введите номер паспорта и дату рождения. Затем сделайте селфи с \nкамеры для аутентификации по лицу",
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
