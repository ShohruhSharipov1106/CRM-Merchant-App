
import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/card_added_successfully_page.dart';

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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kHeight(20.0).h),
            StepsField(context, 3),
            SizedBox(height: kHeight(20.0).h),
            TitleOfPage("Подтверждение", kWidth(123.0).w),
            SizedBox(height: kHeight(5.0).h),
            _animationField(context),
            SizedBox(height: kHeight(20.0).h),
            Padding(
              padding: const EdgeInsets.only(left: kInpHorPad),
              child: Text(
                "Введите код, отправленный на номер телефона (*${phoneNumVarElement.substring(12)}), привязанный к \nкарте",
                style: const TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w400,
                  color: kBlackTextColor,
                ),
              ),
            ),
            SizedBox(height: kHeight(25.0).h),
            _headText(context),
            _smsCodeField(context),
            _unreceivedSmsField(),
            SizedBox(height: kHeight(61.0).h),
            _buttonField(context),
            SizedBox(height: kHeight(53.0).h),
          ],
        ),
      ),
    );
  }

  Padding _unreceivedSmsField() {
    return Padding(
      padding: EdgeInsets.only(
        left: kWidth(140.0).w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: context.watch<AddProposalProvider>().isError ||
                    _controller!.isCompleted
                ? false
                : true,
            child: Countdown(
              animation: StepTween(
                begin: levelClock,
                end: 0,
              ).animate(_controller!),
            ),
          ),
          InkWell(
            child: Text(
              context.watch<AddProposalProvider>().isError
                  ? "Отправить заново"
                  : "Не пришло SMS ?",
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
    );
  }

  Padding _buttonField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kButHorPad),
      child: ListenableButton(
        "Продолжить",
        () {
          if (smsChecker.length == 4) {
            Get.to(const CardAddedSuccessfullyPage());
            context.read<AddProposalProvider>().hasnotError();
          } else {
            context.read<AddProposalProvider>().hasError();
          }
        },
        smsChecker,
        4,
      ),
    );
  }

  Padding _headText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kMainPadding),
      child: Text(
        context.watch<AddProposalProvider>().isError
            ? "Неверный код SMS   "
            : "Введите код SMS подтверждения  ",
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: context.watch<AddProposalProvider>().isError
                  ? kMainColor
                  : kBlackTextColor,
            ),
      ),
    );
  }

  Padding _animationField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: kWidth(125.0).w),
      child: Stack(
        children: [
          SizedBox(
            height: kHeight(123).h,
            width: kWidth(175.0).w,
            child: SvgPicture.asset(
              "assets/icons/main_icon.svg",
              height: kHeight(122.06).h,
              width: kWidth(131.12).w,
              color: context.watch<AddProposalProvider>().isError
                  ? kErrorAnimationColor
                  : kMainColor,
            ),
          ),
          Positioned(
            child: BounceInDown(
              duration: const Duration(seconds: 5),
              child: SvgPicture.asset(
                context.watch<AddProposalProvider>().isError
                    ? "assets/icons/error-sms.svg"
                    : "assets/icons/sms.svg",
                height: kHeight(80.0).h,
                width: kWidth(110.0).w,
              ),
            ),
            left: 0,
            bottom: 0,
          ),
        ],
      ),
    );
  }

  Padding _smsCodeField(BuildContext context) {
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
            color: context.watch<AddProposalProvider>().isError
                ? kMainColor
                : kBlackTextColor.withOpacity(0.5),
            fontSize: 64.0,
          ),
        ),
        showCursor: false,
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
          textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 48.0,
                color: context.watch<AddProposalProvider>().isError
                    ? kMainColor
                    : kBlackTextColor,
              ),
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
