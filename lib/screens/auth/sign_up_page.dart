import 'dart:async';
import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/home/home_page.dart';
import 'package:crm_merchant/screens/internet_check/no_internet_page.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    initConnectivity;

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
      debugPrint('Couldn\'t check connectivity status $e');
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
            body: ZoomIn(
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
                      padding: const EdgeInsets.only(left: kMainPadding),
                      child: LocaleText(
                        "enter_data",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    SizedBox(height: kHeight(10.5).h),
                    InputField(
                      context,
                      contexPro.nameController,
                      Locales.string(context, "enter_username"),
                      "Недопустимое имя",
                      TextInputType.name,
                      30,
                      "* * * * * * * * * * * * * * *",
                      "##############################",
                      {"#": RegExp(r'[A-Za-z]')},
                    ),
                    InputField(
                      context,
                      contexPro.phoneController,
                      Locales.string(context, "enter_password"),
                      "Неверный пароль",
                      TextInputType.visiblePassword,
                      50,
                      "* * * * * * * * * * * * * * *",
                      "***************",
                      {"*": RegExp(r'[a-zA-Z0-9\!\@\#\$\%\^\&\*\(\)\_\+]')},
                    ),
                    SizedBox(height: kHeight(100.0).h),
                    Padding(
                      padding: const EdgeInsets.only(left: kButHorPad),
                      child: ValueListenableBuilder<TextEditingValue>(
                        valueListenable:
                            context.watch<SignUpProvider>().nameController,
                        builder: (context, v, child) {
                          return ListenableButton(
                            context,
                            'continue',
                            () async {
                              print(context
                                  .read<SignUpProvider>()
                                  .nameController
                                  .text
                                  .length);
                              print(context
                                  .read<SignUpProvider>()
                                  .phoneController
                                  .text
                                  .length);
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
                                      await _postTokenfromApi(
                                        context
                                            .read<SignUpProvider>()
                                            .nameController
                                            .text,
                                        context
                                            .read<SignUpProvider>()
                                            .phoneController
                                            .text,
                                      ),
                                      username = context
                                          .read<SignUpProvider>()
                                          .nameController
                                          .text,
                                      password = context
                                          .read<SignUpProvider>()
                                          .phoneController
                                          .text,
                                      Get.to(const HomePage())
                                    }
                                  : () {};
                            },
                            context.watch<SignUpProvider>().phoneController,
                            v.text.length > 2 ? 6 : 300,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : const NoInternetPage();
  }

  Future<dynamic> _postTokenfromApi(String userName, String password) async {
    Uri url = Uri.parse('https://crm.creditexpress.uz:6262/api/account/token');
    var res = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
        "charset": "utf-8"
      },
      body: json.encode({"userName": userName, "password": password}),
    );

    if (res.statusCode == 200) {
      print("object 2");
      print(res.body);
      return res.body;
    } else {
      throw Exception('Xato bor: ${res.statusCode}');
    }
  }
}
