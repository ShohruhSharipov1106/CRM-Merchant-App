import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/home/components/checkout_button.dart';

// ignore: must_be_immutable
class FullInformation extends StatelessWidget {
  String? situationColor;
  int numb;
  String dateProposal;
  String amount;
  String createdBy;
  String reasonCancellation;
  String customer;

  FullInformation(this.situationColor, this.numb, this.dateProposal,
      this.amount, this.createdBy, this.reasonCancellation, this.customer,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageProvider ctxWatchHomeProvider = context.watch<HomePageProvider>();
    HomePageProvider ctxReadHomeProvider = context.read<HomePageProvider>();

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: kMainPadding,
            vertical: 15,
          ),
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 5,
          ),
          //height: ctxWatchHomeProvider.mainContainerHeight,
          //width: ctxWatchHomeProvider.mainContainerWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _informations(context, "date_proposal", dateProposal),
                  const SizedBox(
                    height: 11,
                  ),
                  _informations(
                    context,
                    "proposal_amount",
                    amount.toString(),
                  ),
                  Column(
                    children: ctxWatchHomeProvider.isVisible
                        ? [
                            const SizedBox(
                              height: 11,
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            _informations(
                              context,
                              "created",
                              createdBy,
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            situationColor == "Declined"
                                ? _informations(
                                    context,
                                    "cause",
                                    reasonCancellation,
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 11,
                            ),
                            _informations(
                              context,
                              "customer",
                              customer,
                            ),
                            situationColor == "Confirmed"
                                ? const CheckOutButton()
                                : const SizedBox(),
                          ]
                        : [],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  _hideUnhideText(
                      context, ctxWatchHomeProvider, ctxReadHomeProvider),
                ],
              ),
            ],
          ),
          decoration: const BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
        ),
        _chipField(context),
      ],
    );
  }

  InkWell _hideUnhideText(
      BuildContext context,
      HomePageProvider ctxWatchHomeProvider,
      HomePageProvider ctxReadHomeProvider) {
    return InkWell(
      child: Text(
        ctxWatchHomeProvider.hideText,
        style: const TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w400,
          color: kGreyLabelColor,
        ),
      ),
      splashColor: kGreenLabelColor,
      onTap: () =>
          ctxWatchHomeProvider.hideText == Locales.string(context, 'hide')
              ? ctxReadHomeProvider.increaseSize()
              : ctxReadHomeProvider.decreaseSize(),
    );
  }

  Row _informations(BuildContext context, String title, String information) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LocaleText(
          title,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        Expanded(
          child: Text(
            information,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(overflow: TextOverflow.fade),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Positioned _chipField(BuildContext context) {
    return Positioned(
      child: SizedBox(
        height: 30,
        child: Chip(
          label: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "№$numb  ",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: situationColor == "Confirmed"
                      ? Locales.string(context, "approved")
                      : situationColor == 'Declined'
                          ? Locales.string(context, "denied")
                          : Locales.string(context, "under_consideration"),
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: situationColor == "Confirmed"
                            ? kGreenLabelColor
                            : situationColor == 'Declined'
                                ? kMainColor
                                : kGreyLabelColor,
                      ),
                ),
              ],
            ),
          ),
          backgroundColor: kWhiteColor,
          elevation: kHeight(8.0).h,
          shadowColor: kBlackTextColor.withOpacity(0.75),
        ),
      ),
      top: kHeight(0.0).h,
      left: kWidth(16.0).w,
    );
  }
}
