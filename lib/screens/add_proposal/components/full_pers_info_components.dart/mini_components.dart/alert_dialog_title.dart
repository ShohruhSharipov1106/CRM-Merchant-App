// ignore_for_file: must_be_immutable

import 'package:crm_merchant/constants/exports.dart';

class AlertDialogTitle extends StatelessWidget {
  String title;
  AlertDialogTitle(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LocaleText(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 18.0,
                color: kBlackTextColor,
              ),
        ),
        SvgPicture.asset(
          "assets/icons/up_black.svg",
          height: kHeight(14.0).h,
          width: kWidth(14.0).w,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
