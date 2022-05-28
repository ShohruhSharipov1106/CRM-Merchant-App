class GetMyTariffsModel {
  GetMyTariffsModel({
    this.id,
    this.name,
    this.monthsCount,
    this.markup,
    this.prepayPercent,
    this.partnerId,
  });

  String? id;
  String? name;
  int? monthsCount;
  double? markup;
  double? prepayPercent;
  String? partnerId;

  factory GetMyTariffsModel.fromJson(Map<String, dynamic> json) =>
      GetMyTariffsModel(
        id: json["id"],
        name: json["name"],
        monthsCount: json["monthsCount"],
        markup: json["markup"].toDouble(),
        prepayPercent: json["prepayPercent"],
        partnerId: json["partnerId"],
      );
}
