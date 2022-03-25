import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/home/components/full_information.dart';

class HomePageProvider extends ChangeNotifier {
  double mainSzbHeight = kHeight(130.0).h;
  double mainSzbWidth = kWidth(430.0).w;
  double mainContainerHeight = kHeight(98.0).h;
  double mainContainerWidth = kWidth(396.0).w;
  String hideText = "Подробней...";
  bool isVisible = false;
  List<Widget> listOfAllInformation = [];
  List<Widget> listOfDoneInformation = [];
  List<Widget> listOfErrorInformation = [];
  List<Widget> listOfWaitingInformation = [];

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

  addCheckout(Color checkoutColor) {
    listOfAllInformation.add(
      FullInformation(checkoutColor),
    );
    checkoutColor == kGreenLabelColor
        ? listOfDoneInformation.add(
            FullInformation(checkoutColor),
          )
        : (checkoutColor == kGreyLabelColor
            ? listOfWaitingInformation.add(
                FullInformation(checkoutColor),
              )
            : listOfErrorInformation.add(
                FullInformation(checkoutColor),
              ));
    notifyListeners();
  }
}
