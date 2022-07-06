import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/models/marketplace/create_req_card_model.dart';
import 'package:crm_merchant/models/marketplace/get_my_tariffs_model.dart';
import 'package:crm_merchant/models/marketplace/product_model.dart';

List<ProductModel> itemList = [];
List<int> summ = [];
List<CreateReqCardModel> createReqCards = [];
int summValue = 0;
GetMyTariffsModel? selectedTariffsModel;
Uint8List? faceUint8List;
String? faceBase64;
String? pasportBase64;
String? propiskiBase64;
String? selfieBase64;
double dailyAmount = 0.0;
String cardToken = "";
