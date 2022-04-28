import 'package:crm_merchant/constants/exports.dart';

import 'package:crm_merchant/screens/auth/sign_up_page.dart';
import 'package:crm_merchant/screens/home/home_page.dart';

class SelectLangPage extends StatefulWidget {
  const SelectLangPage({Key? key}) : super(key: key);

  @override
  State<SelectLangPage> createState() => _SelectLangPageState();
}

class _SelectLangPageState extends State<SelectLangPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: kWidth(50.0).w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: kHeight(100.0).h),
            TitleOfPage(
              "choose_language",
              0,
            ),
            SizedBox(height: kHeight(60.0).h),
            SvgPicture.asset("assets/icons/language.svg"),
            SizedBox(height: kHeight(55.0).h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _langButton(context, "Русский",
                    chosenLanguage == const Locale('ru'), 'ru'),
                SizedBox(width: kWidth(20.0).w),
                _langButton(context, "O'zbek",
                    chosenLanguage == const Locale('uz'), 'uz'),
              ],
            ),
            SizedBox(height: kHeight(180.0).h),
            MainButton(context, "continue", () {
              if (isFirstTime.read("firstTime") == "firstTime") {
                Get.off(const HomePage());
              } else {
                isFirstTime.write("firstTime", "firstTime");
                Get.off(const SignUpPage());
              }
            }),
          ],
        ),
      ),
    );
  }

  ElevatedButton _langButton(
      BuildContext context, String title, bool isUzbek, String lang) {
    return ElevatedButton(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      style: ElevatedButton.styleFrom(
        primary: !isUzbek ? kUnselectedLangColor : kYellowButtonColor,
        fixedSize: Size(
          kWidth(153.0).w,
          kHeight(60.0).h,
        ),
        minimumSize: Size(
          kWidth(153.0).w,
          kHeight(60.0).h,
        ),
        elevation: 4.0,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onPressed: () {
        setState(() {});
        chosenLanguage = Locale(lang);
        Get.updateLocale(chosenLanguage);
      },
    );
  }
}
