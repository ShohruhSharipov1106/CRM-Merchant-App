import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/models/marketplace/create_request_model.dart';
import 'package:http/http.dart' as http;

class CreateRequestService {
  static Future postProductsToApi(BuildContext context) async {
    Uri url = Uri.parse(
        'https://crm.creditexpress.uz:6262/api/marketplace/CreateRequest');

    http.Response res = await http.post(
      url,
      body: jsonEncode(
        {
          "marketplaceId": "string",
          "partnerId": " ",
          "contractor": {
            "givenName": 'Shohruh',
            "surName": "Sharipov",
            "patronymic": "hello",
            "sex": "Male",
            "language": "Uzbek",
            "docTypeId": 0,
            "pinfl": "123456789",
            "tin": "12345678912345",
            "docSeries": "AB",
            "docNumber": 4657891,
            "docDateOfIssue": "2022-05-24T11:57:44.257Z",
            "docDateOfExpire": "2022-05-24T11:57:44.257Z",
            "docAuthority": 'Buxoro',
            "dateOfBirth": "2022-05-24T11:57:44.257Z",
            "address": "string",
            "residenceAddress": "string",
            "phone1": '998907445509',
            "phone2": "string",
            "phone3": "string"
          },
          "cards": [
            {
              "contractorId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
              "number": 8600140269636230,
              "validity": 2411,
              "token": "611a662a4e6f2f002228e2da",
              "holderName": "string",
              "phone": "string",
              "ps": "string"
            }
          ],
          "products": [
            {
              "productCode": "12",
              "productName": "Tree",
              "serialNumber": "123456789",
              "quantity": 123564789,
              "tariffId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
              "price": 465132213,
              "prepay": 1231654
            }
          ]
        },
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoibWFnbyIsImNvbXBhbnlfaWQiOiJiNTU4MGE0Ni1lZWM3LTRiM2MtYTJkYi0xNmQxYTBkNzBiYmMiLCJ1c2VyX3R5cGUiOiIxMCIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6Im1hcmtldHBsYWNlIiwibmJmIjoxNjUzMzkzNDQwLCJleHAiOjE2NTMzOTcwNDAsImlzcyI6ImNybS5jcmVkaXRleHByZXNzIiwiYXVkIjoiaHR0cHM6Ly9jcm0uY3JlZGl0ZXhwcmVzcy51ei8ifQ.cAECkl5_HcNrGJIMmNkzpkVpSNq3d6NfYIobTZy_bC0'
      },
    );
    if (res.statusCode == 200) {
      return (json.decode(res.body) as List)
          .map((e) => CreateRequest.fromJson)
          .toList();
    } else {
      throw Exception("Xato bor: ${res.statusCode}");
    }
  }
}

// class CreateRequestService {
//   static const String _apiSend = "api/marketplace/CreateRequest";

//   static Future<CardModel> sendSmsCard(String number, String expire) async {
//     
//     Map<String, Object> param = {
//       "card": number.removeAllWhitespace,
//       "expire": dateParams[1] + dateParams[0]
//     };
//     var result = await ApiData().getData(_apiSend, HttpMethod.post, param);
//     if (result.isSuccess) {
//       return CardModel.fromJson(jsonDecode(result.result!));
//     } else {
//       throw Exception(result.errorMessage);
//     }
//   }

 
// }
