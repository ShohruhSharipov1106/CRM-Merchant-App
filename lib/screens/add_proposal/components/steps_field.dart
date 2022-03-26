import 'package:crm_merchant/constants/exports.dart';

class StepsField extends StatelessWidget {
  const StepsField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StepsProvider ctxWatchStepPro = context.watch<StepsProvider>();
    return SizedBox(
      height: kHeight(30.0).h,
      child: Column(
        children: [
          Container(
            height: kHeight(20.0).h,
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
                    context.read<StepsProvider>().decrementStep();
                  },
                ),
                SizedBox(width: kWidth(150.0).w),
                Text(
                  "${ctxWatchStepPro.step}/8",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: kHeight(4.0).h,
          ),
          Container(
            height: kHeight(5.0).h,
            padding: EdgeInsets.only(left: kWidth(kMainPadding).w),
            child: Row(
              children: [
                _stepBox(ctxWatchStepPro, 1),
                SizedBox(width: kWidth(2.0).w),
                _stepBox(ctxWatchStepPro, 2),
                SizedBox(width: kWidth(2.0).w),
                _stepBox(ctxWatchStepPro, 3),
                SizedBox(width: kWidth(2.0).w),
                _stepBox(ctxWatchStepPro, 4),
                SizedBox(width: kWidth(2.0).w),
                _stepBox(ctxWatchStepPro, 5),
                SizedBox(width: kWidth(2.0).w),
                _stepBox(ctxWatchStepPro, 6),
                SizedBox(width: kWidth(2.0).w),
                _stepBox(ctxWatchStepPro, 7),
                SizedBox(width: kWidth(2.0).w),
                _stepBox(ctxWatchStepPro, 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _stepBox(StepsProvider ctxWatchStepPro, int steps) {
    return Container(
      height: kHeight(2.0).h,
      width: kWidth(47.0).w,
      decoration: BoxDecoration(
        color:
            ctxWatchStepPro.step >= steps ? kMainColor : kUnSelectedStepColor,
        borderRadius: BorderRadius.circular(1.0),
      ),
    );
  }
}
