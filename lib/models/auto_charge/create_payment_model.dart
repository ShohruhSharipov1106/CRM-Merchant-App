// To parse this JSON data, do
//
//     final createPayment = createPaymentFromJson(jsonString);

import 'dart:convert';

CreatePayment createPaymentFromJson(String str) => CreatePayment.fromJson(json.decode(str));


class CreatePayment {
    CreatePayment({
        this.docId,
        this.time,
        this.amount,
        this.note,
        this.sourceId,
    });

    String? docId;
    DateTime? time;
    int? amount;
    String? note;
    String? sourceId;

    factory CreatePayment.fromJson(Map<String, dynamic> json) => CreatePayment(
        docId: json["docId"],
        time: DateTime.parse(json["time"]),
        amount: json["amount"],
        note: json["note"],
        sourceId: json["sourceId"],
    );

    
}
