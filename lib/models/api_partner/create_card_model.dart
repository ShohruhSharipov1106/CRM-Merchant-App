
import 'dart:convert';

CreateCard createCardFromJson(String str) => CreateCard.fromJson(json.decode(str));



class CreateCard {
    CreateCard({
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

    factory CreateCard.fromJson(Map<String, dynamic> json) => CreateCard(
        contractorId: json["contractorId"],
        number: json["number"],
        validity: DateTime.parse(json["validity"]),
        token: json["token"],
        holderName: json["holderName"],
        phone: json["phone"],
        ps: json["ps"],
    );

   
}
