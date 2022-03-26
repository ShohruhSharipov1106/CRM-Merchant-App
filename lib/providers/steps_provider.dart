import 'package:crm_merchant/constants/exports.dart';

class StepsProvider extends ChangeNotifier {
  int step = 1;
  incrementStep() {
    step < 8 ? step += 1 : step = 8;
    notifyListeners();
  }

  decrementStep() {
    step > 1 ? step -= 1 : step = 1;
    notifyListeners();
  }
}
