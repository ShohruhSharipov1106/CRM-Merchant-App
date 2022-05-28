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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: kHeight(20.0).h),
                  StepsField(context, 1),
                  SizedBox(height: kHeight(20.0).h),
                  TitleOfPage("create_zayavka", kWidth(126.0).w),
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
          )
        : const NoInternetPage();
  }

  Padding _button(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: _showLoader ? kWidth(160.0).w : kWidth(kButHorPad).w,
      ),
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

  Padding _titleField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kMainPadding),
      child: LocaleText(
        context.watch<AddProposalProvider>().isError
            ? "error_client_phone_number"
            : "client_phone_number",
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: context.watch<AddProposalProvider>().isError
                  ? kMainColor
                  : kBlackTextColor,
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
    );
  }

  Padding _titleAnimation(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: kWidth(100.0).w),
      child: Stack(
        children: [
          SizedBox(
            height: kHeight(175).h,
            width: kWidth(210.0).w,
            child: SvgPicture.asset(
              "assets/icons/main_icon.svg",
              height: kHeight(168.88).h,
              width: kWidth(194.0).w,
              color: context.watch<AddProposalProvider>().isError
                  ? kErrorAnimationColor
                  : kMainColor,
            ),
          ),
          Positioned(
            child: ElasticInRight(
              duration: const Duration(seconds: 5),
              child: SvgPicture.asset(
                context.watch<AddProposalProvider>().isError
                    ? "assets/icons/error-document.svg"
                    : "assets/icons/document.svg",
                height: kHeight(174.21).h,
                width: kWidth(156.0).w,
              ),
            ),
            left: -kWidth(3.0).w,
            bottom: -kHeight(4.0).h,
          ),
        ],
      ),
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
              context.read<AddProposalProvider>().hasnotError()
            })
        .onError((error, stackTrace) =>
            {context.read<AddProposalProvider>().hasError()})
        .whenComplete(() => {
              setState(() {
                _showLoader = false;
              })
            });
  }
}
