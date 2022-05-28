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
  final fullPersonalFormKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController dadname = TextEditingController();
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
  bool isAccessButton = false;
  double? prePaymentSum;
  bool isError = false;
  late String clientPhoneNumber;
  late Map clientDatas = {
    "marketplaceId": "string",
    "partnerId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "contractor": {
      "givenName": "string",
      "surName": "string",
      "patronymic": "string",
      "sex": "Female",
      "language": "Russian",
      "docTypeId": 0,
      "pinfl": "string",
      "tin": "string",
      "docSeries": "string",
      "docNumber": "string",
      "docDateOfIssue": "2022-05-19T15:26:10.655Z",
      "docDateOfExpire": "2022-05-19T15:26:10.655Z",
      "docAuthority": "string",
      "dateOfBirth": "2022-05-19T15:26:10.655Z",
      "address": "string",
      "residenceAddress": "string",
      "phone1": "stringstring",
      "phone2": "string",
      "phone3": "string"
    },
    "cards": [
      {
        "contractorId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "number": "string",
        "validity": "2022-05-19T15:26:10.655Z",
        "token": "string",
        "holderName": "string",
        "phone": "string",
        "ps": "string"
      }
    ],
    "products": [
      {
        "productCode": "string",
        "productName": "string",
        "serialNumber": "string",
        "quantity": 0,
        "tariffId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "price": 0,
        "prepay": 0
      }
    ]
  };
  late List<List> clientCards = [];
  late List<String> cardItems = [];
  late List cards;
  late List items;
  late String clientPassportData;
  late String clientBirth;

  changePrePay(
      TextEditingController _kontroller, double prePercentSum, int sumItems) {
    prePaymentSum = double.parse(_kontroller.text);
    notifyListeners();
    if (prePaymentSum! < prePercentSum) {
      prePaymentSum = prePercentSum;
      notifyListeners();
    } else if (prePaymentSum! > sumItems) {
      prePaymentSum = double.parse(sumItems.toString());
      notifyListeners();
    }
  }

  getPassport() {
    clientPassportData = serialNumberOfpassport.text;
    clientBirth = dateOfBirth.text;
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

  getClientDatas() {}
  void updateIsAccessButton(bool isAccess) {
    if (isAccessButton != isAccess) {
      isAccessButton = isAccess;
      notifyListeners();
    }
  }
}
