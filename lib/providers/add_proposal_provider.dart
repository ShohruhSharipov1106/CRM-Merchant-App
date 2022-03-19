import 'package:crm_merchant/constants/exports.dart';

class AddProposalProvider extends ChangeNotifier {
  TextEditingController addProposalPhoneNumber = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController cardExpirationDate = TextEditingController();
  TextEditingController serialNumberOfpassport = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  int indexPage = 1;

  nextPage() {
    indexPage < 9 ? indexPage += 1 : indexPage = 8;
  }

  previousPage() {
    indexPage < 1 ? indexPage -= 1 : indexPage = 1;
  }
}
