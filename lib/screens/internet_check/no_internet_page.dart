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
                "no_internet_title",
                kWidth(45.0).w,
              ),
              SizedBox(height: kHeight(100.0).h),
              Padding(
                padding: EdgeInsets.only(left: kWidth(20.0).w),
                child: SvgPicture.asset(
                  "assets/icons/no-internet.svg",
                  height: kHeight(250.0).h,
                  width: kWidth(300.0).w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: kHeight(120.0).h),
              Padding(
                padding: EdgeInsets.only(left: kWidth(20.0).w),
                child: LocaleText(
                  "no_internet_subtitle",
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
