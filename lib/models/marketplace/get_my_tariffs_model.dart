// To parse this JSON data, do
//
//     final getMyTariffs = getMyTariffsFromJson(jsonString);

import 'dart:convert';

List<GetMyTariffs> getMyTariffsFromJson(String str) => List<GetMyTariffs>.from(json.decode(str).map((x) => GetMyTariffs.fromJson(x)));


class GetMyTariffs {
    GetMyTariffs({
        this.id,
        this.name,
        this.monthsCount,
        this.markup,
        this.prepayPercent,
        this.partnerId,
    });

    String? id;
    String? name;
    int? monthsCount;
    int? markup;
    int? prepayPercent;
    String? partnerId;

    factory GetMyTariffs.fromJson(Map<String, dynamic> json) => GetMyTariffs(
        id: json["id"],
        name: json["name"],
        monthsCount: json["monthsCount"],
        markup: json["markup"],
        prepayPercent: json["prepayPercent"],
        partnerId: json["partnerId"],
    );

    
}
