import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/auth/sign_up_page.dart';
import 'package:crm_merchant/screens/auth/sms_checker_page.dart';
import 'package:crm_merchant/screens/home/home_page.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
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
          ),
          scaffoldBackgroundColor: kBackgroundColor,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ),
        home: SmsCheckerPage(),
      );
    });
  }
}
