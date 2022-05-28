import 'package:crm_merchant/models/marketplace/card_model.dart';
import 'package:crm_merchant/models/marketplace/home_request_model.dart';

import '../models/marketplace/create_request_model.dart';

class StaticData {
  static List<RequestModel> requests = [];
  static CreateRequest createRequestModel = CreateRequest();
  static List<CardModel> cards = [];

  static addCard(CardModel model) {
    if (!cards.any((element) => element.number == model.number)) {
    cards.add(model);
    }
  }
}
