import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/providers/add_proposal_provider.dart';
import 'package:crm_merchant/providers/home_page_provider.dart';
import 'package:crm_merchant/screens/add_proposal/card_page.dart';
import 'package:crm_merchant/screens/add_proposal/identification_page.dart';
import 'package:crm_merchant/screens/add_proposal/make_proposal_page.dart';
import 'package:crm_merchant/screens/add_proposal/passport_page.dart';
import 'package:crm_merchant/screens/add_proposal/phone_number_page.dart';
import 'package:crm_merchant/screens/auth/sign_up_page.dart';
import 'package:crm_merchant/screens/auth/sms_checker_page.dart';
import 'package:crm_merchant/screens/face_id/camera_face_id_page.dart';
import 'package:crm_merchant/screens/face_id/face_not_match_page.dart';
import 'package:crm_merchant/screens/home/home_page.dart';
import 'package:crm_merchant/screens/splash/splash_screen_page.dart';
import 'package:crm_merchant/screens/tariff/tariff_confirmation_page.dart';
import 'package:crm_merchant/screens/tariff/tariff_main_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AddProposalProvider()),
        ChangeNotifierProvider(create: (_) => HomePageProvider()),
        ChangeNotifierProvider(create: (_) => StepsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
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
                fontSize: 17.0,
                color: kBlackTextColor,
                fontWeight: FontWeight.w400,
              ),
              displayLarge: TextStyle(
                fontSize: 96.0,
                color: kWhiteColor,
                fontWeight: FontWeight.w400,
              ),
              headlineLarge: TextStyle(
                fontSize: 24.0,
                color: kBlackTextColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            scaffoldBackgroundColor: kBackgroundColor,
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ),
          home: const CameraFaceIDPage()
          // home: GetStorage().read("splashDone") == "splashDone"
          //     ? (GetStorage().read("signUpDone") == "signUpDone"
          //         ? const HomePage()
          //         : const SignUpPage())
          //     : const SplashScreenPage(),
          ,
         
        );
      },
    );
  }
}
