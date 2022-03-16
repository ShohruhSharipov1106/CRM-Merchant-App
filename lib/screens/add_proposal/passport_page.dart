import 'package:crm_merchant/constants/exports.dart';

class AddProposalPassportPage extends StatelessWidget {
  const AddProposalPassportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addProposalAppBar(
        context,
        "Введите ваши данные",
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: kHeight(50.0).h),
          Stack(
            children: [
              SizedBox(
                height: kHeight(122.06).h,
                width: kWidth(168.0).w,
                child: SvgPicture.asset(
                  "assets/icons/main_icon.svg",
                  height: kHeight(122.06).h,
                  width: kWidth(131.12).w,
                ),
              ),
              Positioned(
                child: FadeInRight(
                  duration: const Duration(seconds: 5),
                  child: SvgPicture.asset(
                    "assets/icons/passport.svg",
                    height: kHeight(88.87).h,
                    width: kWidth(88.16).w,
                  ),
                ),
                left: 0,
                bottom: 0,
              ),
            ],
          ),
          SizedBox(height: kHeight(50.0).h),
          Padding(
            padding: const EdgeInsets.only(left: kMainPadding),
            child: Text(
              "Введите паспортные данные",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          SizedBox(height: kHeight(15.0).h),
          SizedBox(height: kHeight(52.0).h),
          Padding(
            padding: const EdgeInsets.only(left: kButHorPad),
            child: MainButton(
              "Аутентификация по лицу",
              () {},
            ),
          ),
          SizedBox(height: kHeight(53.0).h),
        ],
      ),
    );
  }
}
