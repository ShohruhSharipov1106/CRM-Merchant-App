import 'package:crm_merchant/constants/exports.dart';

class HomePageProvider extends ChangeNotifier {
  double mainSzbHeight = kHeight(130.0).h;
  double mainSzbWidth = kWidth(430.0).w;
  double mainContainerHeight = kHeight(98.0).h;
  double mainContainerWidth = kWidth(396.0).w;
  String hideText = "Подробней...";
  bool isVisible = false;

  increaseSize() {
    mainSzbHeight = kHeight(317.0).h;
    mainSzbWidth = kWidth(430.0).w;
    mainContainerHeight = kHeight(285.0).h;
    mainContainerWidth = kWidth(396.0).w;
    hideText = "Скрыть...";
    isVisible = true;
    notifyListeners();
  }

  decreaseSize() {
    mainSzbHeight = kHeight(130.0).h;
    mainSzbWidth = kWidth(430.0).w;
    mainContainerHeight = kHeight(98.0).h;
    mainContainerWidth = kWidth(396.0).w;
    hideText = "Подробней...";
    isVisible = false;
    notifyListeners();
  }
}
