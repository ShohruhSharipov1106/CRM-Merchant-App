import 'package:crm_merchant/constants/exports.dart';

// ignore: must_be_immutable
class AddressPropiskiFieldPositioned extends StatelessWidget {
  String string;
  AddressPropiskiFieldPositioned(this.string, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        color: kBackgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: LocaleText(
          string,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 12.0,
                color: kBlackTextColor,
              ),
        ),
      ),
      top: 0,
      left: kWidth(42.0).w,
    );
  }
}
