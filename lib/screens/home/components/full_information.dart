import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/home/components/checkout_button.dart';

// ignore: must_be_immutable
class FullInformation extends StatefulWidget {
  String? situationColorFull;
  int numbFull;
  String dateProposalFull;
  String amountFull;
  String createdByFull;
  String reasonCancellationFull;
  String customerFull;
  bool isVisible;

  FullInformation(
      this.situationColorFull,
      this.numbFull,
      this.dateProposalFull,
      this.amountFull,
      this.createdByFull,
      this.reasonCancellationFull,
      this.customerFull,
      this.isVisible,
      {Key? key})
      : super(key: key);

  @override
  State<FullInformation> createState() => _FullInformationState();
}

class _FullInformationState extends State<FullInformation> {
  @override
  Widget build(BuildContext context) {

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _informations(
                      context, "date_proposal", widget.dateProposalFull),
                  const SizedBox(
                    height: 11,
                  ),
                  _informations(
                    context,
                    "proposal_amount",
                    widget.amountFull.toString(),
                  ),
                  Column(
                    children: widget.isVisible
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
                              widget.createdByFull,
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            widget.situationColorFull == "Declined"
                                ? _informations(
                                    context,
                                    "cause",
                                    widget.reasonCancellationFull,
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 11,
                            ),
                            _informations(
                              context,
                              "customer",
                              widget.customerFull,
                            ),
                            widget.situationColorFull == "Confirmed"
                                ? const CheckOutButton()
                                : const SizedBox(),
                          ]
                        : [],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    child: LocaleText(
                      widget.isVisible ? "hide" : "more",
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: kGreyLabelColor,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        widget.isVisible = !widget.isVisible;
                      });
                    },
                  ),
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
                  text: "№${widget.numbFull}  ",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: widget.situationColorFull == "Confirmed"
                      ? Locales.string(context, "approved")
                      : widget.situationColorFull == 'Declined'
                          ? Locales.string(context, "denied")
                          : Locales.string(context, "under_consideration"),
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: widget.situationColorFull == "Confirmed"
                            ? kGreenLabelColor
                            : widget.situationColorFull == 'Declined'
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
