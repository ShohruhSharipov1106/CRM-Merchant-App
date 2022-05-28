import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/core/static_datas.dart';
import 'package:crm_merchant/screens/add_proposal/card_page.dart';
import 'package:crm_merchant/screens/add_proposal/passport_page.dart';

class CardAddedSuccessfullyPage extends StatelessWidget {
  const CardAddedSuccessfullyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kHeight(20.0).h),
            StepsField(context, 3),
            const SizedBox(height: 20),
            TitleOfPage("card_add_success", kWidth(40.0).w),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    for (int i = 0; i < StaticData.cards.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                          bottom: 20,
                        ),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 27,
                              top: 15,
                              bottom: 14,
                            ),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text:
                                          "${StaticData.cards[i].ps.toString().toUpperCase()}\n"),
                                  TextSpan(
                                    text: "\n${StaticData.cards[i].number}\n",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  TextSpan(
                                      text: "${StaticData.cards[i].expire}\n"),
                                  TextSpan(
                                      text:
                                          "\n${StaticData.cards[i].holderName}"),
                                ],
                              ),
                              style: Theme.of(context).textTheme.labelMedium,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                    Center(
                      child: InkWell(
                        child: const Material(
                          elevation: 4.0,
                          color: kYellowButtonColor,
                          shape: CircleBorder(),
                          child: Icon(
                            Icons.add,
                            size: 57,
                            color: kWhiteColor,
                          ),
                        ),
                        onTap: () {
                          context
                              .read<AddProposalProvider>()
                              .cardNumber
                              .clear();
                          context
                              .read<AddProposalProvider>()
                              .cardExpirationDate
                              .clear();
                          Get.to(const AddProposalCardPage());
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            // SizedBox(
            //   height: kHeight(530.0).h,
            //   child: ListView.builder(
            //     itemBuilder: (context, i) {
            //       return Padding(
            //         padding: const EdgeInsets.only(
            //           left: 35,
            //           right: 35,
            //           bottom: 30,
            //         ),
            //         child: Material(
            //           elevation: 5.0,
            //           borderRadius: BorderRadius.circular(30.0),
            //           child: Padding(
            //             padding: const EdgeInsets.only(
            //               left: 37,
            //               top: 15,
            //               bottom: 14,
            //             ),
            //             child: Text.rich(
            //               TextSpan(
            //                 children: [
            //                   TextSpan(
            //                       text:
            //                           "${StaticData.cards[i].ps.toString().toUpperCase()}\n"),
            //                   TextSpan(
            //                     text: "\n${StaticData.cards[i].number}\n",
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .headlineLarge!
            //                         .copyWith(fontWeight: FontWeight.w500),
            //                   ),
            //                   TextSpan(
            //                       text: "${StaticData.cards[i].expire}\n"),
            //                   TextSpan(
            //                       text:
            //                           "\n${StaticData.cards[i].holderName}"),
            //                 ],
            //               ),
            //               style: Theme.of(context).textTheme.labelMedium,
            //               textAlign: TextAlign.start,
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //     itemCount: StaticData.cards.length,
            //   ),
            // ),

            const SizedBox(height: 20),
            _button(context),
          ],
        ),
      ),
    );
  }

  Padding _button(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: kWidth(kButHorPad).w, bottom: 30),
      child: MainButton(
        context,
        "continue",
        () {
          Get.to(const AddProposalPassportPage());
        },
      ),
    );
  }
}
