import 'package:crm_merchant/constants/exports.dart';

class AddProposalProvider extends ChangeNotifier {
  TextEditingController addProposalPhoneNumber = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController cardExpirationDate = TextEditingController();
  TextEditingController serialNumberOfpassport = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController namingThings = TextEditingController();
  TextEditingController summThings = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isError = false;

  hasError() {
    isError = true;
    notifyListeners();
  }

  hasnotError() {
    isError = false;
    notifyListeners();
  }
}
