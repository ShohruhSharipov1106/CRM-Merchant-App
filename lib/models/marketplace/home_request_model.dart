// To parse this JSON data, do
//
//     final homeRequestModel = homeRequestModelFromJson(jsonString);

import 'dart:convert';

HomeRequestModel homeRequestModelFromJson(String str) =>
    HomeRequestModel.fromJson(json.decode(str));

String homeRequestModelToJson(HomeRequestModel data) =>
    json.encode(data.toJson());

class HomeRequestModel {
  HomeRequestModel({
    this.totalCount,
    this.value,
  });

  int? totalCount;
  List<Value>? value;

  factory HomeRequestModel.fromJson(Map<String, dynamic> json) =>
      HomeRequestModel(
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
    this.number,
    this.amount,
    this.prepay,
    this.companyId,
    this.company,
    this.partnerId,
    this.partner,
    this.docId,
    this.doc,
    this.docBalance,
    this.docIsActive,
    this.contractorId,
    this.contractor,
    this.requestTime,
    this.responseTime,
    this.state,
    this.validPhase,
    this.reasonForCancellationId,
    this.reasonForCancellation,
    this.hasCredit,
    this.requestNotes,
    this.responseNotes,
    this.createdBy,
    this.createdTime,
    this.modifiedBy,
    this.modifiedTime,
  });

  String? id;
  int? number;
  num? amount;
  num? prepay;
  String? companyId;
  String? company;
  String? partnerId;
  String? partner;
  dynamic docId;
  dynamic doc;
  num? docBalance;
  bool? docIsActive;
  String? contractorId;
  String? contractor;
  DateTime? requestTime;
  dynamic responseTime;
  String? state;
  String? validPhase;
  dynamic reasonForCancellationId;
  String? reasonForCancellation;
  bool? hasCredit;
  dynamic requestNotes;
  dynamic responseNotes;
  String? createdBy;
  DateTime? createdTime;
  String? modifiedBy;
  DateTime? modifiedTime;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        id: json["id"],
        number: json["number"],
        amount: json["amount"],
        prepay: json["prepay"],
        companyId: json["companyId"],
        company: json["company"],
        partnerId: json["partnerId"],
        partner: json["partner"],
        docId: json["docId"],
        doc: json["doc"],
        docBalance: json["docBalance"],
        docIsActive: json["docIsActive"],
        contractorId: json["contractorId"],
        contractor: json["contractor"],
        requestTime: DateTime.parse(json["requestTime"]),
        responseTime: json["responseTime"],
        state: json["state"],
        validPhase: json["validPhase"],
        reasonForCancellationId: json["reasonForCancellationId"],
        reasonForCancellation: json["reasonForCancellation"],
        hasCredit: json["hasCredit"],
        requestNotes: json["requestNotes"],
        responseNotes: json["responseNotes"],
        createdBy: json["createdBy"],
        createdTime: DateTime.parse(json["createdTime"]),
        modifiedBy: json["modifiedBy"],
        modifiedTime: DateTime.parse(json["modifiedTime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "amount": amount,
        "prepay": prepay,
        "companyId": companyId,
        "company": company,
        "partnerId": partnerId,
        "partner": partner,
        "docId": docId,
        "doc": doc,
        "docBalance": docBalance,
        "docIsActive": docIsActive,
        "contractorId": contractorId,
        "contractor": contractor,
        "requestTime": requestTime!.toIso8601String(),
        "responseTime": responseTime,
        "state": state,
        "validPhase": validPhase,
        "reasonForCancellationId": reasonForCancellationId,
        "reasonForCancellation": reasonForCancellation,
        "hasCredit": hasCredit,
        "requestNotes": requestNotes,
        "responseNotes": responseNotes,
        "createdBy": createdBy,
        "createdTime": createdTime!.toIso8601String(),
        "modifiedBy": modifiedBy,
        "modifiedTime": modifiedTime!.toIso8601String(),
      };
}
