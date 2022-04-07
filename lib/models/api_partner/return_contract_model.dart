// To parse this JSON data, do
//
//     final returnContract = returnContractFromJson(jsonString);

import 'dart:convert';

ReturnContract returnContractFromJson(String str) => ReturnContract.fromJson(json.decode(str));


class ReturnContract {
    ReturnContract({
        this.contractNumber,
        this.reason,
    });

    String? contractNumber;
    String? reason;

    factory ReturnContract.fromJson(Map<String, dynamic> json) => ReturnContract(
        contractNumber: json["contractNumber"],
        reason: json["reason"],
    );

    
}
