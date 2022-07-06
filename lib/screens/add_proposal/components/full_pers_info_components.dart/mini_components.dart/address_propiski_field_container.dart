import 'package:crm_merchant/constants/exports.dart';

class AddressPropiskiFieldContainer extends StatelessWidget {
  const AddressPropiskiFieldContainer({Key? key}) : super(key: key);

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              child: context.watch<AddProposalProvider>().permanentAddress !=
                      null
                  ? Text(
                      "${context.read<AddProposalProvider>().permanentAddress}",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: kBlackTextColor.withOpacity(0.5),
                            overflow: TextOverflow.ellipsis,
                            fontSize: 8.0,
                          ),
                      // style: TextStyle(color: kBlackTextColor.withOpacity(0.5)),
                      // minFontSize: 3.0, maxFontSize: 12.0, maxLines: 1,
                    )
                  : Text(
                      "* * * * * * * * * * * * * * *",
                      style: TextStyle(
                        color: kBlackTextColor.withOpacity(0.5),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            ),
            const Spacer(),
            SvgPicture.asset("assets/icons/down_black.svg"),
          ],
        ));
  }
}
