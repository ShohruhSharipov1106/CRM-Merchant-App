import 'package:crm_merchant/components/custom_button.dart';
import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/identification_page.dart';

// ignore: must_be_immutable
class FullPersonalInformationPage extends StatefulWidget {
  const FullPersonalInformationPage({Key? key}) : super(key: key);

  @override
  State<FullPersonalInformationPage> createState() =>
      _FullPersonalInformationPageState();
}

class _FullPersonalInformationPageState
    extends State<FullPersonalInformationPage> {
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
            appBar: _appBar(context),
            body: FutureBuilder(builder: (context, AsyncSnapshot snap) {
              return snap.hasData
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: kHeight(20.0).h),
                          Padding(
                            padding:
                                EdgeInsets.only(left: kWidth(kInpHorPad).w),
                            child: LocaleText(
                              "fill_in_the_details",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          SizedBox(height: kHeight(20.0).h),
                          _name(context),
                          _surname(context),
                          _dadname(context),
                          _birthday(context),
                          _seriesNumber(context),
                          _tin(context),
                          _pinfl(context),
                          Padding(
                            padding:
                                EdgeInsets.only(left: kWidth(kInpHorPad).w),
                            child: LocaleText(
                              "gender",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          _genderField(context),
                          Container(
                            height: kHeight(50.0).h,
                            width: kWidth(368.0).w,
                            padding: EdgeInsets.symmetric(
                                horizontal: kWidth(10.0).w),
                            margin: EdgeInsets.symmetric(
                              horizontal: kWidth(kInpHorPad).w,
                              vertical: kHeight(kInpVerPad).h,
                            ),
                            child: InkWell(
                              child: InputDecorator(
                                expands: true,
                                decoration: InputDecoration(
                                  labelText: Locales.string(
                                      context, 'place_of_residence'),
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontSize: 12.0,
                                        color: context
                                                .watch<AddProposalProvider>()
                                                .isError
                                            ? kMainColor
                                            : kBlackTextColor,
                                      ),
                                  hintText: "* * * * * * * * * * * * * * *",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: kBlackTextColor.withOpacity(0.5),
                                      ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                        width: 1.0,
                                        color:
                                            kBlackTextColor.withOpacity(0.5)),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "abshfaeslj",
                                      // filter: {"*": RegExp(r'[A-Za-zЁёА-я0-9]')},
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    SizedBox(
                                      height: kHeight(15.0).h,
                                      width: kWidth(30.0).w,
                                      child: SvgPicture.asset(
                                        "assets/icons/down_black.svg",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // labelStyle: Theme.of(context)
                            //     .textTheme
                            //     .titleMedium!
                            //     .copyWith(
                            //       fontSize: 12.0,
                            //       color:
                            //           context.watch<AddProposalProvider>().isError
                            //               ? kMainColor
                            //               : kBlackTextColor,
                            //     ),

                            // hintStyle:
                            //     Theme.of(context).textTheme.titleMedium!.copyWith(
                            //           color: kBlackTextColor.withOpacity(0.5),
                            //         ),
                            // prefixStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: kHeight(16.0).h),
                          Padding(
                            padding:
                                EdgeInsets.only(left: kWidth(kInpHorPad).w),
                            child: LocaleText(
                              "address_of_residence",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          _addressOfResidenceField(context),
                          _givenByField(context),
                          _dateOfGivenField(context),
                          _validityField(context),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: kWidth(75.0).w,
                                  bottom: kHeight(50.0).h),
                              child: MainButton(context, 'continue', () {
                                // context.read<AddProposalProvider>().getClientDatas();
                                Get.to(const IdentificationPage());
                              })
                              // CustomButton(context, 'continue', () {
                              //   context.read<AddProposalProvider>().getClientDatas();
                              //   Get.to(const IdentificationPage());
                              // }, context.watch<AddProposalProvider>().isAccessButton),
                              ),
                        ],
                      ),
                      physics: const BouncingScrollPhysics(),
                    )
                  : (snap.hasError
                      ? const InternetErrorPage()
                      : Center(
                          child: Lottie.asset(
                            "assets/images/lottie/loading_indicator.json",
                            height: kHeight(160.0).h,
                            width: kWidth(160.0).w,
                          ),
                        ));
            }),
          )
        : const NoInternetPage();
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: kBlackTextColor,
        ),
      ),
      title: LocaleText(
        "fill_in_passport_details",
        style: Theme.of(context).textTheme.headlineLarge,
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
    );
  }

  InputField _givenByField(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().givenBy,
      'given_by',
      '',
      TextInputType.name,
      300,
      '* * * * * * * * * * * * * * *',
      '* * * * * * * * * * * * * * *',
      {"*": RegExp(r'[A-Za-zЁёА-я0-9]')},
    );
  }

  InputField _name(BuildContext context) {
    // context.watch<AddProposalProvider>().name.addListener(checkValidate);
    return InputField(
        context,
        context.watch<AddProposalProvider>().name,
        'name',
        '',
        TextInputType.name,
        30,
        "* * * * * * * * * * * * * * *",
        "* * * * * * * * * * * * * * *",
        {"*": RegExp(r'[A-Za-zЁёА-я]')});
  }

  InputField _surname(BuildContext context) {
    // context.watch<AddProposalProvider>().surname.addListener(checkValidate);
    return InputField(
        context,
        context.watch<AddProposalProvider>().surname,
        'surname',
        '',
        TextInputType.name,
        50,
        "* * * * * * * * * * * * * * *",
        "* * * * * * * * * * * * * * *",
        {"*": RegExp(r'[A-Za-zЁёА-я]')});
  }

  InputField _dadname(BuildContext context) {
    // context.watch<AddProposalProvider>().dadname.addListener(checkValidate);
    return InputField(
      context,
      context.watch<AddProposalProvider>().dadname,
      'dadname',
      '',
      TextInputType.name,
      50,
      "* * * * * * * * * * * * * * *",
      "* * * * * * * * * * * * * * *",
      {"*": RegExp(r'[A-Za-zЁёА-я]')},
    );
  }

  CalendarInputField _birthday(BuildContext context) {
    return CalendarInputField(
      context,
      context.watch<AddProposalProvider>().dateOfBirth,
      'birthday',
      '',
      "**  **  ****",
      'dd MM yyyy',
      DateTime(1900),
      DateTime.now(),
    );
  }

  InputField _seriesNumber(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().serialNumberOfpassport,
      'series_and_number',
      '',
      TextInputType.visiblePassword,
      17,
      "* * * * * * * * *",
      "# # * * * * * * *",
      {
        "#": RegExp(r'[A-ZЁёА-я]'),
        "*": RegExp(r'[0-9]'),
      },
    );
  }

  InputField _tin(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().tin,
      'tin',
      '',
      TextInputType.number,
      30,
      "* * * * * * * * *",
      "* * * * * * * * *",
      {"*": RegExp(r'[0-9]')},
    );
  }

  InputField _pinfl(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().pinfl,
      'pinfl',
      '',
      TextInputType.number,
      27,
      "* * * * * * * * * * * * * *",
      "* * * * * * * * * * * * * *",
      {"*": RegExp(r'[0-9]')},
    );
  }

  SizedBox _genderField(BuildContext context) {
    return SizedBox(
      height: kHeight(50.0).h,
      width: kWidth(368.0).w,
      child: Row(
        children: [
          SizedBox(
            height: kHeight(50.0).h,
            width: kWidth(368.0 / 2).w,
            child: RadioListTile(
              activeColor: kBlackTextColor,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              value: context.watch<AddProposalProvider>().male,
              title: LocaleText(
                "male",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontSize: 12.0),
              ),
              groupValue: context.watch<AddProposalProvider>().gender,
              onChanged: (v) =>
                  context.read<AddProposalProvider>().changeGender(),
            ),
          ),
          SizedBox(
            height: kHeight(50.0).h,
            width: kWidth(368.0 / 2).w,
            child: RadioListTile(
              activeColor: kBlackTextColor,
              value: context.watch<AddProposalProvider>().female,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              title: LocaleText(
                "female",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontSize: 12.0),
              ),
              groupValue: context.watch<AddProposalProvider>().gender,
              onChanged: (v) =>
                  context.read<AddProposalProvider>().changeGender(),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _addressOfResidenceField(BuildContext context) {
    return SizedBox(
      height: kHeight(50.0).h,
      width: kWidth(368.0).w,
      child: Row(
        children: [
          SizedBox(
            height: kHeight(50.0).h,
            width: kWidth(368.0 / 2).w,
            child: RadioListTile(
              activeColor: kBlackTextColor,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              value: context.watch<AddProposalProvider>().another,
              title: LocaleText(
                "another",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontSize: 12.0),
              ),
              groupValue:
                  context.watch<AddProposalProvider>().addressOfResidence,
              onChanged: (v) =>
                  context.read<AddProposalProvider>().changeAddress(),
            ),
          ),
          SizedBox(
            height: kHeight(50.0).h,
            width: kWidth(368.0 / 2).w,
            child: RadioListTile(
              activeColor: kBlackTextColor,
              value: context.watch<AddProposalProvider>().placeOfResidencevalue,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              title: LocaleText(
                "place_of_residence",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontSize: 12.0),
              ),
              groupValue:
                  context.watch<AddProposalProvider>().addressOfResidence,
              onChanged: (v) =>
                  context.read<AddProposalProvider>().changeAddress(),
            ),
          ),
        ],
      ),
    );
  }

  CalendarInputField _dateOfGivenField(BuildContext context) {
    return CalendarInputField(
      context,
      context.watch<AddProposalProvider>().givenDate,
      'date_of_given',
      '',
      "**  **  ****",
      'dd MM yyyy',
      DateTime(1900),
      DateTime.now(),
    );
  }

  CalendarInputField _validityField(BuildContext context) {
    return CalendarInputField(
      context,
      context.watch<AddProposalProvider>().expiryDate,
      'validity',
      '',
      "**  **  ****",
      'dd MM yyyy',
      DateTime.now(),
      DateTime(2100),
    );
  }

  // void checkValidate() {
  //   if (context.read<AddProposalProvider>().name.text.length < 2 ||
  //       context.read<AddProposalProvider>().surname.text.length < 6) {
  //     context.read<AddProposalProvider>().updateIsAccessButton(false);
  //     return;
  //   }

  //   context.read<AddProposalProvider>().updateIsAccessButton(true);
  // }
}
