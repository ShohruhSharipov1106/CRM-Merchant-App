import 'package:crm_merchant/constants/exports.dart';

class HomePageProvider extends ChangeNotifier {
  String hideText = "Подробней...";
  bool isVisible = false;

  increaseSize() {
    hideText = "Скрыть...";
    isVisible = true;
    notifyListeners();
  }

  decreaseSize() {
    hideText = "Подробней...";
    isVisible = false;
    notifyListeners();
  }

  
}
