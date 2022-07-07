import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/sms_confirmation_page.dart';

class AddProposalAnotherCardPage extends StatefulWidget {
  const AddProposalAnotherCardPage({Key? key}) : super(key: key);

  @override
  State<AddProposalAnotherCardPage> createState() =>
      _AddProposalAnotherCardPageState();
}

class _AddProposalAnotherCardPageState
    extends State<AddProposalAnotherCardPage> {
  late bool _showLoader = false;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint("Couldn't check connectivity status error: $e");
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == ConnectivityResult.mobile ||
            _connectionStatus == ConnectivityResult.wifi ||
            _connectionStatus == ConnectivityResult.ethernet
        ? Scaffold(
            resizeToAvoidBottomInset: false,
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
                    SizedBox(height: kHeight(20.0).h),
                    TitleOfPage(
                      "enter_your_details",
                    ),
                    SizedBox(height: kHeight(5.0).h),
                    _titleAnimation(context),
                    SizedBox(height: kHeight(20.0).h),
                    _subtitleField(),
                    SizedBox(height: kHeight(25.0).h),
                    _headlineText(context),
                    SizedBox(height: kHeight(15.0).h),
                    _cardNumber(context),
                    _cardExpirationDate(context),
                    SizedBox(height: kHeight(22.0).h),
                    _button(context),
                    SizedBox(height: kHeight(53.0).h),
                  ],
                ),
              ),
            ),
          )
        : const NoInternetPage();
  }

  Stack _titleAnimation(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: kHeight(122.06).h,
          width: kWidth(172.0).w,
          child: SvgPicture.asset(
            "assets/icons/main_icon.svg",
            height: kHeight(122.06).h,
            width: kWidth(131.12).w,
            color: context.read<HasErrorProvider>().cardError
                ? kErrorAnimationColor
                : kMainColor,
          ),
        ),
        Positioned(
          child: FlipInX(
            duration: const Duration(seconds: 5),
            child: SvgPicture.asset(
              context.read<HasErrorProvider>().cardError
                  ? "assets/icons/error-card.svg"
                  : "assets/icons/card.svg",
              height: kHeight(110.28).h,
              width: kWidth(110.29).w,
            ),
          ),
          left: 0,
          bottom: 0,
        ),
      ],
    );
  }

  InputField _cardExpirationDate(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().cardExpirationDate,
      "enter_card_exp_date",
      "error_card_exp_date",
      TextInputType.number,
      5,
      "**/**",
      "**/**",
      {"*": RegExp(r'[0-9]')},
      hasError: context.watch<HasErrorProvider>().cardError,
    );
  }

  InputField _cardNumber(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().cardNumber,
      "enter_card_number",
      "error_card_number",
      TextInputType.number,
      22,
      "****  ****  ****  **** ",
      "****  ****  ****  ****",
      {"*": RegExp(r'[0-9]')},
      hasError: context.watch<HasErrorProvider>().cardError,
    );
  }

  ValueListenableBuilder _button(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: context.read<AddProposalProvider>().cardNumber,
      builder: (context, v, child) {
        return ListenableButton(
          context,
          "send_code",
          () {
            if (context.read<AddProposalProvider>().cardNumber.text.length ==
                    22 &&
                context
                        .read<AddProposalProvider>()
                        .cardExpirationDate
                        .text
                        .length ==
                    5) {
              setState(() {
                _showLoader = true;
              });
              sendForConfirm().whenComplete(() => {
                    setState(() {
                      _showLoader = false;
                    }),
                  });
            } else {
              context.read<HasErrorProvider>().hasCardError();
            }
          },
          context.watch<AddProposalProvider>().cardExpirationDate,
          v.text.length == 22 ? 5 : 10,
          showLoader: _showLoader,
        );
      },
    );
  }

  SizedBox _headlineText(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: LocaleText(
          context.read<HasErrorProvider>().cardError
              ? "error_card_details"
              : "enter_card_details",
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: context.read<HasErrorProvider>().cardError
                    ? kMainColor
                    : kBlackTextColor,
              ),
        ),
      ),
    );
  }

  LocaleText _subtitleField() {
    return const LocaleText(
      "card_subtitle",
      style: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w400,
        color: kBlackTextColor,
      ),
    );
  }

  Future sendForConfirm() async {
    await CardService.sendSmsCard(
            context.read<AddProposalProvider>().cardNumber.text,
            context.read<AddProposalProvider>().cardExpirationDate.text)
        .then((value) => {
              value.number =
                  context.read<AddProposalProvider>().cardNumber.text,
              value.expire =
                  context.read<AddProposalProvider>().cardExpirationDate.text,
              Get.to(AddProposalSmsConfirmationPage(value)),
              context.read<HasErrorProvider>().hasNotError()
            })
        .onError((error, stackTrace) =>
            {context.read<HasErrorProvider>().hasCardError()});
  }
}
