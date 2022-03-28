import 'package:crm_merchant/constants/exports.dart';

class SignUpProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isValidate = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  isValidateFunc() {
    if (formKey.currentState!.validate()) {
      isValidate = true;
      notifyListeners();
    }
    return isValidate;
  }
}
