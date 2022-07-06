import 'package:crm_merchant/constants/exports.dart';

class AddressNowFieldContainer extends StatelessWidget {
  const AddressNowFieldContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kHeight(50.0).h,
      width: kWidth(368.0).w,
      margin: EdgeInsets.symmetric(
        horizontal: kWidth(kInpHorPad).w,
        vertical: kHeight(kInpVerPad).h,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: kBlackTextColor.withOpacity(0.5),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: context.watch<AddProposalProvider>().temporaryAddress != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  "${context.read<AddProposalProvider>().temporaryAddress}",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: kBlackTextColor.withOpacity(0.5),
                        overflow: TextOverflow.ellipsis,
                      ),
                  maxFontSize: 12.0,
                  minFontSize: 3.0,
                  overflow: TextOverflow.fade,
                  maxLines: 3,
                ),
                SvgPicture.asset("assets/icons/down_black.svg"),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "* * * * * * * * * * * * * * *",
                  style: TextStyle(
                    color: kBlackTextColor.withOpacity(0.5),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SvgPicture.asset("assets/icons/down_black.svg"),
              ],
            ),
    );
  }
}
