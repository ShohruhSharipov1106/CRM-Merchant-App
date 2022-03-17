import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/face_confirm/auth_face_page.dart';

class AddProposalPassportPage extends StatelessWidget {
  const AddProposalPassportPage({Key? key}) : super(key: key);

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
          _animationField(),
          SizedBox(height: kHeight(20.0).h),
          _subtitleField(),
          SizedBox(height: kHeight(25.0).h),
          _titleField(context),
          SizedBox(height: kHeight(4.0).h),
          _serialNumberOfpassport(context),
          _dateOfBirth(context),
          SizedBox(height: kHeight(7.0).h),
          // ADD IF VALIDATE THEN NEXT PAGE
          _buttonField(),
          SizedBox(height: kHeight(53.0).h),
        ],
      ),
    );
  }

  Padding _buttonField() {
    return Padding(
      padding: const EdgeInsets.only(left: kButHorPad),
      child: MainButton(
        "Аутентификация по лицу",
        () => Get.to(const AuthFacePage()),
      ),
    );
  }

  InputField _dateOfBirth(BuildContext context) {
    return InputField(
      context.watch<AddProposalProvider>().dateOfBirth,
      "Дата рождения ",
      TextInputType.number,
      (v) {
        if (v!.length < 8) return "";
        return null;
      },
      10,
      "**/**/****",
      "**/**/****",
      {"*": RegExp(r'[0-9]')},
    );
  }

  InputField _serialNumberOfpassport(BuildContext context) {
    return InputField(
      context.watch<AddProposalProvider>().serialNumberOfpassport,
      "Введите серийный номер паспорта",
      TextInputType.streetAddress,
      (v) {
        if (v!.length < 9) return "";
        return null;
      },
      25,
      "*  *  *  *  *  *  *  *  * ",
      "#  #  *  *  *  *  *  *  *",
      {
        "#": RegExp(r'[A-Z]'),
        "*": RegExp(r'[0-9]'),
      },
    );
  }

  Padding _titleField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kMainPadding),
      child: Text(
        "Введите паспортные данные",
        style: Theme.of(context).textTheme.labelMedium,
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

  Padding _animationField() {
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
            ),
          ),
          Positioned(
            child: FadeInRight(
              duration: const Duration(seconds: 5),
              child: SvgPicture.asset(
                "assets/icons/passport.svg",
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
