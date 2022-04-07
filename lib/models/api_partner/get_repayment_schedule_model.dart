// To parse this JSON data, do
//
//     final getRepaymentSchedule = getRepaymentScheduleFromJson(jsonString);

import 'dart:convert';

List<GetRepaymentSchedule> getRepaymentScheduleFromJson(String str) =>
    List<GetRepaymentSchedule>.from(
        json.decode(str).map((x) => GetRepaymentSchedule.fromJson(x)));

class GetRepaymentSchedule {
  GetRepaymentSchedule({
    this.date,
    this.amount,
    this.payment,
    this.rest,
  });

  DateTime? date;
  int? amount;
  int? payment;
  int? rest;

  factory GetRepaymentSchedule.fromJson(Map<String, dynamic> json) =>
      GetRepaymentSchedule(
        date: DateTime.parse(json["date"]),
        amount: json["amount"],
        payment: json["payment"],
        rest: json["rest"],
      );
}
