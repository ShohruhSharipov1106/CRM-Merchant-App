import 'package:crm_merchant/models/marketplace/get_my_tariffs_model.dart';
import '../constants/exports.dart';

class GetTariffService {
  static const String _apiGet = "api/marketplace/GetMyTariffs";

  static Future<List<GetMyTariffsModel>> getMyTariffs() async {
    var result = await ApiData().getData(_apiGet, HttpMethod.post, null, false);
    if (result.isSuccess) {
      return List<GetMyTariffsModel>.from((json.decode(result.result!) as List)
          .map((v) => GetMyTariffsModel.fromJson(v))).toList();
    } else {
      throw Exception(result.errorMessage);
    }
  }
}
