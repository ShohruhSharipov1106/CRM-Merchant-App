import 'package:crm_merchant/constants/exports.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: Column(
          children: [
            TitleOfPage(
              "Что-то\nпошло не так",
              kWidth(88.0).w,
            ),
            SizedBox(height: kHeight(100.0).h),
            SvgPicture.asset(
              "assets/icons/no-internet.svg",
              height: kHeight(240.0).h,
              width: kWidth(296.0).w,
            ),
            SizedBox(height: kHeight(50.0).h),
            Text(
              "Проверьте подключение к интернету",
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            )
          ],
        ),
        onRefresh: () async {},
      ),
    );
  }
}
