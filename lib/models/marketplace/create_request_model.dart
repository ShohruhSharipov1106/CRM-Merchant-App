// To parse this JSON data, do
//
//     final createRequestModel = createRequestModelFromJson(jsonString);

import 'dart:convert';

CreateRequestModel createRequestModelFromJson(String str) => CreateRequestModel.fromJson(json.decode(str));

String createRequestModelToJson(CreateRequestModel data) => json.encode(data.toJson());

class CreateRequestModel {
    CreateRequestModel({
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

    factory CreateRequestModel.fromJson(Map<String, dynamic> json) => CreateRequestModel(
        marketplaceId: json["marketplaceId"],
        partnerId: json["partnerId"],
        contractor: Contractor.fromJson(json["contractor"]),
        cards: List<Card>.from(json["cards"].map((x) => Card.fromJson(x))),
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "marketplaceId": marketplaceId,
        "partnerId": partnerId,
        "contractor": contractor!.toJson(),
        "cards": List<dynamic>.from(cards!.map((x) => x.toJson())),
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
    };
}

class Card {
    Card({
        required this.contractorId,
        this.number,
        this.validity,
        this.token,
        this.holderName,
        this.phone,
        this.ps,
    });

    String contractorId = "3fa85f64-5717-4562-b3fc-2c963f66afa6";
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

    Map<String, dynamic> toJson() => {
        "contractorId": contractorId,
        "number": number,
        "validity": validity!.toIso8601String(),
        "token": token,
        "holderName": holderName,
        "phone": phone,
        "ps": ps,
    };
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

    Map<String, dynamic> toJson() => {
        "givenName": givenName,
        "surName": surName,
        "patronymic": patronymic,
        "sex": sex,
        "language": language,
        "docTypeId": docTypeId,
        "pinfl": pinfl,
        "tin": tin,
        "docSeries": docSeries,
        "docNumber": docNumber,
        "docDateOfIssue": docDateOfIssue!.toIso8601String(),
        "docDateOfExpire": docDateOfExpire!.toIso8601String(),
        "docAuthority": docAuthority,
        "dateOfBirth": dateOfBirth!.toIso8601String(),
        "address": address,
        "residenceAddress": residenceAddress,
        "phone1": phone1,
        "phone2": phone2,
        "phone3": phone3,
    };
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

    Map<String, dynamic> toJson() => {
        "productCode": productCode,
        "productName": productName,
        "serialNumber": serialNumber,
        "quantity": quantity,
        "tariffId": tariffId,
        "price": price,
        "prepay": prepay,
    };
}
