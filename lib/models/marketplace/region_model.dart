// To parse this JSON data, do
//
//     final regionModel = regionModelFromJson(jsonString);

import 'dart:convert';

RegionModel regionModelFromJson(String str) => RegionModel.fromJson(json.decode(str));

String regionModelToJson(RegionModel data) => json.encode(data.toJson());

class RegionModel {
    RegionModel({
        this.totalCount,
        this.value,
    });

    int? totalCount;
    List<Value>? value;

    factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
        totalCount: json["totalCount"],
        value: List<Value>.from(json["value"].map((x) => Value.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "value": List<dynamic>.from(value!.map((x) => x.toJson())),
    };
}

class Value {
    Value({
        this.id,
        this.type,
        this.name,
        this.parentId,
    });

    String? id;
    String? type;
    String? name;
    dynamic parentId;

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        parentId: json["parentId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "parentId": parentId,
    };
}
