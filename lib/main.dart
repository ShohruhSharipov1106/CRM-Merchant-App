import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRM Merchant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       textTheme: TextTheme()
      ),
      home: const HomePage(),
    );
  }
}
