import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/card_page.dart';
import 'package:crm_merchant/screens/add_proposal/identification_page.dart';
import 'package:crm_merchant/screens/add_proposal/passport_identification_page.dart';
import 'package:crm_merchant/screens/add_proposal/passport_page.dart';

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
            TitleOfPage("Карта успешно добавлена", kWidth(40.0).w),
            SizedBox(height: kHeight(30.0).h),
            SizedBox(
              height: kHeight(600.0).h,
              child: ListView.builder(
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: kWidth(56.0).w),
                    child: Column(
                      children: [
                        Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          child: SizedBox(
                            height: kHeight(148.0).h,
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
                                          "${context.watch<AddProposalProvider>().clientDatas[i].text}\n",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                    TextSpan(
                                        text:
                                            "${context.watch<AddProposalProvider>().cardExpirationDate.text}\n"),
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
                        SizedBox(height: kHeight(22.0).h),
                        InkWell(
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
                              context
                                  .watch<AddProposalProvider>()
                                  .cardNumber
                                  .clear();
                              context
                                  .watch<AddProposalProvider>()
                                  .cardExpirationDate
                                  .clear();
                              Get.to(const AddProposalCardPage());
                            }),
                      ],
                    ),
                  );
                },
                itemCount:
                    context.read<AddProposalProvider>().clientCards.length,
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
        "Продолжить",
        () {
          Get.to(const AddProposalPassportPage());
        },
      ),
    );
  }
}
