import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/auth/sign_up_page.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ProfileMenuPage extends StatefulWidget {
  const ProfileMenuPage({Key? key}) : super(key: key);

  @override
  State<ProfileMenuPage> createState() => _ProfileMenuPageState();
}

class _ProfileMenuPageState extends State<ProfileMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Padding(
        padding: EdgeInsets.only(
          left: kWidth(30.0).w,
          top: kHeight(120.0).h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToggleSwitch(
              minWidth: kWidth(50.0).w,
              minHeight: kHeight(50.0).h,
              cornerRadius: 20.0,
              borderColor: const [kWhiteColor],
              borderWidth: 1.0,
              activeBgColors: const [
                [kWhiteColor],
                [kWhiteColor]
              ],
              inactiveBgColor: kMainColor,
              initialLabelIndex: chosenLanguage == const Locale('ru') ? 0 : 1,
              totalSwitches: 2,
              changeOnTap: false,
              labels: const ['RU', 'UZ'],
              customTextStyles: [Theme.of(context).textTheme.labelMedium],
              radiusStyle: true,
              onToggle: (index) {
                Get.updateLocale(index == 0
                    ? chosenLanguage = const Locale('ru')
                    : chosenLanguage = const Locale('uz'));
              },
            ),
            SizedBox(height: kHeight(28.0).h),
            InkWell(
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/log-out.svg",
                    height: kHeight(33.0).h,
                    width: kWidth(33.0).w,
                  ),
                  SizedBox(width: kWidth(11.0).w),
                  const LocaleText(
                    'log_out',
                    style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              onTap: () => _logOut(),
            ),
          ],
        ),
      ),
    );
  }

  _logOut() {
    Get.offAll(const SignUpPage());
    clientMainData.remove("username");
    clientMainData.remove('password');
    clientMainData.remove('token');
    clientMainData.remove('expData');
  }
}
