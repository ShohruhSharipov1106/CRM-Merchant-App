import 'package:crm_merchant/constants/exports.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  BuildContext kontext;
  String buttonTitle;
  Function buttonFunc;
  bool showLoader;
  bool isActive;
  CustomButton(
    this.kontext,
    this.buttonTitle,
    this.buttonFunc,
    this.isActive, {
    Key? key,
    this.showLoader = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showLoader
        ? Center(child: CupertinoActivityIndicator(radius: kHeight(16.0).h))
        : ElevatedButton(
            child: Text(
              Locales.string(kontext, buttonTitle),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            style: ElevatedButton.styleFrom(
              primary: isActive ? kYellowButtonColor : kLightYellowButtonColor,
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
            onPressed: isActive ? () => buttonFunc() : () => {},
          );
  }
}
