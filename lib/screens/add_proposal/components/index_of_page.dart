import 'package:crm_merchant/constants/exports.dart';

class IndexOfPage extends StatelessWidget {
  const IndexOfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: kWidth(19.0).w,
        vertical: kHeight(10.0).h,
      ),
      child: SizedBox(
        height: kHeight(14.0),
        width: kWidth(390.0),
      ),
    );
  }
}
