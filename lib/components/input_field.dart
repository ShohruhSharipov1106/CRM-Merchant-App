import 'package:crm_merchant/constants/exports.dart';

class InputField extends StatelessWidget {
  TextEditingController kontroller;
  String hintTitle;
  TextInputType keyboardingType;
  InputField(this.kontroller, this.hintTitle, this.keyboardingType, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: kontroller,
      keyboardType: keyboardingType,
      // edit
      validator: (v) {},
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: kWhiteColor,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
