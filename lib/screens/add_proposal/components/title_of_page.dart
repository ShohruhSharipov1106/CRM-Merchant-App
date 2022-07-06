import 'package:crm_merchant/constants/exports.dart';

// ignore: must_be_immutable
class TitleOfPage extends StatelessWidget {
  String? titleText;
  TitleOfPage(this.titleText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocaleText(
      titleText!,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}
