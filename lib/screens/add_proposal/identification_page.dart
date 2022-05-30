import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/make_proposal_page.dart';

class IdentificationPage extends StatelessWidget {
  const IdentificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              height: kHeight(32.0).h,
              padding: EdgeInsets.only(left: kWidth(kMainPadding).w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    child: const Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 21.0,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  TitleOfPage("identification", kWidth(90.0).w),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _titleAnimation(),
            const SizedBox(height: 11),
            _titleField(context),
            const SizedBox(height: 20),
            _mainBody(context),
            const Spacer(),
            _button(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Container _mainBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 56),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: kWhiteColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _pieceOfInformations(
            context,
            "full_name",
            "${context.watch<AddProposalProvider>().fullName}",
          ),
          _pieceOfInformations(
            context,
            "place_of_residence",
            "${context.watch<AddProposalProvider>().permanentAddress}",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _pieceOfInformations(
                context,
                "passportNumber",
                context
                    .read<AddProposalProvider>()
                    .serialNumberOfpassport
                    .text
                    .removeAllWhitespace
                    .toUpperCase(),
              ),
              _pieceOfInformations(
                context,
                "birthday",
                context.watch<AddProposalProvider>().birthDate!,
              ),
            ],
          ),
          _pieceOfInformations(
            context,
            "phoneNumber",
            context.watch<AddProposalProvider>().addProposalPhoneNumber.text.removeAllWhitespace,
          ),
        ],
      ),
    );
  }

  Column _pieceOfInformations(
    BuildContext context,
    String title,
    String informText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LocaleText(
          title,
          style:
              Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 10.0),
        ),
        SizedBox(height: kHeight(5.0).h),
        Text(
          informText,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(fontWeight: FontWeight.w900),
        ),
      ],
    );
  }

  Padding _titleField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: kWidth(kMainPadding).w),
      child: LocaleText(
        "check_details",
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }

  Padding _button(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: kWidth(kButHorPad).w),
      child: MainButton(
        context,
        "continue",
        () {
          Get.to(const MakeProposalPage());
        },
      ),
    );
  }

  Padding _titleAnimation() {
    return Padding(
      padding: EdgeInsets.only(left: kWidth(130.0).w),
      child: Stack(
        children: [
          SizedBox(
            height: kHeight(130.0).h,
            width: kWidth(165.0).w,
            child: SvgPicture.asset(
              "assets/icons/main_icon.svg",
              height: kHeight(121.07).h,
              width: kWidth(130.05).w,
            ),
          ),
          Positioned(
            child: FadeIn(
              duration: const Duration(seconds: 5),
              child: SvgPicture.asset(
                "assets/icons/passport.svg",
                height: kHeight(86.5).h,
                width: kWidth(86).w,
              ),
            ),
            left: 0,
            bottom: 0,
          ),
          Positioned(
            child: FadeInDown(
              duration: const Duration(seconds: 5),
              child: SvgPicture.asset(
                "assets/icons/check.svg",
                height: kHeight(25.0).h,
                width: kWidth(25.0).w,
              ),
            ),
            right: kWidth(75.0).w,
            bottom: kHeight(75.0).h,
          ),
        ],
      ),
    );
  }
}
