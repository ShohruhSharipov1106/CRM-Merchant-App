import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/providers/add_proposal_provider.dart';
import 'package:crm_merchant/screens/add_proposal/card_page.dart';
import 'package:crm_merchant/screens/add_proposal/passport_page.dart';
import 'package:crm_merchant/screens/add_proposal/phone_number_page.dart';
import 'package:crm_merchant/screens/auth/sign_up_page.dart';
import 'package:crm_merchant/screens/home/home_page.dart';
import 'package:crm_merchant/screens/splash/splash_screen_page.dart';
import 'package:crm_merchant/screens/tariff/tariff_main_page.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AddProposalProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'CRM Merchant',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Roboto",
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 40.0,
              color: kBlackTextColor,
              fontWeight: FontWeight.w400,
            ),
            titleMedium: TextStyle(
              fontSize: 20.0,
              color: kBlackTextColor,
              fontWeight: FontWeight.w400,
            ),
            labelMedium: TextStyle(
              fontSize: 18.0,
              color: kBlackTextColor,
              fontWeight: FontWeight.w400,
            ),
            displayLarge: TextStyle(
              fontSize: 96.0,
              color: kWhiteColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          scaffoldBackgroundColor: kBackgroundColor,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ),
        home: GetStorage().read("splashDone") == "splashDone"
            ? (GetStorage().read("signUpDone") == "signUpDone"
                ? const HomePage()
                : const SignUpPage())
            : const SplashScreenPage(),
      );
    });
  }
}
