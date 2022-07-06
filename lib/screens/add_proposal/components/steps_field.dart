import 'package:crm_merchant/constants/exports.dart';

// ignore: must_be_immutable
class StepsField extends StatelessWidget {
  BuildContext kontext;
  int step;
  StepsField(this.kontext, this.step, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kHeight(40.0).h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: kHeight(30.0).h,
            padding: const EdgeInsets.only(left: kMainPadding),
            child: Row(
              children: [
                GestureDetector(
                  child: const Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 21.0,
                  ),
                  onTap: () => Navigator.pop(context),
                ),
                const Spacer(flex: 21),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "$step",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                              fontWeight: FontWeight.w700,
                              color:
                                  kontext.watch<AddProposalProvider>().isError
                                      ? kMainColor
                                      : kBlackTextColor,
                            ),
                      ),
                      const TextSpan(text: "/8"),
                    ],
                  ),
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const Spacer(flex: 25),
              ],
            ),
          ),
          Container(
            height: kHeight(5.0).h,
            padding: const EdgeInsets.only(left: kMainPadding),
            child: Row(
              children: [
                _stepBox(step, 1),
                SizedBox(width: kWidth(2.0).w),
                _stepBox(step, 2),
                SizedBox(width: kWidth(2.0).w),
                _stepBox(step, 3),
                SizedBox(width: kWidth(2.0).w),
                _stepBox(step, 4),
                SizedBox(width: kWidth(2.0).w),
                _stepBox(step, 5),
                SizedBox(width: kWidth(2.0).w),
                _stepBox(step, 6),
                SizedBox(width: kWidth(2.0).w),
                _stepBox(step, 7),
                SizedBox(width: kWidth(2.0).w),
                _stepBox(step, 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _stepBox(int qadam, int steps) {
    return Container(
      height: kHeight(2.0).h,
      width: kWidth(47.0).w,
      decoration: BoxDecoration(
        color: qadam >= steps ? kMainColor : kUnSelectedStepColor,
        borderRadius: BorderRadius.circular(1.0),
      ),
    );
  }
}
