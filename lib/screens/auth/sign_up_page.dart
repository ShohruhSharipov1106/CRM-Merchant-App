import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/profile/profile_drawer_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late bool _showLoader = false;
  late String _userName = "";
  late String _password = "";
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
    SignUpProvider contexPro = context.watch<SignUpProvider>();
    return _connectionStatus == ConnectivityResult.mobile ||
            _connectionStatus == ConnectivityResult.wifi ||
            _connectionStatus == ConnectivityResult.ethernet
        ? Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ZoomIn(
                duration: const Duration(seconds: 1),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: kHeight(72.0).h),
                      Padding(
                        padding: EdgeInsets.only(left: kWidth(140.0).w),
                        child: Text(
                          Locales.string(context, "salom"),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      SizedBox(height: kHeight(80.0).h),
                      Padding(
                        padding: EdgeInsets.only(left: kWidth(kMainPadding).w),
                        child: LocaleText(
                          context.watch<AddProposalProvider>().isError
                              ? "error_enter_data"
                              : "enter_data",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  color: context
                                          .watch<AddProposalProvider>()
                                          .isError
                                      ? kMainColor
                                      : kBlackTextColor),
                        ),
                      ),
                      SizedBox(height: kHeight(10.5).h),
                      InputField(
                        context,
                        contexPro.nameController,
                        "enter_username",
                        "error_username",
                        TextInputType.name,
                        30,
                        "* * * * * * * * * * * * * * *",
                        "##############################",
                        {"#": RegExp(r'[A-Za-zЁёА-я]')},
                      ),
                      InputField(
                        context,
                        contexPro.phoneController,
                        "enter_password",
                        "error_password",
                        TextInputType.visiblePassword,
                        50,
                        "* * * * * * * * * * * * * * *",
                        "***************",
                        {
                          "*": RegExp(
                              r'[a-zA-ZЁёА-я0-9\?\!\@\#\$\%\^\&\*\(\)\_\+]')
                        },
                      ),
                      SizedBox(height: kHeight(80.0).h),
                      Padding(
                        padding: EdgeInsets.only(
                            left: _showLoader
                                ? kWidth(160.0).w
                                : kWidth(kButHorPad).w),
                        child: ValueListenableBuilder<TextEditingValue>(
                          valueListenable:
                              context.watch<SignUpProvider>().nameController,
                          builder: (context, v, child) {
                            return ListenableButton(
                              context,
                              'continue',
                              () async {
                                context
                                                .read<SignUpProvider>()
                                                .nameController
                                                .text
                                                .length >
                                            2 &&
                                        context
                                                .read<SignUpProvider>()
                                                .phoneController
                                                .text
                                                .length >=
                                            6
                                    ? {
                                        _userName = context
                                            .read<SignUpProvider>()
                                            .nameController
                                            .text
                                            .toString(),
                                        _password = context
                                            .read<SignUpProvider>()
                                            .phoneController
                                            .text,

                                        
                                        await signin(),

                                        
                                      }
                                    : () {};
                              },
                              context.watch<SignUpProvider>().phoneController,
                              v.text.length > 2 ? 6 : 300,
                              showLoader: _showLoader,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : const NoInternetPage();
  }

  Future<bool> signin() async {
    setState(() {
      _showLoader = true;
    });
    var result =
        await ApiData().getToken(username: _userName, passpord: _password);

    setState(() {
      _showLoader = false;
    });
    if (result.isSuccess) {
      await clientMainData.write("username", _userName);
      await clientMainData.write("password", _password);
      Get.off(const ProfileDrawerPage());
    } else {
      context.read<AddProposalProvider>().hasError();
    }
    return true;
  }
}
