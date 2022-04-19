import 'package:crm_merchant/constants/exports.dart';

class ListenableButton extends StatelessWidget {
  String buttonTitle;
  Function buttonFunc;
  ValueListenable<TextEditingValue> inputController;
  int inputLength;

  ListenableButton(
    this.buttonTitle,
    this.buttonFunc,
    this.inputController,
    this.inputLength, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: inputController,
      builder: (context, value, child) {
        return ElevatedButton(
          child: Text(
            buttonTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          style: ElevatedButton.styleFrom(
            primary: value.text.length >= inputLength || itemList.isNotEmpty
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
          onPressed: value.text.length >= inputLength || itemList.isNotEmpty
              ? () => buttonFunc()
              : () => {},
        );
      },
    );
  }
}
