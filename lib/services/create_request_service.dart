import 'package:crm_merchant/constants/exports.dart';

class CreateRequestService {
  static const String _apiSend = "api/request/CreateRequest";

  static Future postDatasToApi(
    String partnerId,
    String name,
    String surname,
    String dadname,
    String gender,
    String nationality,
    String pinfl,
    String tin,
    String docSeries,
    String docNumber,
    var docDateOfIssue,
    var docDateOfExpire,
    String docAuthority,
    var dateOfBirth,
    String address,
    String residenceAddress,
    String phone1,
  ) async {
    print("""$tin => ${tin.runtimeType}
   $name => ${name.runtimeType}
   $surname => ${surname.runtimeType}
   $dadname => ${dadname.runtimeType}
   $gender => ${gender.runtimeType}
   $nationality => ${nationality.runtimeType}
   $pinfl => ${pinfl.runtimeType}
   $docSeries => ${docSeries.runtimeType}
   $docNumber => ${docNumber.runtimeType}
   $docDateOfIssue => ${docDateOfIssue.runtimeType}
   $docDateOfExpire => ${docDateOfExpire.runtimeType}
   $docAuthority => ${docAuthority.runtimeType}
   $dateOfBirth => ${dateOfBirth.runtimeType}
   $address => ${address.runtimeType}
   $residenceAddress => ${residenceAddress.runtimeType}
   $phone1 => ${phone1.runtimeType}""");

    Map<String, Object> param = {
      "marketplaceId": "",
      "partnerId": partnerId,
      "contractor": {
        "givenName": name,
        "surName": surname,
        "patronymic": dadname,
        "sex": gender,
        "language": "Russian",
        "docTypeId": 1,
        "pinfl": pinfl,
        "tin": tin,
        "docSeries": docSeries,
        "docNumber": docNumber,
        "docDateOfIssue":
            "${docDateOfIssue.toString().substring(0, 4)}-${docDateOfIssue.toString().substring(5, 7)}-${docDateOfIssue.toString().substring(8, 10)}T00:00:00.000",
        "docDateOfExpire":
            "${docDateOfExpire.toString().substring(0, 4)}-${docDateOfExpire.toString().substring(5, 7)}-${docDateOfExpire.toString().substring(8, 10)}T00:00:00.000",
        "docAuthority": docAuthority,
        "dateOfBirth":
            "${dateOfBirth.toString().substring(0, 4)}-${dateOfBirth.toString().substring(5, 7)}-${dateOfBirth.toString().substring(8, 10)}T00:00:00.000",
        "address": address,
        "residenceAddress": residenceAddress,
        "phone1": phone1,
        "phone2": "",
        "phone3": ""
      },
      "cards": List<dynamic>.from(createReqCards.map((x) => x.toJson())),
      "products": List<dynamic>.from(itemList.map((x) => x.toJson()))
    };
    var result =
        await ApiData().getData(_apiSend, HttpMethod.post, param, true);
    if (result.isSuccess) {
      
      return result.result;
    } else {
      throw Exception(result.errorMessage);
    }
  }
}
