import 'package:crm_merchant/constants/exports.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Привет!"),
          Text("Введите данные"),
          Form(
            child: Column(
              children: [
                TextFormField(),
                TextFormField(),
              ],
            ),
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
