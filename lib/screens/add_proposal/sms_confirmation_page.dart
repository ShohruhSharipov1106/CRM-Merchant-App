import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/passport_page.dart';

class AddProposalSmsConfirmationPage extends StatefulWidget {
  const AddProposalSmsConfirmationPage({Key? key}) : super(key: key);

  @override
  State<AddProposalSmsConfirmationPage> createState() =>
      _AddProposalSmsConfirmationPageState();
}

class _AddProposalSmsConfirmationPageState
    extends State<AddProposalSmsConfirmationPage>
    with SingleTickerProviderStateMixin {
  TextEditingController smsChecker = TextEditingController();
  AnimationController? _controller;
  int levelClock = 30;

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: levelClock,
      ),
    );

    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addProposalAppBar(
        context,
        "Подтверждение",
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: kHeight(50.0).h),
          Stack(
            children: [
              SizedBox(
                height: kHeight(123).h,
                width: kWidth(175.0).w,
                child: SvgPicture.asset(
                  "assets/icons/main_icon.svg",
                  height: kHeight(122.06).h,
                  width: kWidth(131.12).w,
                ),
              ),
              Positioned(
                child: BounceInDown(
                  duration: const Duration(seconds: 5),
                  child: SvgPicture.asset(
                    "assets/icons/sms.svg",
                    height: kHeight(80.0).h,
                    width: kWidth(110.0).w,
                  ),
                ),
                left: 0,
                bottom: 0,
              ),
            ],
          ),
          SizedBox(height: kHeight(50.0).h),
          Padding(
            padding: const EdgeInsets.only(left: kMainPadding),
            child: Text(
              "Введите код SMS подтверждения  ",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          _smsCode(context),
          Padding(
            padding: EdgeInsets.only(
              left: kWidth(140.0).w,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Countdown(
                  animation: StepTween(
                    begin: levelClock,
                    end: 0,
                  ).animate(_controller!),
                ),
                InkWell(
                  child: Text(
                    "Не пришло SMS ?",
                    style: TextStyle(
                      color: kBlackTextColor.withOpacity(0.5),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  // unreceived sms function
                  onTap: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: kHeight(61.0).h),
          Padding(
            padding: const EdgeInsets.only(left: kButHorPad),
            child: MainButton(
              "Продолжить",
              () => smsChecker.length == 4
                  ? Get.to(const AddProposalPassportPage())
                  : () {},
            ),
          ),
          SizedBox(height: kHeight(53.0).h),
        ],
      ),
    );
  }

  Padding _smsCode(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: kWidth(99.0).w,
        bottom: kHeight(15.0).h,
        top: kHeight(15.0).h,
      ),
      child: Pinput(
        controller: smsChecker,
        preFilledWidget: Text(
          "*",
          style: TextStyle(
            color: kBlackTextColor.withOpacity(0.5),
            fontSize: 64.0,
          ),
        ),
        closeKeyboardWhenCompleted: false,
        defaultPinTheme: PinTheme(
          width: kWidth(50.0).w,
          height: kHeight(60.0).h,
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: kBlackTextColor,
              width: 1.0,
            ),
          ),
          textStyle:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 48.0),
        ),
      ),
    );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    String timerText = clockTimer.inSeconds.remainder(60).toString();
    return Text(
      timerText + " сек  ",
      style: TextStyle(
        color: kBlackTextColor.withOpacity(0.5),
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
