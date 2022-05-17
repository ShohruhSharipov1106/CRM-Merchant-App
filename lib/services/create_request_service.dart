import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/models/marketplace/create_request_model.dart';
import 'package:http/http.dart' as http;

class CreateRequestService {
  static Future postClientToApi(String phoneNumber) async {
    Uri url = Uri.parse(
        "https://crm.creditexpress.uz:6262/api/marketplace/CreateRequest");
    http.Response res = await http.post(
      url,
      body: jsonEncode(
        {
          "contractor": {
            "phone1": phoneNumber,
          }
        },
      ),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization':
            'Bearer ${clientMainData.read('token')}'
      },
    );
    if (res.statusCode == 200) {
      print("postdan bajarildi");
      return (jsonDecode(res.body) as List).map((e) => CreateRequest).toList();
    } else {
      throw Exception("Xato: ${res.statusCode}");
    }
  }

  static Future postProductsToApi(String productName, int price) async {
    Uri url = Uri.parse(
        'https://crm.creditexpress.uz:6262/api/marketplace/CreateRequest');

    http.Response res = await http.post(
      url,
      body: jsonEncode(
        {
          "products": [
            {
              "productName": productName,
              "price": price,
            }
          ]
        },
      ),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoibWFnbyIsImNvbXBhbnlfaWQiOiJiNTU4MGE0Ni1lZWM3LTRiM2MtYTJkYi0xNmQxYTBkNzBiYmMiLCJ1c2VyX3R5cGUiOiIxMCIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6Im1hcmtldHBsYWNlIiwibmJmIjoxNjUwMzU5Njc0LCJleHAiOjE2NTAzNjMyNzQsImlzcyI6ImNybS5jcmVkaXRleHByZXNzIiwiYXVkIjoiaHR0cHM6Ly9jcm0uY3JlZGl0ZXhwcmVzcy51ei8ifQ.4-i_5ATzRXrDiWURAaysRKJH_ksYHZTfOLv4dDYqFn8'
      },
    );
    if (res.statusCode == 200) {
      print("postdan bajarildi");
      return (json.decode(res.body) as List)
          .map((e) => CreateRequest.fromJson)
          .toList();
    } else {
      print("post bajarilmadi");
      throw Exception("Xato bor: ${res.statusCode}");
    }
  }

  static Future postCardsToApi(String? number) async {
    Uri url = Uri.parse(
        'https://crm.creditexpress.uz:6262/api/marketplace/CreateRequest');
    http.Response res = await http.post(
      url,
      body: jsonEncode(
        {
          "cards": [
            {
              "contractorId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
              "number": number,
              "validity": "2022-04-19T09:24:19.960Z",
              "token": "string",
              "holderName": "string",
              "phone": "string",
              "ps": "string"
            }
          ],
        },
      ),
      headers: {
        "Accept": "text/plain",
        "content-type": "application/json",
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoibWFnbyIsImNvbXBhbnlfaWQiOiJiNTU4MGE0Ni1lZWM3LTRiM2MtYTJkYi0xNmQxYTBkNzBiYmMiLCJ1c2VyX3R5cGUiOiIxMCIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6Im1hcmtldHBsYWNlIiwibmJmIjoxNjUwMzU5Njc0LCJleHAiOjE2NTAzNjMyNzQsImlzcyI6ImNybS5jcmVkaXRleHByZXNzIiwiYXVkIjoiaHR0cHM6Ly9jcm0uY3JlZGl0ZXhwcmVzcy51ei8ifQ.4-i_5ATzRXrDiWURAaysRKJH_ksYHZTfOLv4dDYqFn8'
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
