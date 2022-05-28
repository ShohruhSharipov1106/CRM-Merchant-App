import 'package:crm_merchant/models/marketplace/home_request_model.dart';

import '../constants/exports.dart';

class HomePageDataService {
  static const String _api = "api/request/GetRequests";
  static Future<HomeRequestModel> getStateRequest(RequestState state) async {
    Map<String, String>? param;
    if (state != RequestState.all) {
      param = {"State": state.name};
    }

    var result = await ApiData().getData(_api, HttpMethod.get, param);
    if (result.isSuccess) {
      return HomeRequestModel.fromJson(jsonDecode(result.result!));
    } else {
      throw Exception(result.errorMessage);
    }
  }
}
