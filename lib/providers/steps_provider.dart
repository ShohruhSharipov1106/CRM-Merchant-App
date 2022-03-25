import 'package:crm_merchant/constants/exports.dart';

class StepsProvider extends ChangeNotifier {
  int step = 1;
  incrementStep() {
    step >= 1 ? step += 1 : step = 1;
    notifyListeners();
  }

  decrementStep() {
    step <= 8 ? step -= 1 : step = 8;
  }
}
