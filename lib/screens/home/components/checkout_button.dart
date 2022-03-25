import 'package:crm_merchant/constants/exports.dart';

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.watch<HomePageProvider>().isVisible,
      child: ElevatedButton(
        child: Text(
          "Оформить",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        style: ElevatedButton.styleFrom(
          primary: kYellowButtonColor,
          fixedSize: Size(
            kWidth(200.0).w,
            kHeight(40.0).h,
          ),
          minimumSize: Size(
            kWidth(200.0).w,
            kHeight(40.0).h,
          ),
          elevation: 0,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
