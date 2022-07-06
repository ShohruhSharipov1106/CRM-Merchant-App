import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/core/static_datas.dart';
import 'package:crm_merchant/models/camera/face_id_model.dart';

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
  TextEditingController tin = TextEditingController();
  TextEditingController pinfl = TextEditingController();
  TextEditingController placeOfResidence = TextEditingController();
  TextEditingController givenBy = TextEditingController();
  TextEditingController givenDate = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController homeNumber = TextEditingController();
  TextEditingController apartmentNumber = TextEditingController();
  TextEditingController orientr = TextEditingController();
  TextEditingController temporaryhomeNumber = TextEditingController();
  TextEditingController temporaryapartmentNumber = TextEditingController();
  TextEditingController temporaryorientr = TextEditingController();
  DateTime? birthDayDateTime;
  String? partnerId;
  String? nationality;
  String? fullName;
  String? passData;
  DateTime? expiryDateDatetime;
  DateTime? issuedDateDatetime;
  String? permanentAddress;
  String? temporaryAddress;
  String? permanentAddressRegion;
  String? permanentAddressAddress;
  String? permanentAddressCountry;
  String? permanentAddressCadastre;
  String? permanentAddressDistrict;
  String? permanentAddressRegionId;
  String? permanentAddressCountryId;
  String? permanentAddressDistrictId;
  String? permanentAddressRegistrationDate;
  String? temporaryAddressRegion;
  String? temporaryAddressAddress;
  String? temporaryAddressCountry;
  String? temporaryAddressCadastre;
  String? temporaryAddressDistrict;
  String? temporaryAddressRegionId;
  String? temporaryAddressCountryId;
  String? temporaryAddressDistrictId;
  String? responseId;
  String gender = "Male";

  String male = "Male";
  String female = "Female";
  String addressOfResidence = 'place_of_residence';
  String placeOfResidencevalue = 'place_of_residence';
  String another = 'another';
  bool isAccessButton = false;
  double? prePaymentSum;
  bool isError = false;
  bool isApartment = false;
  bool temporaryisApartment = false;

  int itemListLength = 0;

  late Map clientDatas = {
    "marketplaceId": "string",
    "partnerId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    "contractor": {
      "givenName": name.text,
      "surName": surname.text,
      "patronymic": dadname.text,
      "sex": gender,
      "language": nationality,
      "docTypeId": 0,
      "pinfl": pinfl,
      "tin": tin,
      "docSeries": passData!.substring(0, 2),
      "docNumber": passData!.substring(2),
      "docDateOfIssue": issuedDateDatetime,
      "docDateOfExpire": expiryDateDatetime,
      "docAuthority": givenBy.text,
      "dateOfBirth": birthDayDateTime,
      "address": permanentAddress,
      "residenceAddress": temporaryAddress,
      "phone1": addProposalPhoneNumber.text.removeAllWhitespace.substring(1),
      "phone2": "string",
      "phone3": "string"
    },

    // EDIT IT

    "cards": List<dynamic>.from(StaticData.cards.map((x) => x.toJson())),
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

  changeGender() {
    gender == "Male" ? gender = female : gender = male;
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

  getClientDatas(FaceIdModel value) {
    responseId = value.responseId.toString();
    name.text = value.profile!.commonData!.firstName.toString();
    surname.text = value.profile!.commonData!.middleName.toString();
    dadname.text = value.profile!.commonData!.lastName.toString();
    fullName = value.profile!.commonData!.fullName.toString();
    tin.text = value.profile!.commonData!.inn.toString();
    pinfl.text = value.profile!.commonData!.pinfl.toString();
    gender =
        value.profile!.commonData!.gender.toString() == "1" ? male : female;
    birthDayDateTime = value.profile!.commonData!.birthDateValue!;
    nationality = value.profile!.commonData!.nationality.toString();
    passData = value.profile!.docData!.passData.toString();
    givenBy.text = value.profile!.docData!.issuedBy.toString();
    givenDate.text = value.profile!.docData!.issuedDate.toString();
    expiryDate.text = value.profile!.docData!.expiryDate.toString();
    expiryDateDatetime = value.profile!.docData!.expiryDateDatetime;
    issuedDateDatetime = value.profile!.docData!.issuedDateDatetime;
    permanentAddress = value.profile!.address!.permanentAddress.toString();
    temporaryAddress = value.profile!.address!.temporaryAddress.toString();
    permanentAddressRegion =
        value.profile!.address!.permanentRegistration!.region.toString();
    permanentAddressAddress =
        value.profile!.address!.permanentRegistration!.address.toString();
    permanentAddressCountry =
        value.profile!.address!.permanentRegistration!.country.toString();
    permanentAddressCadastre =
        value.profile!.address!.permanentRegistration!.cadastre.toString();
    permanentAddressDistrict =
        value.profile!.address!.permanentRegistration!.district.toString();
    permanentAddressRegionId =
        value.profile!.address!.permanentRegistration!.regionId.toString();
    permanentAddressCountryId =
        value.profile!.address!.permanentRegistration!.country.toString();
    permanentAddressDistrictId =
        value.profile!.address!.permanentRegistration!.districtId.toString();
    permanentAddressRegistrationDate = value
        .profile!.address!.permanentRegistration!.registrationDate
        .toString();
    temporaryAddressRegion =
        value.profile!.address!.temporaryRegistration!.region.toString();
    temporaryAddressAddress =
        value.profile!.address!.temporaryRegistration!.address.toString();
    temporaryAddressCountry =
        value.profile!.address!.temporaryRegistration!.country.toString();
    temporaryAddressCadastre =
        value.profile!.address!.temporaryRegistration!.cadastre.toString();
    temporaryAddressDistrict =
        value.profile!.address!.temporaryRegistration!.district.toString();
    temporaryAddressRegionId =
        value.profile!.address!.temporaryRegistration!.regionId.toString();
    temporaryAddressCountryId =
        value.profile!.address!.temporaryRegistration!.countryId.toString();
    temporaryAddressDistrictId =
        value.profile!.address!.temporaryRegistration!.districtId.toString();
    notifyListeners();
  }

  void updateIsAccessButton(bool isAccess) {
    if (isAccessButton != isAccess) {
      isAccessButton = isAccess;
      notifyListeners();
    }
  }

  changeApartmentValue() {
    isApartment = !isApartment;
    notifyListeners();
  }

  changeTemporaryApartmentValue() {
    temporaryisApartment = !temporaryisApartment;
    notifyListeners();
  }
}
