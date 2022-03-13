import 'package:crm_merchant/constants/colors.dart';
import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/constants/sizer.dart';

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
      ),
      style: ElevatedButton.styleFrom(
        primary: kWhiteColor,
        fixedSize: Size(
          kWidth(269.0).w,
          kHeight(60.0).h,
        ),
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onPressed: () => buttonFunc,
    );
  }
}
