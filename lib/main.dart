import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/core/token.dart';
import 'package:crm_merchant/screens/auth/select_lang_page.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['ru', 'uz']);
  cameras = await availableCameras();
  // final firstCamera = cameras.last;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AddProposalProvider()),
        ChangeNotifierProvider(create: (_) => HomePageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(
      builder: (locale) {
        return Sizer(builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            title: 'CRM Merchant',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: Locales.delegates,
            supportedLocales: Locales.supportedLocales,
            locale: locale,
            fallbackLocale: const Locale('ru'),
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
            home: const SelectLangPage(),
          );
        });
      },
    );
  }
}
