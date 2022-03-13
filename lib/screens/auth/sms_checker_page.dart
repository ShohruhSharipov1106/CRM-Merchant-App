import 'package:crm_merchant/constants/exports.dart';

class SmsCheckerPage extends StatelessWidget {
  const SmsCheckerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Подтверждение"),
          Text("Введите код SMS подтверждения"),
          TextButton(
            child: Text("Не пришло SMS ?"),
            onPressed: () {},
          ),
          MainButton(
            "Продолжить",
            () {},
          ),
        ],
      ),
    );
  }
}
