import 'dart:math';

List<int> clientPhoneChecker =
    List.generate(100, (index) => Random().nextInt(8999) + 1000);

int checkSMS = clientPhoneChecker[0];

class GetRandNum {
  static int increaseRandPlace = 0;

  int checkSMS = clientPhoneChecker[increaseRandPlace];
}
