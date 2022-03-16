import 'package:crm_merchant/constants/exports.dart';

class MainButton extends StatelessWidget {
  String buttonTitle;
  Function buttonFunc;
  MainButton(this.buttonTitle, this.buttonFunc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        buttonTitle,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      style: ElevatedButton.styleFrom(
        primary: kYellowButtonColor,
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
      onPressed: () => buttonFunc(),
    );
  }
}
