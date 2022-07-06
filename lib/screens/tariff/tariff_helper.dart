import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/models/marketplace/get_my_tariffs_model.dart';
import 'package:time/time.dart';

DateTime addMonths(DateTime dateTime, int month) {
  int day = dateTime.day;
  DateTime nextMonth = DateTime(dateTime.year, dateTime.month + month, 1);
  int nextMonthInDay = nextMonth.daysInMonth;

  if (day > nextMonthInDay) {
    return DateTime(dateTime.year, dateTime.month + month, nextMonthInDay);
  } else {
    return DateTime(dateTime.year, dateTime.month + month, day);
  }
}

void tarifSelected(GetMyTariffsModel tarif) {
  selectedTariffsModel = tarif;
  calculateDaily(0);
}

void calculateDaily(num prepayed) {
  if (selectedTariffsModel == null) return;
  DateTime dateExpire =
      addMonths(DateTime.now(), selectedTariffsModel?.monthsCount ?? 0);
  int days = (dateExpire.difference(DateTime.now())).inDays;
  if (days == 0) return;

  double amount = (summValue - prepayed) * (1+ (selectedTariffsModel?.markup ?? 0));
  dailyAmount = amount / days;
}
