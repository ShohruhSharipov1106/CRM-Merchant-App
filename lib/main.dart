import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/card_added_successfully_page.dart';
import 'package:crm_merchant/screens/add_proposal/list_of_item_page.dart';
import 'package:crm_merchant/screens/add_proposal/make_proposal_page.dart';
import 'package:crm_merchant/screens/add_proposal/passport_identification_page.dart';
import 'package:crm_merchant/screens/add_proposal/phone_number_page.dart';
import 'package:crm_merchant/screens/auth/sign_up_page.dart';
import 'package:crm_merchant/screens/face_id/camera_face_id_page.dart';
import 'package:crm_merchant/screens/face_id/camera_passport_id_page.dart';
import 'package:crm_merchant/screens/splash/splash_screen_page.dart';
import 'package:crm_merchant/screens/tariff/tariff_confirmation_page.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          home:  const ListOfItem()
          // home:const CameraFaceIDPage()
        );
      },
    );
  }
}
