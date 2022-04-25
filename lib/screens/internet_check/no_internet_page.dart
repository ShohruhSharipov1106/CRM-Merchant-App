import 'package:crm_merchant/constants/exports.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               SizedBox(height: kHeight(100.0).h),
              TitleOfPage(
                "Что-то пошло не так",
                kWidth(25.0).w,
              ),
              SizedBox(height: kHeight(100.0).h),
              Padding(
                padding: EdgeInsets.only(left: kWidth(20.0).w),
                child: SvgPicture.asset(
                  "assets/icons/no-internet.svg",
                  height: kHeight(240.0).h,
                  width: kWidth(296.0).w,
                ),
              ),
              SizedBox(height: kHeight(50.0).h),
              Text(
                "Проверьте подключение к интернету",
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
