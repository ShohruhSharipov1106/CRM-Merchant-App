import '../constants/exports.dart';

class SendSMSService {
  static const String _apiSend = "api/sms/Send";
  static Future sendSmsToClient(String clientPhone, String message) async {
    Map<String, String> param = {
      "phone": clientPhone,
      "message": "Tasdiqlash kodi: $message\nКод подтверждения: $message",
      "ownerId": const Uuid().v1()
    };
    var result = await ApiData().getData(_apiSend, HttpMethod.post, param, true);
    if (result.isSuccess) {
      return result.result!;
    } else {
      throw Exception(result.errorMessage);
    }
  }
}
