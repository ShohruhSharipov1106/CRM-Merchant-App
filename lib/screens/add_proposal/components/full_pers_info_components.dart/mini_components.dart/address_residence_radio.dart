import 'package:crm_merchant/constants/exports.dart';

class AddressResidenceRadio extends StatelessWidget {
  const AddressResidenceRadio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: kWidth(8.0).w),
      child: SizedBox(
        height: kHeight(50.0).h,
        width: 100.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: kHeight(50.0).h,
              width: kWidth(368.0 / 2).w,
              child: RadioListTile(
                activeColor: kBlackTextColor,
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                value: context.watch<AddProposalProvider>().another,
                title: LocaleText(
                  "another",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontSize: 12.0),
                ),
                groupValue:
                    context.watch<AddProposalProvider>().addressOfResidence,
                onChanged: (v) =>
                    context.read<AddProposalProvider>().changeAddress(),
              ),
            ),
            SizedBox(
              height: kHeight(50.0).h,
              width: kWidth(368.0 / 2).w,
              child: RadioListTile(
                activeColor: kBlackTextColor,
                value:
                    context.watch<AddProposalProvider>().placeOfResidencevalue,
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                title: LocaleText(
                  "place_of_residence",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontSize: 12.0),
                ),
                groupValue:
                    context.watch<AddProposalProvider>().addressOfResidence,
                onChanged: (v) =>
                    context.read<AddProposalProvider>().changeAddress(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
