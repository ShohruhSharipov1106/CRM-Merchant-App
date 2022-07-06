// To parse this JSON data, do
//
//     final createReqCardModel = createReqCardModelFromJson(jsonString);

import 'dart:convert';

CreateReqCardModel createReqCardModelFromJson(String str) => CreateReqCardModel.fromJson(json.decode(str));

String createReqCardModelToJson(CreateReqCardModel data) => json.encode(data.toJson());

class CreateReqCardModel {
    CreateReqCardModel({
        this.contractorId,
        this.number,
        this.validity,
        this.token,
        this.holderName,
        this.phone,
        this.ps,
    });

    String? contractorId;
    String? number;
    DateTime? validity;
    String? token;
    String? holderName;
    String? phone;
    String? ps;

    factory CreateReqCardModel.fromJson(Map<String, dynamic> json) => CreateReqCardModel(
        contractorId: json["contractorId"],
        number: json["number"],
        validity: DateTime.parse(json["validity"]),
        token: json["token"],
        holderName: json["holderName"],
        phone: json["phone"],
        ps: json["ps"],
    );

    Map<String, dynamic> toJson() => {
        "contractorId": contractorId,
        "number": number,
        "validity": validity!.toIso8601String(),
        "token": token,
        "holderName": holderName,
        "phone": phone,
        "ps": ps,
    };
}
