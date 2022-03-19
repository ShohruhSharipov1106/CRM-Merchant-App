import 'package:crm_merchant/constants/exports.dart';

class TitleOfPage extends StatelessWidget {
  String? titleText;
  double? leftPadding;
  TitleOfPage(this.titleText, this.leftPadding, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: leftPadding!.w,
      ),
      child: Text(
        titleText.toString(),
        style:
            Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 24.0),
      ),
    );
  }
}
