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
  late String clientPhoneNumber;
  late List clientDatas = [];
  late List<List> clientCards = [];
  late List<String> cardItems = [];

  getPhoneNumber() {
    clientPhoneNumber =
        addProposalPhoneNumber.text.removeAllWhitespace.substring(1);
    clientDatas.add(clientPhoneNumber);
    debugPrint(clientDatas.toString());
    notifyListeners();
  }

  getCards() {
    cardItems.add(cardNumber.text);
    cardItems.add(cardExpirationDate.text);
    debugPrint(cardItems.toString());
    clientCards.add(cardItems);
    debugPrint(clientCards.toString());
    notifyListeners();
  }

  hasError() {
    isError = true;
    notifyListeners();
  }

  hasnotError() {
    isError = false;
    notifyListeners();
  }
}
