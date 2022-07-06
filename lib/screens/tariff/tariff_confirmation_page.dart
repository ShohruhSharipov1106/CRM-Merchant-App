import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/core/static_datas.dart';
import 'package:crm_merchant/screens/profile/profile_drawer_page.dart';
import 'package:crm_merchant/screens/tariff/tariff_helper.dart';
import 'package:crm_merchant/services/create_request_service.dart';
import 'package:crm_merchant/services/upload_file_service.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../models/marketplace/create_req_card_model.dart';
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
  bool _showLoader = false;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _prepaymentController.text =
        (summValue * (selectedTariffsModel?.prepayPercent ?? 0)).toString();

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
    DateTime _graficDate = DateTime.now();

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
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: kHeight(20.0).h),
                      StepsField(context, 8),
                      SizedBox(height: kHeight(20.0).h),
                      TitleOfPage("confirmation"),
                      SizedBox(height: kHeight(50.0).h),
                      Row(
                        children: [
                          Container(
                            height: kHeight(206.79).h,
                            width: kWidth(172.0).w,
                            child: faceUint8List != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Image.memory(
                                      faceUint8List!,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : null,
                            margin: const EdgeInsets.only(
                              left: 40,
                              right: 25,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: kWhiteColor,
                              border: Border.all(
                                color: kWhiteColor,
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
                                        "${context.watch<AddProposalProvider>().serialNumberOfpassport.text.removeAllWhitespace.toUpperCase()}\n\n"),
                                _informationTitle(context, "birthday"),
                                TextSpan(
                                    text:
                                        "${context.watch<AddProposalProvider>().dateOfBirth.text.replaceAll('/', '.')}\n\n"),
                                WidgetSpan(
                                  child: SizedBox(
                                    height: kHeight(60.0).h,
                                    width: kWidth(160.0).w,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: _prepaymentController,
                                      onSubmitted: (v) {
                                        num _prepayed = num.parse(
                                            _prepaymentController.text);
                                        if (_prepayed >=
                                            summValue *
                                                (selectedTariffsModel
                                                        ?.prepayPercent ??
                                                    0)) {
                                          setState(() {
                                            calculateDaily(_prepayed);
                                          });
                                        }
                                      },
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                            fontSize: 18.0,
                                            color: num.parse(
                                                        _prepaymentController
                                                            .text) >=
                                                    summValue *
                                                        (selectedTariffsModel
                                                                ?.prepayPercent ??
                                                            0)
                                                ? kBlackTextColor
                                                : kMainColor,
                                          ),
                                      decoration: InputDecoration(
                                        label: AutoSizeText(
                                          Locales.string(
                                              context, "first_prepayment"),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(fontSize: 10.0),
                                        hintText: NumberFormat(
                                                '###,###,###,###,###,###')
                                            .format(summValue == 0
                                                ? 0
                                                : (context
                                                    .read<AddProposalProvider>()
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
                                        suffixIcon: Material(
                                          elevation: 5.0,
                                          shape: const CircleBorder(),
                                          color: kYellowButtonColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: SvgPicture.asset(
                                              "assets/icons/pen-icon.svg",
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
                      SizedBox(height: kHeight(20.0).h),
                      _graficPayment(context, _graficDate),
                      SizedBox(height: kHeight(47.0).h),
                      _showModalBottom(),
                    ],
                  ),
                ),
              ),
            ),
          )
        : const NoInternetPage();
  }

  SizedBox _graficPayment(BuildContext context, DateTime _graficDate) {
    return SizedBox(
      width: kWidth(340.0).w,
      child: Column(
        children: [
          _graficPaymentTitleBody(context),
          _graficPaymentMainBody(context, _graficDate),
        ],
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

  Container _graficPaymentMainBody(BuildContext context, DateTime _graficDate) {
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
              itemBuilder: (BuildContext _, int index) {
                DateTime currentDate = addMonths(_graficDate, index);
                DateTime nextDate = addMonths(_graficDate, index + 1);
                int days = (nextDate.difference(currentDate)).inDays;
                return _paymentSchedule(context, index + 1, nextDate, days);
              },
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

  MainButton _showModalBottom() {
    dynamic ownerId;
    return MainButton(
      context,
      "confirm",
      () {
        setState(() {
          _showLoader = true;
        });
        for (var i = 0; i < StaticData.cards.length; i++) {
          createReqCards.add(
            CreateReqCardModel(
              contractorId: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
              holderName: StaticData.cards[i].holderName,
              number: StaticData.cards[i].number,
              phone: StaticData.cards[i].phone,
              ps: StaticData.cards[i].holderName,
              token: StaticData.cards[i].cardToken,
              validity: DateTime(
                  2000 + int.parse(StaticData.cards[i].expire!.substring(3, 5)),
                  int.parse(StaticData.cards[i].expire!.substring(0, 2)),
                  1),
            ),
          );
        }

        setState(() {
          _showLoader = true;
        });
        var ctxRead = context.read<AddProposalProvider>();
        CreateRequestService.postDatasToApi(
          ctxRead.partnerId!,
          ctxRead.name.text,
          ctxRead.surname.text,
          ctxRead.dadname.text,
          ctxRead.gender,
          ctxRead.nationality!,
          ctxRead.pinfl.text,
          ctxRead.tin.text,
          ctxRead.passData!.substring(0, 2),
          ctxRead.passData!.substring(2),
          ctxRead.issuedDateDatetime,
          ctxRead.expiryDateDatetime,
          ctxRead.givenBy.text,
          ctxRead.birthDayDateTime,
          ctxRead.permanentAddress!,
          ctxRead.temporaryAddress!,
          ctxRead.addProposalPhoneNumber.text.removeAllWhitespace.substring(1),
        )
            .then(
              (value) => {
                ownerId = value,
                if (_prepaymentController.text.toString() != ' ' ||
                    _prepaymentController.text.isNotEmpty)
                  {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: kWidth(40.0).w,
                          vertical: kHeight(30.0).h,
                        ),
                        height: kHeight(382.0).h,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: kBlackTextColor.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 20,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          borderRadius: const BorderRadius.vertical(
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
                              faceUint8List != null
                                  ? () async {
                                      await UploadFileService.uploadFile(
                                              ownerId, 1, faceBase64!)
                                          .then((value) => {
                                                Get.to(
                                                    const ProfileDrawerPage()),
                                                setState(() {
                                                  _showLoader = false;
                                                })
                                              });
                                    }
                                  : () async {
                                      await UploadFileService.uploadFile(
                                          ownerId, 1, pasportBase64!);
                                      await UploadFileService.uploadFile(
                                          ownerId, 2, propiskiBase64!);
                                      await UploadFileService.uploadFile(
                                          ownerId, 3, selfieBase64!);
                                      Get.back();
                                      setState(() {
                                        _showLoader = false;
                                      });
                                    },
                              showLoader: _showLoader,
                            ),
                          ],
                        ),
                      ),
                      barrierColor: Colors.transparent,
                      isDismissible: false,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30.0),
                        ),
                      ),
                    )
                  }
              },
            )
            .onError((error, stackTrace) =>
                {context.read<AddProposalProvider>().hasError()})
            .whenComplete(() => setState(() {
                  _showLoader = false;
                }));
      },
      showLoader: _showLoader,
    );
  }

  SizedBox _paymentSchedule(
      BuildContext context, int index, DateTime date, int days) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    final String formatted = formatter.format(date);
    return SizedBox(
      height: kHeight(31.0).h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: kWidth(12.0).w),
          Text(
            index.toString(),
            style: TextStyle(
              color: kBlackTextColor.withOpacity(0.5),
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(flex: 1),
          Text(
            formatted,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const Spacer(flex: 3),
          _prepaymentShow(context, days),
          const Spacer(flex: 1),
        ],
      ),
    );
  }

  Text _prepaymentShow(BuildContext context, int days) {
    return Text(
      dailyAmount * days < 0
          ? "0"
          : NumberFormat('###,###,###,###,###,###')
              .format(dailyAmount * days)
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
