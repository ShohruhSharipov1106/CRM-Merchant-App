import 'package:crm_merchant/constants/exports.dart';

// ignore: must_be_immutable
class ListenableButton extends StatelessWidget {
  BuildContext kontext;
  String buttonTitle;
  Function buttonFunc;
  ValueListenable<TextEditingValue> inputController;
  bool showLoader;
  int inputLength;
  ListenableButton(
    this.kontext,
    this.buttonTitle,
    this.buttonFunc,
    this.inputController,
    this.inputLength, {
    Key? key,
    this.showLoader = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: inputController,
      builder: (context, value, child) {
        return showLoader
            ? Lottie.asset(
              "assets/images/lottie/loading_indicator.json",
              height: kHeight(100.0).h,
              width: kWidth(100.0).w,
            )
            : ElevatedButton(
                child: Text(
                  Locales.string(kontext, buttonTitle),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                style: ElevatedButton.styleFrom(
                  primary:
                      value.text.length >= inputLength || itemList.isNotEmpty
                          ? kYellowButtonColor
                          : kLightYellowButtonColor,
                  fixedSize: Size(
                    kWidth(269.0).w,
                    kHeight(60.0).h,
                  ),
                  minimumSize: Size(
                    kWidth(269.0).w,
                    kHeight(60.0).h,
                  ),
                  elevation: 4.0,
                  alignment: Alignment.center,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed:
                    value.text.length >= inputLength || itemList.isNotEmpty
                        ? () => buttonFunc()
                        : () => {},
              );
      },
    );
  }
}
