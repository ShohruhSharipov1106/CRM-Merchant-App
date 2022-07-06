import 'package:crm_merchant/components/custom_button.dart';
import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/components/full_pers_info_components.dart/mini_components.dart/address_now_field_container.dart';
import 'package:crm_merchant/screens/add_proposal/components/full_pers_info_components.dart/mini_components.dart/address_propiski_field_container.dart';
import 'package:crm_merchant/screens/add_proposal/components/full_pers_info_components.dart/mini_components.dart/address_propiski_field_positioned.dart';
import 'package:crm_merchant/screens/add_proposal/components/full_pers_info_components.dart/mini_components.dart/address_residence_radio.dart';
import 'package:crm_merchant/screens/add_proposal/components/full_pers_info_components.dart/mini_components.dart/alert_dialog_title.dart';
import 'package:crm_merchant/screens/add_proposal/components/full_pers_info_components.dart/mini_components.dart/home_number_field.dart';
import 'package:crm_merchant/screens/add_proposal/components/full_pers_info_components.dart/mini_components.dart/permanent_address_field.dart';
import 'package:crm_merchant/screens/add_proposal/components/full_pers_info_components.dart/mini_components.dart/temporary_address_field.dart';

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
        ? GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
                appBar: _appBar(context),
                body: SingleChildScrollView(
                    child: Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          const SizedBox(height: 20.0),
                          SizedBox(
                            width: 100.w,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: LocaleText(
                                "fill_in_the_details",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          _name(context),
                          _surname(context),
                          _dadname(context),
                          _birthday(context),
                          _seriesNumber(context),
                          _tin(context),
                          _pinfl(context),
                          SizedBox(
                            width: 100.w,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: LocaleText(
                                "gender",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ),
                          _genderField(context),
                          const SizedBox(height: 17),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Stack(children: [
                                GestureDetector(
                                    child:
                                        const AddressPropiskiFieldContainer(),
                                    onTap: () async {
                                      await showDialog<void>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: AlertDialogTitle(
                                                    "place_of_residence"),
                                                insetPadding: EdgeInsets.zero,
                                                content: StatefulBuilder(
                                                    builder: (BuildContext
                                                            context,
                                                        StateSetter setState) {
                                                  return SizedBox(
                                                      width: 75.w,
                                                      child: GestureDetector(
                                                        onTap: () =>
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus(),
                                                        child:
                                                            SingleChildScrollView(
                                                                physics:
                                                                    const BouncingScrollPhysics(),
                                                                child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      const PermanentAddressField(),
                                                                      HomeNumberField(
                                                                        context,
                                                                        context
                                                                            .read<AddProposalProvider>()
                                                                            .homeNumber,
                                                                        "apartment_number",
                                                                        "home_number",
                                                                        context
                                                                            .read<AddProposalProvider>()
                                                                            .apartmentNumber,
                                                                        context
                                                                            .read<AddProposalProvider>()
                                                                            .isApartment,
                                                                        context
                                                                            .read<AddProposalProvider>()
                                                                            .orientr,
                                                                      ),
                                                                      Row(
                                                                          children: [
                                                                            _alertDialogButton(
                                                                                "cancel",
                                                                                kUnselectedLangColor,
                                                                                kBlackTextColor,
                                                                                () {
                                                                              context.read<AddProposalProvider>().permanentAddressCountryId = '';

                                                                              context.read<AddProposalProvider>().permanentAddressRegionId = '';

                                                                              context.read<AddProposalProvider>().permanentAddressDistrictId = '';
                                                                              Navigator.pop(context, true);
                                                                            }),
                                                                            const Spacer(),
                                                                            _alertDialogButton(
                                                                                "save",
                                                                                kGreenButtonColor,
                                                                                kWhiteColor,
                                                                                () {
                                                                              context.read<AddProposalProvider>().permanentAddress = "${context.read<AddProposalProvider>().permanentAddressCountry ?? ""} ${context.read<AddProposalProvider>().permanentAddressRegion ?? ""} ${context.read<AddProposalProvider>().permanentAddressDistrict ?? ""} ${context.read<AddProposalProvider>().homeNumber.text} ${(context.read<AddProposalProvider>().isApartment ? " " + context.read<AddProposalProvider>().apartmentNumber.text : "")}";
                                                                              context.read<AddProposalProvider>().temporaryAddress = context.read<AddProposalProvider>().permanentAddress;
                                                                              Navigator.pop(context, true);
                                                                            })
                                                                          ])
                                                                    ])),
                                                      ));
                                                }),
                                                backgroundColor:
                                                    kBackgroundColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    side: const BorderSide(
                                                        color: kBlackTextColor,
                                                        width: 1.0)));
                                          });
                                    }),
                                AddressPropiskiFieldPositioned(
                                    "place_of_residence")
                              ])),
                          const SizedBox(height: 16),
                          SizedBox(
                              width: 100.w,
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: LocaleText("address_of_residence",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium))),
                          const AddressResidenceRadio(),
                          const SizedBox(height: 17),
                          Visibility(
                              visible: context
                                      .watch<AddProposalProvider>()
                                      .addressOfResidence ==
                                  context.watch<AddProposalProvider>().another,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Stack(children: [
                                    GestureDetector(
                                        child: const AddressNowFieldContainer(),
                                        onTap: () async {
                                          await showDialog<void>(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    insetPadding:
                                                        EdgeInsets.zero,
                                                    titleTextStyle: Theme.of(
                                                            context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(
                                                            fontSize: 18.0,
                                                            color:
                                                                kBlackTextColor),
                                                    title: AlertDialogTitle(
                                                        "address_of_residence"),
                                                    content: StatefulBuilder(
                                                        builder:
                                                            (BuildContext context,
                                                                StateSetter
                                                                    setState) {
                                                      return SizedBox(
                                                        width: 75.w,
                                                        child: GestureDetector(
                                                          onTap: () =>
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus(),
                                                          child:
                                                              SingleChildScrollView(
                                                                  physics:
                                                                      const BouncingScrollPhysics(),
                                                                  child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        const TemporaryAddressField(),
                                                                        HomeNumberField(
                                                                          context,
                                                                          context
                                                                              .read<AddProposalProvider>()
                                                                              .temporaryhomeNumber,
                                                                          "apartment_number",
                                                                          "home_number",
                                                                          context
                                                                              .read<AddProposalProvider>()
                                                                              .temporaryapartmentNumber,
                                                                          context
                                                                              .read<AddProposalProvider>()
                                                                              .temporaryisApartment,
                                                                          context
                                                                              .read<AddProposalProvider>()
                                                                              .temporaryorientr,
                                                                          isTemporary:
                                                                              true,
                                                                        ),
                                                                        Row(
                                                                            children: [
                                                                              _alertDialogButton(
                                                                                "cancel",
                                                                                kUnselectedLangColor,
                                                                                kBlackTextColor,
                                                                                () {
                                                                                  context.read<AddProposalProvider>().temporaryAddressCountryId = " ";

                                                                                  context.read<AddProposalProvider>().temporaryAddressRegionId = " ";

                                                                                  context.read<AddProposalProvider>().temporaryAddressDistrictId = " ";

                                                                                  Navigator.pop(context, true);
                                                                                },
                                                                              ),
                                                                              const Spacer(),
                                                                              _alertDialogButton("save", kGreenButtonColor, kWhiteColor, () {
                                                                                context.read<AddProposalProvider>().temporaryAddress = "${context.read<AddProposalProvider>().temporaryAddressCountry ?? ""} ${context.read<AddProposalProvider>().temporaryAddressRegion ?? ""} ${context.read<AddProposalProvider>().temporaryAddressDistrict ?? ""} ${context.read<AddProposalProvider>().temporaryhomeNumber.text} ${(context.read<AddProposalProvider>().temporaryisApartment ? " " + context.read<AddProposalProvider>().temporaryapartmentNumber.text : "")}";
                                                                                Navigator.pop(context, true);
                                                                              })
                                                                            ])
                                                                      ])),
                                                        ),
                                                      );
                                                    }),
                                                    backgroundColor:
                                                        kBackgroundColor,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        side: const BorderSide(
                                                            color:
                                                                kBlackTextColor,
                                                            width: 1.0)));
                                              });
                                        }),
                                    AddressPropiskiFieldPositioned(
                                        "address_of_residence")
                                  ]))),
                          _givenBy(context),
                          _givenDate(context),
                          _expiryDate(context),
                          const SizedBox(height: 16),
                          CustomButton(context, 'continue', () {
                            if (context
                                    .watch<AddProposalProvider>()
                                    .addressOfResidence !=
                                context.watch<AddProposalProvider>().another) {
                              context
                                      .read<AddProposalProvider>()
                                      .permanentAddress =
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddress;
                            }

                           checkValidate();
                            Get.to(const IdentificationPage());
                          },
                              context
                                  .read<AddProposalProvider>()
                                  .isAccessButton),
                          const SizedBox(height: 16)
                        ])),
                    physics: const BouncingScrollPhysics())))
        : const NoInternetPage();
  }

  ElevatedButton _alertDialogButton(
    String title,
    Color color,
    Color textColor,
    Function() function,
  ) {
    return ElevatedButton(
        child: LocaleText(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: textColor, fontSize: 12.0, fontWeight: FontWeight.w400),
        ),
        style: ElevatedButton.styleFrom(
            primary: color,
            fixedSize: Size(kWidth(121.0).w, kHeight(30.0).h),
            elevation: 4.0,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
        onPressed: function);
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

  InputField _name(BuildContext context) {
    context.read<AddProposalProvider>().name.addListener(checkValidate);
    return InputField(
        context,
        context.watch<AddProposalProvider>().name,
        'name',
        '',
        TextInputType.name,
        30,
        "* * * * * * * * * * * * * *",
        "******************************",
        {"*": RegExp(r'[A-Za-zЁёА-я]')});
  }

  InputField _surname(BuildContext context) {
    context.read<AddProposalProvider>().surname.addListener(checkValidate);
    return InputField(
        context,
        context.watch<AddProposalProvider>().surname,
        'surname',
        '',
        TextInputType.name,
        50,
        "* * * * * * * * * * * * * *",
        "**************************************************",
        {"*": RegExp(r'[A-Za-zЁёА-я]')});
  }

  InputField _dadname(BuildContext context) {
    context.read<AddProposalProvider>().dadname.addListener(checkValidate);
    return InputField(
      context,
      context.watch<AddProposalProvider>().dadname,
      'dadname',
      '',
      TextInputType.name,
      50,
      "* * * * * * * * * * * * * * * ",
      "**************************************************",
      {"*": RegExp(r'[A-Za-zЁёА-я]')},
    );
  }

  CalendarInputField _birthday(BuildContext context) {
    context.read<AddProposalProvider>().dateOfBirth.addListener(checkValidate);
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
    context
        .read<AddProposalProvider>()
        .serialNumberOfpassport
        .addListener(checkValidate);
    return InputField(
      context,
      context.watch<AddProposalProvider>().serialNumberOfpassport,
      'series_and_number',
      '',
      TextInputType.visiblePassword,
      9,
      "* * * * * * * * *",
      "##*******",
      {
        "#": RegExp(r'[A-ZЁёА-я]'),
        "*": RegExp(r'[0-9]'),
      },
    );
  }

  InputField _tin(BuildContext context) {
    context.read<AddProposalProvider>().tin.addListener(checkValidate);
    return InputField(
      context,
      context.watch<AddProposalProvider>().tin,
      'tin',
      '',
      TextInputType.number,
      9,
      "* * * * * * * * *",
      "*********",
      {"*": RegExp(r'[0-9]')},
    );
  }

  InputField _pinfl(BuildContext context) {
    context.read<AddProposalProvider>().pinfl.addListener(checkValidate);
    return InputField(
      context,
      context.watch<AddProposalProvider>().pinfl,
      'pinfl',
      '',
      TextInputType.number,
      14,
      "* * * * * * * * * * * * * *",
      "**************",
      {"*": RegExp(r'[0-9]')},
    );
  }

  Padding _genderField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: kWidth(8.0).w),
      child: SizedBox(
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
      ),
    );
  }

  CalendarInputField _givenDate(BuildContext context) {
    context.watch<AddProposalProvider>().givenDate.addListener(checkValidate);

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

  CalendarInputField _expiryDate(BuildContext context) {
    context.watch<AddProposalProvider>().expiryDate.addListener(checkValidate);

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

  InputField _givenBy(BuildContext context) {
    context.watch<AddProposalProvider>().givenBy.addListener(checkValidate);

    return InputField(
      context,
      context.watch<AddProposalProvider>().givenBy,
      'given_by',
      '',
      TextInputType.name,
      300,
      '* * * * * * * * * * * * * *',
      '******************************************************************************************',
      {"*": RegExp(r'[a-zA-Za-zЁёА-я0-9]+(?:\s[a-zA-Za-zЁёА-я0-9]+)*$')},
    );
  }

  void checkValidate() {
    if (context.read<AddProposalProvider>().name.text.isEmpty ||
        context.read<AddProposalProvider>().surname.text.isEmpty ||
        context.read<AddProposalProvider>().pinfl.text.isEmpty ||
        context.read<AddProposalProvider>().dadname.text.isEmpty ||
        context.read<AddProposalProvider>().gender.isEmpty ||
        context.read<AddProposalProvider>().dateOfBirth.text.isEmpty ||
        context.read<AddProposalProvider>().permanentAddress!.isEmpty ||
        context.read<AddProposalProvider>().temporaryAddress!.isEmpty ||
        context.read<AddProposalProvider>().givenBy.text.isEmpty ||
        context
            .read<AddProposalProvider>()
            .serialNumberOfpassport
            .text
            .isEmpty ||
        context.read<AddProposalProvider>().givenDate.text.isEmpty ||
        context.read<AddProposalProvider>().tin.text.isEmpty ||
        context.read<AddProposalProvider>().expiryDate.text.isEmpty) {
      context.read<AddProposalProvider>().updateIsAccessButton(false);
      return;
    }

    context.read<AddProposalProvider>().updateIsAccessButton(true);
  }
}
