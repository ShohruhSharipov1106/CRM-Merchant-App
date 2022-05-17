import 'package:crm_merchant/constants/exports.dart';

class NoItemPage extends StatelessWidget {
  const NoItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LocaleText(
          "no_item",
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: kHeight(100.0).h),
        SvgPicture.asset(
          "assets/icons/no-item.svg",
          width: kWidth(342.93).w,
          height: kHeight(274.63).h,
        ),
      ],
    );
  }
}
