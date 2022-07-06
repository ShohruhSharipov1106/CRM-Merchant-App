import 'package:crm_merchant/models/marketplace/get_my_tariffs_model.dart';
import 'package:crm_merchant/screens/tariff/tariff_helper.dart';
import 'package:crm_merchant/services/tariff_service.dart';

import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/tariff/tariff_confirmation_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TariffMainPage extends StatefulWidget {
  const TariffMainPage({Key? key}) : super(key: key);

  @override
  State<TariffMainPage> createState() => _TariffMainPageState();
}

class _TariffMainPageState extends State<TariffMainPage> {
  int? _whichTariff;
  bool _oneTapped = false;

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
            body: SafeArea(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    StepsField(context, 7),
                    const SizedBox(height: 20),
                    TitleOfPage("select_tariff"),
                    const SizedBox(height: 20),
                    FutureBuilder(
                        future: GetTariffService.getMyTariffs(),
                        builder: (context,
                            AsyncSnapshot<List<GetMyTariffsModel>> snap) {
                          var data = snap.data;
                          return snap.hasData
                              ? Stack(
                                  children: [
                                    SizedBox(
                                      height: kHeight(720).h,
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (_, __) => GestureDetector(
                                          child: Stack(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  left: 40,
                                                  right: 40,
                                                  bottom: 23,
                                                  top: 6,
                                                ),
                                                padding: const EdgeInsets.only(
                                                  left: 25.0,
                                                  top: 10.0,
                                                  bottom: 19.0,
                                                  right: 23,
                                                ),
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: kBlackTextColor
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      blurRadius: 3,
                                                      offset:
                                                          const Offset(0, 3),
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  color: kWhiteColor,
                                                ),
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: Locales.string(
                                                                context,
                                                                "tariff") +
                                                            "  " +
                                                            data![__].name! +
                                                            " \n\n",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineLarge,
                                                      ),
                                                      const WidgetSpan(
                                                        child: SizedBox(
                                                            height: 21),
                                                      ),
                                                      TextSpan(
                                                        text: NumberFormat(
                                                                '###,###,###,###,###,###')
                                                            .format(summValue ==
                                                                    0
                                                                ? 0
                                                                : summValue *
                                                                    ((1 + data[__].markup!) /
                                                                        data[__]
                                                                            .monthsCount!))
                                                            .replaceAll(
                                                                ",", " "),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineLarge,
                                                      ),
                                                      sumInMonthText(context),
                                                      const WidgetSpan(
                                                        child: SizedBox(
                                                            height: 21),
                                                      ),
                                                      TextSpan(
                                                        text: Locales.string(
                                                                context,
                                                                "prepayment") +
                                                            "  " +
                                                            "${data[__].prepayPercent}%                   \n",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelMedium,
                                                      ),
                                                      withoutPrepaymentText(
                                                          context),
                                                    ],
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              _ribbon(__),
                                              _ribbonText(__, data, context),
                                            ],
                                          ),
                                          onTap: () {
                                            setState(() {
                                              _whichTariff = __;
                                              selectedTariffsModel = data[__];
                                              _oneTapped = true;
                                              tarifSelected(
                                                  selectedTariffsModel!);
                                            });
                                          },
                                        ),
                                        itemCount: data!.length,
                                      ),
                                    ),
                                    _buttonField(context, data),
                                  ],
                                )
                              : _loading();
                        }),
                  ],
                ),
              ),
            ),
          )
        : const NoInternetPage();
  }

  Positioned _buttonField(BuildContext context, List<GetMyTariffsModel> data) {
    return Positioned(
      child: Visibility(
        child: MainButton(
          context,
          "go_confirm",
          () {
            for (var element in itemList) {
              element.tariffId = data[_whichTariff!].id;
              element.prepay = ((element.price ?? 0) *
                      (data[_whichTariff!].prepayPercent ?? 0))
                  .toInt();
            }
            context.read<AddProposalProvider>().partnerId =
                data[_whichTariff!].partnerId;

            Get.to(
              TariffConfirmationPage(
                data[_whichTariff!],
              ),
            );
          },
        ),
        visible: _oneTapped,
      ),
      bottom: kHeight(30.0).h,
      left: kWidth(80.0).w,
    );
  }

  Column _loading() {
    return Column(
      children: [
        const SizedBox(height: 200),
        Center(child: CupertinoActivityIndicator(radius: kHeight(16.0).h)),
      ],
    );
  }

  Positioned _ribbonText(
      int __, List<GetMyTariffsModel> data, BuildContext context) {
    return Positioned(
      child: _whichTariff == __ || !_oneTapped
          ? SizedBox(
              width: kWidth(52.0).w,
              height: kHeight(91.0).h,
              child: Center(
                child: Text.rich(
                  TextSpan(
                    text: "${data[__].monthsCount}",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: kWhiteColor,
                        ),
                    children: [
                      TextSpan(
                        text: data[__].monthsCount! < 4
                            ? "\n" + Locales.string(context, "under_3_month")
                            : "\n" + Locales.string(context, "up_3_month"),
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: kWhiteColor,
                                  fontSize: 10.0,
                                ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : const Text(""),
      top: 0,
      right: 42.0,
    );
  }

  TextSpan withoutPrepaymentText(BuildContext context) {
    return TextSpan(
      text: Locales.string(context, "without_prepayment"),
      style: Theme.of(context).textTheme.labelMedium,
    );
  }

  TextSpan sumInMonthText(BuildContext context) {
    return TextSpan(
      text: "  " + Locales.string(context, "sum_in_month") + "\n\n",
      style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 13.0),
    );
  }

  Positioned _ribbon(int __) {
    return Positioned(
      child: _whichTariff == __ || !_oneTapped
          ? SvgPicture.asset(
              "assets/icons/opened-ribbon.svg",
              width: kWidth(52.0).w,
              height: kHeight(91.0).h,
              fit: BoxFit.cover,
            )
          : SvgPicture.asset(
              "assets/icons/closed-ribbon.svg",
              width: kWidth(52.0).w,
              height: kHeight(16.0).h,
              fit: BoxFit.cover,
            ),
      top: 0,
      right: 48.0,
    );
  }
}
