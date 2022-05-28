import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/models/marketplace/get_my_tariffs_model.dart';
import 'package:http/http.dart' as http;

class GetMyTariffsService {
  static Future postTariffToApi() async {
    Uri url = Uri.parse(
        'https://crm.creditexpress.uz:6262/api/marketplace/GetMyTariffs');
    http.Response res = await http.post(
      url,
      body: {},
      headers: {
        "accept": "application/json",
        'Authorization':
            'Bearer $token'
      },
    );
    if (res.statusCode == 200) {
      return (json.decode(res.body) as List)
          .map((e) => GetMyTariffsModel.fromJson)
          .toList();
    } else {
      throw Exception("Xato bor: ${res.statusCode}");
    }
  }
}
