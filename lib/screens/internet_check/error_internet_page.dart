import 'package:crm_merchant/constants/exports.dart';

class ErrorInternetPage extends StatelessWidget {
  const ErrorInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: Column(
          children: [
            TitleOfPage("Что-то\nпошло не так", kWidth(88.0).w),
            SizedBox(height: kHeight(100.0).h),
            SvgPicture.asset(
              "assets/icons/error-internet.svg",
              height: kHeight(278.0).h,
              width: kWidth(278.0).w,
            ),
            SizedBox(height: kHeight(50.0).h),
            Text(
              "Технические неполадки\nскоро все будет",
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
