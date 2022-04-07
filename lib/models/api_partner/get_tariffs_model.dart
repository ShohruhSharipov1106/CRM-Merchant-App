// To parse this JSON data, do
//
//     final getTariffs = getTariffsFromJson(jsonString);

import 'dart:convert';

List<GetTariffs> getTariffsFromJson(String str) => List<GetTariffs>.from(json.decode(str).map((x) => GetTariffs.fromJson(x)));

String getTariffsToJson(List<GetTariffs> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetTariffs {
    GetTariffs({
        this.id,
        this.name,
        this.monthsCount,
        this.markup,
        this.prepayPercent,
    });

    String? id;
    String? name;
    int? monthsCount;
    int? markup;
    int? prepayPercent;

    factory GetTariffs.fromJson(Map<String, dynamic> json) => GetTariffs(
        id: json["id"],
        name: json["name"],
        monthsCount: json["monthsCount"],
        markup: json["markup"],
        prepayPercent: json["prepayPercent"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "monthsCount": monthsCount,
        "markup": markup,
        "prepayPercent": prepayPercent,
    };
}
