import 'package:crm_merchant/constants/exports.dart';

class HasErrorProvider extends ChangeNotifier {
  bool signUpError = false;
  bool phoneError = false;
  bool phoneSMSError = false;
  bool cardError = false;
  bool cardSMSError = false;
  bool passportError = false;

  hasSignUpError() {
    signUpError = true;
    notifyListeners();
  }

  hasNotError() {
    signUpError = false;
    phoneError = false;
    phoneSMSError = false;
    cardError = false;
    cardSMSError = false;
    passportError = false;
    notifyListeners();
  }

  hasPhoneError() {
    phoneError = true;
    notifyListeners();
  }

  hasPhoneSMSError() {
    phoneSMSError = true;
    notifyListeners();
  }

  hasCardError() {
    cardError = true;
    notifyListeners();
  }

  hasCardSMSError() {
    cardSMSError = true;
    notifyListeners();
  }

  hasPassportError() {
    passportError = true;
    notifyListeners();
  }
}
