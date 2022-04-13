// To parse this JSON data, do
//
//     final createRequest = createRequestFromJson(jsonString);

import 'dart:convert';

CreateRequest createRequestFromJson(String str) =>
    CreateRequest.fromJson(json.decode(str));

class CreateRequest {
  CreateRequest({
    this.marketplaceId,
    this.partnerId,
    this.contractor,
    this.cards,
    this.products,
  });

  String? marketplaceId;
  String? partnerId;
  Contractor? contractor;
  List<Card>? cards;
  List<Product>? products;

  factory CreateRequest.fromJson(Map<String, dynamic> json) => CreateRequest(
        marketplaceId: json["marketplaceId"],
        partnerId: json["partnerId"],
        contractor: Contractor.fromJson(json["contractor"]),
        cards: List<Card>.from(json["cards"].map((x) => Card.fromJson(x))),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );
}

class Card {
  Card({
    this.contractorId,
    this.number,
    this.validity,
    this.token,
    this.holderName,
    this.phone,
    this.ps,
  });

  String? contractorId;
  String? number;
  DateTime? validity;
  String? token;
  String? holderName;
  String? phone;
  String? ps;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        contractorId: json["contractorId"],
        number: json["number"],
        validity: DateTime.parse(json["validity"]),
        token: json["token"],
        holderName: json["holderName"],
        phone: json["phone"],
        ps: json["ps"],
      );
}

class Contractor {
  Contractor({
    this.givenName,
    this.surName,
    this.patronymic,
    this.sex,
    this.language,
    this.docTypeId,
    this.pinfl,
    this.tin,
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
  String? tin;
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

  factory Contractor.fromJson(Map<String, dynamic> json) => Contractor(
        givenName: json["givenName"],
        surName: json["surName"],
        patronymic: json["patronymic"],
        sex: json["sex"],
        language: json["language"],
        docTypeId: json["docTypeId"],
        pinfl: json["pinfl"],
        tin: json["tin"],
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

class Product {
  Product({
    this.productCode,
    this.productName,
    this.serialNumber,
    this.quantity,
    this.tariffId,
    this.price,
    this.prepay,
  });

  String? productCode;
  String? productName;
  String? serialNumber;
  int? quantity;
  String? tariffId;
  int? price;
  int? prepay;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productCode: json["productCode"],
        productName: json["productName"],
        serialNumber: json["serialNumber"],
        quantity: json["quantity"],
        tariffId: json["tariffId"],
        price: json["price"],
        prepay: json["prepay"],
      );
}
