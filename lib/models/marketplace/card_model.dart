// To parse this JSON data, do
//
//     final cardModel = cardModelFromJson(jsonString);

import 'dart:convert';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));
String cardModelToJson(CardModel data) => json.encode(data.toJson());

class CardModel {
  CardModel({
    this.cardToken,
    this.phone,
    this.id,
    this.applicationId,
    this.addedOn,
    this.ps,
    this.holderName,
  });

  String? cardToken;
  String? phone;
  String? id;
  int? applicationId;
  String? addedOn;
  String? ps;
  String? holderName;
  String? number;
  String? expire;

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        cardToken: json["card_token"],
        phone: json["phone"],
        id: json["id"],
        applicationId: json["application_id"],
        addedOn: json["added_on"],
        ps: json["ps"],
        holderName: json["holder_name"],
      );

  Map<String, dynamic> toJson() => {
        "card_token": cardToken,
        "phone": phone,
        "id": id,
        "application_id": applicationId,
        "added_on": addedOn,
        "ps": ps,
        "holder_name": holderName,
      };
}
