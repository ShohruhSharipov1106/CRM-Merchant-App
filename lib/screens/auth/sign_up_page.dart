import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/models/api_account/token_model.dart';
import 'package:crm_merchant/screens/auth/sms_checker_page.dart';

import 'package:http/http.dart' as http;

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpProvider contexPro = context.watch<SignUpProvider>();
    return Scaffold(
      body: ZoomIn(
        duration: const Duration(seconds: 2),
        child: SafeArea(
          child: Column(
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
              InputField(
                context,
                contexPro.nameController,
                "Введите ваше имя",
                "Недопустимое имя",
                TextInputType.name,
                30,
                "* * * * * * * * * * * * * * *",
                "##############################",
                {"#": RegExp(r'[A-Za-z]')},
              ),
              InputField(
                context,
                contexPro.phoneController,
                "Введите ваш номер телефона",
                "Недопустимый номер телефона",
                TextInputType.visiblePassword,
                8,
                "+ 998** *** ** ** ",
                "########",
                {"#": RegExp(r'[4f?$@VK3]')},
              ),
              SizedBox(height: kHeight(100.0).h),
              Padding(
                padding: const EdgeInsets.only(left: kButHorPad),
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable:
                      context.watch<SignUpProvider>().nameController,
                  builder: (context, v, child) {
                    return ListenableButton(
                      "Продолжить",
                      () async {
                        await _postTokenfromApi(
                          contexPro.nameController.text,
                          contexPro.phoneController.text,
                        );
                        context
                                        .read<SignUpProvider>()
                                        .nameController
                                        .text
                                        .length >
                                    2 &&
                                context
                                        .read<SignUpProvider>()
                                        .phoneController
                                        .text
                                        .length ==
                                    8
                            ? Get.to(const SmsCheckerPage())
                            : () {};
                      },
                      context.watch<SignUpProvider>().phoneController,
                      v.text.length > 2 ? 8 : 30,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _postTokenfromApi(
      String userName, String password) async {
    Uri url = Uri.parse('https://crm.creditexpress.uz:6262/api/account/token');
    var res = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
        "charset": "utf-8"
      },
      body: json.encode({"userName": userName, "password": password}),
    );

    if (res.statusCode == 200) {
      print("object 2");
      print(res.body);
      return res.body;
    } else {
      throw Exception('Xato bor: ${res.statusCode}');
    }
  }
}
