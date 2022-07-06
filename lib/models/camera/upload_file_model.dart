// To parse this JSON data, do
//
//     final uploadFileModel = uploadFileModelFromJson(jsonString);


import 'package:crm_merchant/constants/exports.dart';

UploadFileModel uploadFileModelFromJson(String str) =>
    UploadFileModel.fromJson(json.decode(str));

String uploadFileModelToJson(UploadFileModel data) =>
    json.encode(data.toJson());

class UploadFileModel {
  UploadFileModel({
    this.ownerId,
    this.fileTypeId,
    this.file,
  });

  String? ownerId;
  int? fileTypeId;
  Uint8List? file;

  factory UploadFileModel.fromJson(Map<String, dynamic> json) =>
      UploadFileModel(
        ownerId: json["ownerId"],
        fileTypeId: json["fileTypeId"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "ownerId": ownerId,
        "fileTypeId": fileTypeId,
        "file": Uint8List.fromList(file!),
      };
}
