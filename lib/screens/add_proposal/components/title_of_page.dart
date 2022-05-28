import 'package:crm_merchant/constants/exports.dart';

// ignore: must_be_immutable
class TitleOfPage extends StatelessWidget {
  String? titleText;
  double? leftPadding;
  TitleOfPage(this.titleText, this.leftPadding, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: leftPadding!,
      ),
      child: LocaleText(
        titleText!,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
