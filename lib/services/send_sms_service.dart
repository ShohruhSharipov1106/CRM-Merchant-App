
import 'package:http/http.dart' as http;

import '../constants/exports.dart';

class SendSMSService {
  static Future sendSmsToClient(String clientPhone, String message) async {
    Uri url = Uri.parse("https://crm.creditexpress.uz:6262/api/sms/Send");
    http.Response res = await http.post(
      url,
      body: json.encode(
        {
          "phone": clientPhone,
          "message": "Tasdiqlash kodi: $message",
          "ownerId": "3fa85f64-5717-4562-b3fc-2c963f66afa6"
        },
      ),
      headers: {
        "Accept": " */*",
        "content-type": "application/json",
        'Authorization':
            'Bearer ${clientMainData.read('token')}'
      },
    );
    if (res.statusCode == 200) {
      return res.body;
    } else {
      throw Exception("Xato: ${res.statusCode}");
    }
  }
}
