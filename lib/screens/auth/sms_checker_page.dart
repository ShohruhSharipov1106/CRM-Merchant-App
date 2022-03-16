import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/home/home_page.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:pinput/pinput.dart';

class SmsCheckerPage extends StatefulWidget {
  const SmsCheckerPage({Key? key}) : super(key: key);

  @override
  State<SmsCheckerPage> createState() => _SmsCheckerPageState();
}

class _SmsCheckerPageState extends State<SmsCheckerPage> {
  final CountdownTimer _leftTime = CountdownTimer(endTime: 30);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kHeight(72.0).h),
            Padding(
              padding: EdgeInsets.only(left: kWidth(123.0).w),
              child: Text(
                "Подтверждение",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SizedBox(height: kHeight(99.0).h),
            Padding(
              padding: const EdgeInsets.only(left: kMainPadding),
              child: Text(
                "Введите код SMS подтверждения",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            _smsInputField(context),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kWidth(157.0),
              ),
              child: TextButton(
                child: Text(
                  "${_leftTime.endTime} сек Не пришло SMS ?",
                  style: TextStyle(
                    color: kBlackTextColor.withOpacity(0.5),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(height: kHeight(140.0).h),
            Padding(
              padding: const EdgeInsets.only(left: kButHorPad),
              child: MainButton(
                "Продолжить",
                () => context
                        .watch<SignUpProvider>()
                        .pinputKey
                        .currentState!
                        .validate()
                    ? Get.to(const HomePage())
                    : () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Padding _smsInputField(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(
      left: kWidth(99.0).w,
      bottom: kHeight(15.0).h,
      top: kHeight(15.0).h,
    ),
    child: Pinput(
      key: context.watch<SignUpProvider>().pinputKey,
      controller: context.watch<SignUpProvider>().smsChecker,
      preFilledWidget: Text(
        "*",
        style: TextStyle(
          color: kBlackTextColor.withOpacity(0.5),
          fontSize: 64.0,
        ),
      ),
      closeKeyboardWhenCompleted: false,
      defaultPinTheme: PinTheme(
        width: kWidth(50.0).w,
        height: kHeight(60.0).h,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        textStyle:
            Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 48.0),
      ),
    ),
  );
}
