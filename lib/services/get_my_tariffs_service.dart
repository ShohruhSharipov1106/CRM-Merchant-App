import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/models/marketplace/get_my_tariffs_model.dart';
import 'package:http/http.dart' as http;

class getMyTariffsService {
  static Future postTariffToApi() async {
    Uri url = Uri.parse(
        'https://crm.creditexpress.uz:6262/api/marketplace/GetMyTariffs');
    http.Response res = await http.post(
      url,
      body: {},
      headers: {
        "accept": "application/json",
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoibWFnbyIsImNvbXBhbnlfaWQiOiJiNTU4MGE0Ni1lZWM3LTRiM2MtYTJkYi0xNmQxYTBkNzBiYmMiLCJ1c2VyX3R5cGUiOiIxMCIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6Im1hcmtldHBsYWNlIiwibmJmIjoxNjUwMzU5Njc0LCJleHAiOjE2NTAzNjMyNzQsImlzcyI6ImNybS5jcmVkaXRleHByZXNzIiwiYXVkIjoiaHR0cHM6Ly9jcm0uY3JlZGl0ZXhwcmVzcy51ei8ifQ.4-i_5ATzRXrDiWURAaysRKJH_ksYHZTfOLv4dDYqFn8'
      },
    );
    if (res.statusCode == 200) {
      return (json.decode(res.body) as List)
          .map((e) => GetMyTariffs.fromJson)
          .toList();
    } else {
      throw Exception("Xato bor: ${res.statusCode}");
    }
  }
}
