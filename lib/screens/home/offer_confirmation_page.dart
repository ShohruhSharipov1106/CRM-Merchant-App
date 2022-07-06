import 'dart:math';

import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/card_page.dart';

// ignore: must_be_immutable
class OfferConfirmationPage extends StatefulWidget {
  int _smsCode;
  OfferConfirmationPage(this._smsCode, {Key? key}) : super(key: key);

  @override
  State<OfferConfirmationPage> createState() => _OfferConfirmationPageState();
}

class _OfferConfirmationPageState extends State<OfferConfirmationPage>
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
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            size: 21.0,
            color: kBlackTextColor,
          ),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _mainTitle(context),
              const SizedBox(height: 80),
              _title(context),
              const SizedBox(height: 10),
              _smsCode(context),
              const SizedBox(height: 10),
              Row(
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
                    onTap: () {
                      smsChecker.clear();
                      final int _sendSMSAgain = Random().nextInt(8999) + 1000;
                      widget._smsCode = _sendSMSAgain;
                      SendSMSService.sendSmsToClient(
                        context
                            .read<AddProposalProvider>()
                            .addProposalPhoneNumber
                            .text
                            .removeAllWhitespace
                            .substring(1),
                        _sendSMSAgain.toString(),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 90),
              _button(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _title(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
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

  LocaleText _mainTitle(BuildContext context) {
    return LocaleText(
      "offer_confirmation",
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }

  Pinput _smsCode(BuildContext context) {
    return Pinput(
      controller: smsChecker,
      mainAxisAlignment: MainAxisAlignment.center,
      preFilledWidget: Text(
        "*",
        style: TextStyle(
          color: kBlackTextColor.withOpacity(0.5),
          fontSize: 64.0,
        ),
      ),
      separator: const SizedBox(width: 10),
      showCursor: false,
      closeKeyboardWhenCompleted: false,
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

  ListenableButton _button() {
    return ListenableButton(
      context,
      'continue',
      () => smsChecker.text == widget._smsCode.toString()
          ? {
              Get.off(const AddProposalCardPage()),
              context.read<AddProposalProvider>().hasnotError(),
            }
          : {
              context.read<AddProposalProvider>().hasError(),
            },
      smsChecker,
      4,
    );
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
