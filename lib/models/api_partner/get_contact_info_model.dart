// To parse this JSON data, do
//
//     final getContractInfo = getContractInfoFromJson(jsonString);

import 'dart:convert';

GetContractInfo getContractInfoFromJson(String str) => GetContractInfo.fromJson(json.decode(str));

class GetContractInfo {
    GetContractInfo({
        this.date,
        this.expiryDate,
        this.contractorName,
        this.amount,
        this.balance,
        this.payments,
        this.balanceOfDebt,
        this.dailyPayoutAmount,
    });

    DateTime? date;
    DateTime? expiryDate;
    String? contractorName;
    int? amount;
    int? balance;
    int? payments;
    int? balanceOfDebt;
    int? dailyPayoutAmount;

    factory GetContractInfo.fromJson(Map<String, dynamic> json) => GetContractInfo(
        date: DateTime.parse(json["date"]),
        expiryDate: DateTime.parse(json["expiryDate"]),
        contractorName: json["contractorName"],
        amount: json["amount"],
        balance: json["balance"],
        payments: json["payments"],
        balanceOfDebt: json["balanceOfDebt"],
        dailyPayoutAmount: json["dailyPayoutAmount"],
    );

    
}
