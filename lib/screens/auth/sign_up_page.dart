import 'package:crm_merchant/components/input_field.dart';
import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/auth/sms_checker_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpProvider contexPro = context.watch<SignUpProvider>();
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kHeight(72.0).h),
            Padding(
              padding: EdgeInsets.only(left: kWidth(140.0).w),
              child: Text(
                "Привет!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(height: kHeight(80.0).h),
            Padding(
              padding: const EdgeInsets.only(left: kMainPadding),
              child: Text(
                "Введите данные",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            SizedBox(height: kHeight(10.5).h),
            Form(
              key: contexPro.formKey,
              child: Column(
                children: [
                  InputField(
                    contexPro.nameController,
                    "Введите ваше имя",
                    TextInputType.name,
                    (v) {
                      if (v!.length < 2) return "";
                      return null;
                    },
                    30,
                  ),
                  InputField(
                    contexPro.phoneController,
                    "Введите ваш номер телефона",
                    TextInputType.number,
                    (v) {
                      if (v!.length < 6) return "";
                      return null;
                    },
                    7,
                    hasPrefix: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: kHeight(100.0).h),
            Padding(
              padding: const EdgeInsets.only(left: kButHorPad),
              child: MainButton(
                "Продолжить",
                () => context.read<SignUpProvider>().isValidateFunc() == true
                    ? Get.to(const SmsCheckerPage())
                    : () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
