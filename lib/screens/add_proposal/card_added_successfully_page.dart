import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/card_page.dart';

class CardAddedSuccessfullyPage extends StatelessWidget {
  const CardAddedSuccessfullyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kHeight(20.0).h),
            StepsField(context, 3),
            SizedBox(height: kHeight(20.0).h),
            TitleOfPage("card_add_success", kWidth(40.0).w),
            SizedBox(height: kHeight(30.0).h),
            SizedBox(
              height: kHeight(550.0).h,
              child: ListView.builder(
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kWidth(56.0).w,
                      vertical: kHeight(25.0).h,
                    ),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      child: SizedBox(
                        height: kHeight(190.0).h,
                        width: kWidth(316.0).w,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: kWidth(30.0).w,
                            top: kHeight(15.0).h,
                          ),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(text: "HUMO\n"),
                                TextSpan(
                                  text:
                                      "${context.read<AddProposalProvider>().cards[i][0]}\n",
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                TextSpan(
                                    text:
                                        "${context.read<AddProposalProvider>().cards[i][1]}\n"),
                                const TextSpan(
                                  text: "VIKTOR KAMAROV VIKTOROVICH"),
                              ],
                            ),
                            style: Theme.of(context).textTheme.labelMedium,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount:
                    context.read<AddProposalProvider>().cards.length,
              ),
            ),
            SizedBox(height: kHeight(22.0).h),
            Padding(
              padding: EdgeInsets.only(left: kWidth(180.0).w),
              child: InkWell(
                child: Material(
                  elevation: 4.0,
                  color: kYellowButtonColor,
                  shape: const CircleBorder(),
                  child: Padding(
                    padding: EdgeInsets.all(kHeight(5.0).h),
                    child: Icon(
                      Icons.add,
                      size: kHeight(47.0).h,
                      color: kWhiteColor,
                    ),
                  ),
                ),
                // add phone number
                onTap: () {
                  context.read<AddProposalProvider>().cardNumber.clear();
                  context
                      .read<AddProposalProvider>()
                      .cardExpirationDate
                      .clear();
                  Get.to(const AddProposalCardPage());
                },
              ),
            ),
            SizedBox(height: kHeight(50.0).h),
            _button(context),
          ],
        ),
      ),
    );
  }

  Padding _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kButHorPad),
      child: MainButton(
        context,
        "continue",
        () {
          // // Get.to(const AddProposalPassportPage());
          // print(context.read<AddProposalProvider>().clientCards[0][1]);
          // print(context.read<AddProposalProvider>().clientCards[0][0]);
          print(context.read<AddProposalProvider>().clientCards);
        },
      ),
    );
  }
}
