import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/profile/profile_menu_page.dart';
import 'package:crm_merchant/services/create_request_service.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../models/marketplace/get_my_tariffs_model.dart';

// ignore: must_be_immutable
class TariffConfirmationPage extends StatefulWidget {
  GetMyTariffsModel tarifDatas;

  TariffConfirmationPage(this.tarifDatas, {Key? key}) : super(key: key);

  @override
  State<TariffConfirmationPage> createState() => _TariffConfirmationPageState();
}

class _TariffConfirmationPageState extends State<TariffConfirmationPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ItemScrollController _itemScrollController = ItemScrollController();
  final TextEditingController _prepaymentController = TextEditingController();

  int _currentCount = 0;
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

  int scheduleMonth = DateTime.now().month;
  int scheduleDay = DateTime.now().day;
  int scheduleYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    print(scheduleMonth);
    print(scheduleDay);
    print(scheduleYear);
    context.read<AddProposalProvider>().prePaymentSum =
        context.read<AddProposalProvider>().prePaymentSum ??
            summValue * widget.tarifDatas.prepayPercent!;

    return _connectionStatus == ConnectivityResult.mobile ||
            _connectionStatus == ConnectivityResult.wifi ||
            _connectionStatus == ConnectivityResult.ethernet
        ? Scaffold(
            key: _scaffoldKey,
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: kHeight(20.0).h),
                    StepsField(context, 8),
                    SizedBox(height: kHeight(20.0).h),
                    TitleOfPage("confirmation", kWidth(150.0).w),
                    SizedBox(height: kHeight(50.0).h),
                    SizedBox(
                      height: kHeight(207.0).h,
                      child: Row(
                        children: [
                          Container(
                            height: kHeight(206.79).h,
                            width: kWidth(172.0).w,
                            margin: EdgeInsets.only(
                              left: kWidth(42.0).w,
                              right: kWidth(30.0).w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: kWhiteColor,
                              border: Border.all(
                                color: kBlackTextColor,
                                width: 1.0,
                              ),
                              image: const DecorationImage(
                                image: AssetImage(
                                  "assets/icons/camera.png",
                                ),
                              ),
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(fontSize: 18.0),
                              children: [
                                _informationTitle(context, "passportNumber"),
                                TextSpan(
                                    text:
                                        "${context.watch<AddProposalProvider>().serialNumberOfpassport.text.removeAllWhitespace}\n\n"),
                                _informationTitle(context, "birthday"),
                                TextSpan(
                                    text:
                                        "${context.watch<AddProposalProvider>().dateOfBirth.text.replaceAll('/', '.')}\n\n"),
                                _informationTitle(context, "first_prepayment"),
                                WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: kHeight(5.0).h,
                                    ),
                                    child: SizedBox(
                                      height: kHeight(35.0).h,
                                      width: kWidth(160.0).w,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: _prepaymentController,
                                        onSubmitted: (v) => context
                                            .read<AddProposalProvider>()
                                            .changePrePay(
                                              _prepaymentController,
                                              summValue *
                                                  widget.tarifDatas
                                                      .prepayPercent!,
                                              summValue,
                                            ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(fontSize: 18.0),
                                        decoration: InputDecoration(
                                          hintText: NumberFormat(
                                                  '###,###,###,###,###,###')
                                              .format(summValue == 0
                                                  ? 0
                                                  : (context
                                                      .read<
                                                          AddProposalProvider>()
                                                      .prePaymentSum))
                                              .replaceAll(",", " "),
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .headlineLarge!
                                              .copyWith(fontSize: 18.0),
                                          suffixIconConstraints: BoxConstraints(
                                            maxHeight: kHeight(50.0).h,
                                            maxWidth: kWidth(50.0).w,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 0, vertical: 0),
                                          border: InputBorder.none,
                                          isDense: true,
                                          suffixIcon: Material(
                                            elevation: 5.0,
                                            shape: const CircleBorder(),
                                            color: kYellowButtonColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: SvgPicture.asset(
                                                "assets/icons/pen-icon.svg",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: kHeight(20.0).h),
                    _graficPayment(context),
                    SizedBox(height: kHeight(47.0).h),
                    _showModalBottom(),
                  ],
                ),
              ),
            ),
          )
        : const NoInternetPage();
  }

  Padding _graficPayment(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 44),
      child: SizedBox(
        width: kWidth(340.0).w,
        child: Column(
          children: [
            _graficPaymentTitleBody(context),
            _graficPaymentMainBody(context),
          ],
        ),
      ),
    );
  }

  Container _graficPaymentTitleBody(BuildContext context) {
    return Container(
      height: kHeight(43.0).h,
      width: kWidth(340.0).w,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        color: kMainColor,
      ),
      child: Center(
        child: LocaleText(
          "grafic_payment",
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: kWhiteColor),
        ),
      ),
    );
  }

  Container _graficPaymentMainBody(BuildContext context) {
    return Container(
      width: kWidth(340.0).w,
      height: kHeight(225.0).h,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
        color: kWhiteColor,
      ),
      padding: EdgeInsets.only(
        top: kHeight(8.0).h,
      ),
      child: Column(
        children: [
          SizedBox(
            width: kWidth(340.0).w,
            height: kHeight(178.0).h,
            child: ScrollablePositionedList.builder(
              itemScrollController: _itemScrollController,
              itemBuilder: (_, __) => _paymentSchedule(
                  context,
                  __ + 1,
                  scheduleDay > 27
                      ? ((scheduleMonth == 1 ||
                                  scheduleMonth == 3 ||
                                  scheduleMonth == 5 ||
                                  scheduleMonth == 7 ||
                                  scheduleMonth == 8 ||
                                  scheduleMonth == 10 ||
                                  scheduleMonth == 12) &&
                              scheduleDay == 31)
                          ? 31
                          : ((scheduleDay == 30 || scheduleDay == 31) &&
                                  (scheduleMonth == 4 ||
                                      scheduleMonth == 6 ||
                                      scheduleMonth == 9 ||
                                      scheduleMonth == 11))
                              ? 30
                              : (scheduleMonth == 2 &&
                                      ((scheduleYear % 4 == 0 ||
                                              scheduleYear % 100 == 0) &&
                                          scheduleYear % 400 != 0) &&
                                      (scheduleDay == 30 ||
                                          scheduleDay == 31 ||
                                          scheduleDay == 29))
                                  ? 29
                                  : (scheduleMonth == 2 &&
                                          (scheduleDay == 30 ||
                                              scheduleDay == 31 ||
                                              scheduleDay == 29 ||
                                              scheduleDay == 28)
                                      ? 28
                                      : scheduleDay)
                      : scheduleDay),
              itemCount: widget.tarifDatas.monthsCount!,
              physics: _currentCount < widget.tarifDatas.monthsCount! - 5
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
            ),
          ),
          const SizedBox(height: 10.0),
          GestureDetector(
            child: Visibility(
              visible: widget.tarifDatas.monthsCount! > 6 ? true : false,
              child: Image.asset(
                _currentCount < widget.tarifDatas.monthsCount! - 5
                    ? "assets/icons/down.png"
                    : "assets/icons/up.png",
                width: kWidth(25.0).w,
                height: kHeight(25.0).h,
                fit: BoxFit.cover,
              ),
            ),
            onTap: () {
              setState(() {
                _currentCount < widget.tarifDatas.monthsCount! - 5
                    ? _currentCount += 1
                    : _currentCount = 0;
              });
              _itemScrollController.scrollTo(
                index: _currentCount == 0 ? 0 : _currentCount,
                duration: const Duration(milliseconds: 300),
              );
            },
          ),
        ],
      ),
    );
  }

  Padding _showModalBottom() {
    return Padding(
      padding: EdgeInsets.only(left: kWidth(kButHorPad).w),
      child: MainButton(
        context,
        "confirm",
        () {
          if (_prepaymentController.text.toString() == ' ' ||
              _prepaymentController.text.isEmpty) {
            _prepaymentController.text = NumberFormat('###,###,###,###,###,###')
                .format(summValue * widget.tarifDatas.markup!)
                .replaceAll(",", " ");
            _scaffoldKey.currentState!.showBottomSheet(
              (context) => Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kWidth(40.0).w,
                  vertical: kHeight(30.0).h,
                ),
                height: kHeight(382.0).h,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.0),
                  ),
                  color: kWhiteColor,
                ),
                child: Column(
                  children: [
                    LocaleText(
                      "success_proposal",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 24.0),
                    ),
                    SizedBox(height: kHeight(10.0).h),
                    LocaleText(
                      "send_sms_proposal",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: kHeight(20.0).h),
                    MainButton(
                      context,
                      "complete",
                      () {
                        CreateRequestService.postProductsToApi(context);
                        Get.offAll(const ProfileMenuPage());
                      },
                    ),
                  ],
                ),
              ),
            );
          } else if (int.parse(_prepaymentController.text.removeAllWhitespace) <
              (summValue * widget.tarifDatas.markup!) * 0.1) {
          } else {
            _scaffoldKey.currentState!.showBottomSheet(
              (context) => Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kWidth(40.0).w,
                  vertical: kHeight(30.0).h,
                ),
                height: kHeight(382.0).h,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.0),
                  ),
                  color: kWhiteColor,
                ),
                child: Column(
                  children: [
                    LocaleText(
                      "success_proposal",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 24.0),
                    ),
                    SizedBox(height: kHeight(10.0).h),
                    LocaleText(
                      "send_sms_proposal",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: kHeight(20.0).h),
                    MainButton(
                      context,
                      "complete",
                      () {
                        Get.offAll(const ProfileMenuPage());
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  SizedBox _paymentSchedule(
    BuildContext context,
    int month,
    int dayNumb,
  ) {
    if (scheduleMonth == 12) {
      scheduleMonth = 1;
      scheduleYear = scheduleYear + 1;
    } else {
      scheduleMonth = scheduleMonth + 1;
    }

    return SizedBox(
      height: kHeight(31.0).h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: kWidth(12.0).w),
          Text(
            month.toString(),
            style: TextStyle(
              color: kBlackTextColor.withOpacity(0.5),
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: kWidth(17.0).w),
          Text(
            "${dayNumb < 10 ? "0$dayNumb" : dayNumb}.${scheduleMonth - 1 < 10 ? (scheduleMonth == 1 ? "0$scheduleMonth" : "0${scheduleMonth - 1}") : (scheduleMonth == 12 ? scheduleMonth : scheduleMonth - 1)}.$scheduleYear",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SizedBox(width: kWidth(72.0).w),
          _prepaymentShow(context),
        ],
      ),
    );
  }

  Text _prepaymentShow(BuildContext context) {
    return Text(
      NumberFormat('###,###,###,###,###,###')
          .format(summValue == 0
              ? 0
              : ((summValue -
                      context.watch<AddProposalProvider>().prePaymentSum!) *
                  widget.tarifDatas.markup!))
          .replaceAll(",", " "),
      style: Theme.of(context).textTheme.labelMedium,
    );
  }

  TextSpan _informationTitle(BuildContext context, String title) {
    return TextSpan(
      text: Locales.string(context, title) + "\n",
      style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 10.0),
    );
  }
}
