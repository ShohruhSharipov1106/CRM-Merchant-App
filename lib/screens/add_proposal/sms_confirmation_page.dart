import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/core/static_datas.dart';
import 'package:crm_merchant/models/marketplace/card_model.dart';
import 'package:crm_merchant/screens/add_proposal/card_added_successfully_page.dart';

// ignore: must_be_immutable
class AddProposalSmsConfirmationPage extends StatefulWidget {
  CardModel model;
  AddProposalSmsConfirmationPage(this.model, {Key? key}) : super(key: key);

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

  bool _showloader = false;

  @override
  Widget build(BuildContext context) {
    cardToken = widget.model.cardToken!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: kHeight(20.0).h),
              StepsField(context, 3),
              const SizedBox(height: 10),
              TitleOfPage("confirmation"),
              const SizedBox(height: 5),
              _animationField(context),
              const SizedBox(height: 15),
              Text(
                Locales.string(context, "card_sms_subtitle") +
                    "(${widget.model.phone.toString()})  " +
                    Locales.string(context, "card_sms_subtitle_2"),
                style: const TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w400,
                  color: kBlackTextColor,
                ),
              ),
              const SizedBox(height: 15),
              _headText(context),
              const SizedBox(height: 10),
              _smsCodeField(context),
              const SizedBox(height: 10),
              _unreceivedSmsField(),
              const SizedBox(height: 50),
              ListenableButton(
                context,
                'continue',
                () {
                  setState(() {
                    _showloader = true;
                  });
                  confirm().whenComplete(() => setState(() {
                        _showloader = false;
                      }));
                },
                smsChecker,
                4,
                showLoader: _showloader,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _unreceivedSmsField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Countdown(
          animation: StepTween(
            begin: levelClock,
            end: 0,
          ).animate(_controller!),
        ),
        GestureDetector(
          child: LocaleText(
            context.watch<AddProposalProvider>().isError
                ? "resend_sms"
                : "sms_not_received",
            style: TextStyle(
              color: kBlackTextColor.withOpacity(0.5),
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          onTap: () async {
            smsChecker.clear();
            await CardService.sendSmsCard(
                    context.read<AddProposalProvider>().cardNumber.text,
                    context.read<AddProposalProvider>().cardExpirationDate.text)
                .then((value) => {
                      value.number =
                          context.read<AddProposalProvider>().cardNumber.text,
                      value.expire = context
                          .read<AddProposalProvider>()
                          .cardExpirationDate
                          .text,
                      Get.to(AddProposalSmsConfirmationPage(value)),
                      context.read<AddProposalProvider>().hasnotError()
                    })
                .onError((error, stackTrace) =>
                    {context.read<AddProposalProvider>().hasError()});
          },
        ),
      ],
    );
  }

  SizedBox _headText(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: LocaleText(
          context.watch<AddProposalProvider>().isError
              ? "error_sms_code"
              : "enter_sms_verification_code",
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: context.watch<AddProposalProvider>().isError
                    ? kMainColor
                    : kBlackTextColor,
              ),
        ),
      ),
    );
  }

  Stack _animationField(BuildContext context) {
    return Stack(
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
    );
  }

  Pinput _smsCodeField(BuildContext context) {
    return Pinput(
      controller: smsChecker,
      preFilledWidget: Text(
        "*",
        style: TextStyle(
          color: kBlackTextColor.withOpacity(0.5),
          fontSize: 64.0,
        ),
      ),
      showCursor: false,
      closeKeyboardWhenCompleted: true,
      separator: const SizedBox(width: 10),
      defaultPinTheme: PinTheme(
        width: 50,
        height: 60,
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
              color: context.watch<AddProposalProvider>().isError &&
                      smsChecker.length == 4
                  ? kMainColor
                  : kBlackTextColor,
            ),
      ),
    );
  }

  Future confirm() async {
    await CardService.sendConfirmCard(widget.model.cardToken!, smsChecker.text)
        .then((value) => {
              value.number = widget.model.number,
              value.expire = widget.model.expire,
              StaticData.addCard(value),
              Get.off(const CardAddedSuccessfullyPage()),
              context.read<AddProposalProvider>().hasnotError(),
            })
        .catchError(
            (error) => {context.read<AddProposalProvider>().hasError()});
  }
}

// ignore: must_be_immutable
class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    String timerText = clockTimer.inSeconds.remainder(60).toString();
    return Visibility(
      visible: timerText == "0" || context.watch<AddProposalProvider>().isError
          ? false
          : true,
      child: Text(
        timerText + " " + Locales.string(context, "sekund") + "  ",
        style: TextStyle(
          color: kBlackTextColor.withOpacity(0.5),
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
