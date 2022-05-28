import 'package:crm_merchant/models/marketplace/card_model.dart';
import '../constants/exports.dart';

class CardService {
  static const String _apiSend = "api/request/CreateCard";
  static const String _apiConfirm = "api/request/ConfirmCard";

  static Future<CardModel> sendSmsCard(String number, String expire) async {
    var dateParams = expire.split('/');
    Map<String, Object> param = {
      "card": number.removeAllWhitespace,
      "expire": dateParams[1] + dateParams[0]
    };
    var result = await ApiData().getData(_apiSend, HttpMethod.post, param);
    if (result.isSuccess) {
      return CardModel.fromJson(jsonDecode(result.result!));
    } else {
      throw Exception(result.errorMessage);
    }
  }

  static Future<CardModel> sendConfirmCard(String token, String code) async {
    Map<String, Object> param = {"cardToken": token, "code": code};
    var result = await ApiData().getData(_apiConfirm, HttpMethod.post, param);
    if (result.isSuccess) {
      return CardModel.fromJson(jsonDecode(result.result!));
    } else {
      throw Exception(result.errorMessage);
    }
  }
}
