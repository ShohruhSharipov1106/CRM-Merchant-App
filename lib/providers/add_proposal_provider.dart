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
  int indexPage = 1;

  nextPage() {
    indexPage < 9 ? indexPage += 1 : indexPage = 8;
  }

  previousPage() {
    indexPage < 1 ? indexPage -= 1 : indexPage = 1;
  }
}
