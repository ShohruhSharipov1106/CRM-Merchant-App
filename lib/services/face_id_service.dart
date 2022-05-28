import 'package:crm_merchant/models/camera/face_id_model.dart';
import 'package:crm_merchant/services/api_helper_face.dart';

import '../constants/exports.dart';

class FaceIdService {
  static const String _apiSend = "app/personInfo";

  static Future<FaceIdModel> sendFacetoId(
    String passData,
    String birthDate,
    String image,
    String device,
  ) async {
    Map<String, Object> param = {
      "pass_data": passData,
      "birth_date": birthDate,
      "image": image,
      "device": device
    };
    var result = await FaceApiData().getData(_apiSend, HttpMethod.post, param);
    if (result.isSuccess) {
      return FaceIdModel.fromJson(json.decode(result.result!));
    } else {
      throw Exception(result.errorMessage);
    }
  }
}
