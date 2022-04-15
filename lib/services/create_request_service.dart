import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/models/marketplace/create_request_model.dart';
import 'package:http/http.dart' as http;

class CreateRequestService {
 static Future postPhoneNumber(String phoneNumber) async {
    Uri url = Uri.parse(
        "https://crm.creditexpress.uz:6262/api/marketplace/CreateRequest");
    http.Response res = await http.post(
      url,
      body: jsonEncode(
        {
          "contractor": {"phone1": phoneNumber}
        },
      ),
      headers: {
        "Accept": "text/plain",
        "content-type": "application/json",
      },
    );
    if (res.statusCode == 200) {
      print(res.body[0][3].toString());
      return (jsonDecode(res.body) as List).map((e) => CreateRequest).toList();
    } else {
      throw Exception("Xato: ${res.statusCode}");
    }
  }
}
