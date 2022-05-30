// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    ProductModel({
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

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
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
