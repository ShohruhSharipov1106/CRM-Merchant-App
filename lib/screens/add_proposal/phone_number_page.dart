import 'dart:math';
import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/home/offer_confirmation_page.dart';

class AddProposalPhoneNumberPage extends StatefulWidget {
  const AddProposalPhoneNumberPage({Key? key}) : super(key: key);

  @override
  State<AddProposalPhoneNumberPage> createState() =>
      _AddProposalPhoneNumberPageState();
}

class _AddProposalPhoneNumberPageState
    extends State<AddProposalPhoneNumberPage> {
  late bool _showLoader = false;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  int _checkSMS = 0;

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
            body: SafeArea(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: kHeight(20.0).h),
                    StepsField(context, 1,
                        hasError: context.read<HasErrorProvider>().phoneError),
                    SizedBox(height: kHeight(20.0).h),
                    TitleOfPage("create_zayavka"),
                    SizedBox(height: kHeight(25.0).h),
                    _titleAnimation(context),
                    SizedBox(height: kHeight(50.0).h),
                    _titleField(context),
                    SizedBox(height: kHeight(15.0).h),
                    _inputField(context),
                    SizedBox(height: kHeight(52.0).h),
                    _button(context),
                    SizedBox(height: kHeight(53.0).h),
                  ],
                ),
              ),
            ),
          )
        : const NoInternetPage();
  }

  Hero _button(BuildContext context) {
    return Hero(
      tag: "home_button",
      child: ListenableButton(
        context,
        'continue',
        () async {
          if (context
                  .read<AddProposalProvider>()
                  .addProposalPhoneNumber
                  .text
                  .length ==
              17) {
            setState(() {
              _showLoader = true;
            });
            _sendSmsToPhone();
          }
        },
        context.watch<AddProposalProvider>().addProposalPhoneNumber,
        17,
        showLoader: _showLoader,
      ),
    );
  }

  SizedBox _titleField(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: LocaleText(
          context.read<HasErrorProvider>().phoneError
              ? "error_client_phone_number"
              : "client_phone_number",
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: context.read<HasErrorProvider>().phoneError
                    ? kMainColor
                    : kBlackTextColor,
              ),
        ),
      ),
    );
  }

  InputField _inputField(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().addProposalPhoneNumber,
      "client_phone_number",
      "error_client_phone_number",
      TextInputType.number,
      17,
      "+ 998** *** ** ** ",
      "+ 998## ### ## ##",
      {"#": RegExp(r'[0-9]')},
      hasError: context.watch<HasErrorProvider>().phoneError,
    );
  }

  Stack _titleAnimation(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: kHeight(183.63).h,
          width: kWidth(229.3).w,
          child: SvgPicture.asset(
            !context.read<HasErrorProvider>().phoneError
                ? "assets/icons/phone_page_main_icon.svg"
                : "assets/icons/phone_page_main_icon_error.svg",
          ),
        ),
      ],
    );
  }

  Future _sendSmsToPhone() async {
    _checkSMS = Random().nextInt(8999) + 1000;
    await SendSMSService.sendSmsToClient(
      context
          .read<AddProposalProvider>()
          .addProposalPhoneNumber
          .text
          .removeAllWhitespace
          .substring(1),
      _checkSMS.toString(),
    )
        .then((value) => {
              Get.to(OfferConfirmationPage(_checkSMS)),
              context.read<HasErrorProvider>().hasNotError()
            })
        .onError((error, stackTrace) =>
            {context.read<HasErrorProvider>().hasPhoneError()})
        .whenComplete(() => {
              setState(() {
                _showLoader = false;
              })
            });
  }
}
