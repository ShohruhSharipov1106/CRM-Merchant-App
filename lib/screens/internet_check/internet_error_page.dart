import 'package:crm_merchant/constants/exports.dart';

class InternetErrorPage extends StatelessWidget {
  const InternetErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleOfPage("no_internet_title"),
              SizedBox(height: kHeight(150.0).h),
              SvgPicture.asset(
                "assets/icons/error-internet.svg",
                height: kHeight(300.0).h,
                width: kWidth(300.0).w,
                fit: BoxFit.cover,
              ),
              SizedBox(height: kHeight(50.0).h),
              LocaleText(
                "internet_data_error",
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
