// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
    HomeModel({
        this.totalCount,
        this.value,
    });

    int? totalCount;
    List<dynamic>? value;

    factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        totalCount: json["totalCount"],
        value: List<dynamic>.from(json["value"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "value": List<dynamic>.from(value!.map((x) => x)),
    };
}
