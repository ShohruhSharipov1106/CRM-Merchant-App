import '../constants/exports.dart';

class UploadFileService {
  static const String _apiSend = "api/file/Post";

  static Future uploadFile(String ownerId, int fileTypeId, String file) async {
    Map<String, Object> param = {
      "ownerId": ownerId.substring(1, ownerId.length - 1),
      "fileTypeId": fileTypeId,
      "file": file.substring(22)
    };
    var result =
        await ApiData().getData(_apiSend, HttpMethod.post, param, true);
    if (result.isSuccess) {
      return result.result!;
    } else {
      throw Exception(result.errorMessage);
    }
  }
}
