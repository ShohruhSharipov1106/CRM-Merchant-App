// To parse this JSON data, do
//
//     final createContractor = createContractorFromJson(jsonString);

import 'dart:convert';

CreateContractor createContractorFromJson(String str) => CreateContractor.fromJson(json.decode(str));


class CreateContractor {
    CreateContractor({
        this.givenName,
        this.surName,
        this.patronymic,
        this.sex,
        this.language,
        this.docTypeId,
        this.pinfl,
        this.docSeries,
        this.docNumber,
        this.docDateOfIssue,
        this.docDateOfExpire,
        this.docAuthority,
        this.dateOfBirth,
        this.address,
        this.residenceAddress,
        this.phone1,
        this.phone2,
        this.phone3,
    });

    String? givenName;
    String? surName;
    String? patronymic;
    String? sex;
    String? language;
    int? docTypeId;
    String? pinfl;
    String? docSeries;
    String? docNumber;
    DateTime? docDateOfIssue;
    DateTime? docDateOfExpire;
    String? docAuthority;
    DateTime? dateOfBirth;
    String? address;
    String? residenceAddress;
    String? phone1;
    String? phone2;
    String? phone3;

    factory CreateContractor.fromJson(Map<String, dynamic> json) => CreateContractor(
        givenName: json["givenName"],
        surName: json["surName"],
        patronymic: json["patronymic"],
        sex: json["sex"],
        language: json["language"],
        docTypeId: json["docTypeId"],
        pinfl: json["pinfl"],
        docSeries: json["docSeries"],
        docNumber: json["docNumber"],
        docDateOfIssue: DateTime.parse(json["docDateOfIssue"]),
        docDateOfExpire: DateTime.parse(json["docDateOfExpire"]),
        docAuthority: json["docAuthority"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        address: json["address"],
        residenceAddress: json["residenceAddress"],
        phone1: json["phone1"],
        phone2: json["phone2"],
        phone3: json["phone3"],
    );

    
}
