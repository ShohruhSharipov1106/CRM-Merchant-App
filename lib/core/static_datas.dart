import 'package:crm_merchant/models/marketplace/card_model.dart';
import 'package:crm_merchant/models/marketplace/home_request_model.dart';
import 'package:crm_merchant/models/marketplace/product_model.dart';

import '../models/marketplace/create_request_model.dart';

class StaticData {
  static List<Value> requests = [];
  static CreateRequestModel createRequestModel = CreateRequestModel();
  static List<CardModel> cards = [];
  static List<ProductModel> products = [];

  static addCard(CardModel model) {
    if (!cards.any((element) => element.number == model.number)) {
      cards.add(model);
    }
  }

  static addProduct(ProductModel model) {
    products.add(model);
  }
}
