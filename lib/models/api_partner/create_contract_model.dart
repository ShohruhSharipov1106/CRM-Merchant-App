// To parse this JSON data, do
//
//     final createContract = createContractFromJson(jsonString);

import 'dart:convert';

CreateContract createContractFromJson(String str) => CreateContract.fromJson(json.decode(str));


class CreateContract {
    CreateContract({
        this.contractorId,
        this.description,
        this.items,
    });

    String? contractorId;
    String? description;
    List<Item>? items;

    factory CreateContract.fromJson(Map<String, dynamic> json) => CreateContract(
        contractorId: json["contractorId"],
        description: json["description"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

   
}

class Item {
    Item({
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

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        productCode: json["productCode"],
        productName: json["productName"],
        serialNumber: json["serialNumber"],
        quantity: json["quantity"],
        tariffId: json["tariffId"],
        price: json["price"],
        prepay: json["prepay"],
    );

   
}
