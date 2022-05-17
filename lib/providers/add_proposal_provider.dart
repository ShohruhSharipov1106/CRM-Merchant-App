import 'package:crm_merchant/constants/exports.dart';

class AddProposalProvider extends ChangeNotifier {
  TextEditingController addProposalPhoneNumber = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController cardExpirationDate = TextEditingController();
  TextEditingController serialNumberOfpassport = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController namingThings = TextEditingController();
  TextEditingController summThings = TextEditingController();
  GlobalKey formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController dadname = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController seriesNumber = TextEditingController();
  TextEditingController tin = TextEditingController();
  TextEditingController pinfl = TextEditingController();
  TextEditingController placeOfResidence = TextEditingController();
  TextEditingController givenBy = TextEditingController();
  TextEditingController dateOfGiven = TextEditingController();
  TextEditingController validity = TextEditingController();
  String gender = 'male';
  String male = 'male';
  String female = 'female';
  String addressOfResidence = 'place_of_residence';
  String placeOfResidencevalue = 'place_of_residence';
  String another = 'another';

  RoundedLoadingButtonController addPropPhoneNumbBtnController =
      RoundedLoadingButtonController();
  RoundedLoadingButtonController makePropBtnController =
      RoundedLoadingButtonController();
  RoundedLoadingButtonController addPropPassportBtnController =
      RoundedLoadingButtonController();
  RoundedLoadingButtonController addPropCardBtnController =
      RoundedLoadingButtonController();
  RoundedLoadingButtonController addPropPhoneSMSBtnController =
      RoundedLoadingButtonController();
  RoundedLoadingButtonController addPropCardSMSBtnController =
      RoundedLoadingButtonController();

  bool isError = false;
  late String clientPhoneNumber;
  late List clientDatas = [];
  late List<List> clientCards = [];
  late List<String> cardItems = [];
  late List cards;
  late List items;
  late String clientPassportData;
  late String clientBirth;

  getPhoneNumber() {
    clientPhoneNumber =
        addProposalPhoneNumber.text.removeAllWhitespace.substring(1);
    clientDatas.add(clientPhoneNumber);
    notifyListeners();
  }

  getPassport() {
    clientPassportData = serialNumberOfpassport.text;
    clientBirth = dateOfBirth.text;

    clientDatas.add(clientPassportData);
    clientDatas.add(clientBirth);
  }

  getCards(String cardNumb, String cardExpDate) {
    // String cardnum = cardNumb;
    // String cardexpdate = cardExpDate;
    cardItems.add(cardNumb);
    cardItems.add(cardExpDate);
    // items = cardItems;
    debugPrint("cardItems 1: " + cardItems.toString());
    // debugPrint("items 1: " + items.toString());
    clientCards.add(cardItems);
    clientCards.setAll(0, [cardItems]);

    // cards = clientCards;
    debugPrint("clientCards 1: " + clientCards.toString());
    // debugPrint("cards 1: " + cards.toString());
    cardItems.clear();
    debugPrint("cardItems 2: " + cardItems.toString());
    debugPrint("clientCards 2: " + clientCards.toString());

    // debugPrint("items 2: " + items.toString());
    // debugPrint("cards 2: " + cards.toString());
    notifyListeners();
  }

  changeGender() {
    gender == 'male' ? gender = female : gender = male;
    notifyListeners();
  }

  changeAddress() {
    addressOfResidence == 'place_of_residence'
        ? addressOfResidence = another
        : addressOfResidence = placeOfResidencevalue;
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
