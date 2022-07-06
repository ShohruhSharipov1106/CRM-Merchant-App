import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/services/address_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:crm_merchant/models/marketplace/region_model.dart' as rg;

class TemporaryAddressField extends StatefulWidget {
  const TemporaryAddressField({Key? key}) : super(key: key);

  @override
  State<TemporaryAddressField> createState() => _TemporaryAddressFieldState();
}

class _TemporaryAddressFieldState extends State<TemporaryAddressField> {
  final TextEditingController _temporaryCountryController =
      TextEditingController();
  final TextEditingController _temporaryRegionController =
      TextEditingController();
  final TextEditingController _temporaryDistrictController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: _temporaryCountryController,
                cursorColor: kBlackTextColor.withOpacity(0.5),
                textAlignVertical: TextAlignVertical.center,
                cursorWidth: 1.0,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        left: 6.0, right: 9.0, bottom: 9.0, top: 9.0),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    label: LocaleText("region",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 12.0, color: kBlackTextColor)),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    isDense: true,
                    hintText: context.read<AddProposalProvider>().temporaryAddressCountry ??
                        " ",
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                    suffixIcon: SizedBox(
                        width: 60,
                        height: 30,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: const Icon(
                                  Icons.close_outlined,
                                  size: 18.0,
                                  color: kBlackTextColor,
                                ),
                                onTap: () {
                                  _temporaryCountryController.clear();
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddressCountryId = '';
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddressCountry = '';
                                  _temporaryRegionController.clear();
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddressRegionId = '';
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddressRegion = '';
                                  _temporaryDistrictController.clear();
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddressDistrictId = '';
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddressDistrict = '';
                                },
                              ),
                              const SizedBox(width: 16.0),
                              SvgPicture.asset(
                                "assets/icons/down_black.svg",
                              ),
                              const SizedBox(width: 8.0),
                            ])),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: kBlackTextColor.withOpacity(0.5),
                            width: 1.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: kBlackTextColor.withOpacity(0.5),
                            width: 1.0)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: kBlackTextColor.withOpacity(0.5),
                            width: 1.0))),
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                )),
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                borderRadius: BorderRadius.circular(5.0)),
            loadingBuilder: (context) => Center(child: CupertinoActivityIndicator(radius: kHeight(16.0).h)),
            noItemsFoundBuilder: (context) => LocaleText("no_item_found", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12.0, fontWeight: FontWeight.w400)),
            suggestionsCallback: (v) async {
              return await AddressRegionService.getRequest(null).then((value) =>
                  value.value!.where((element) => element.name!
                      .trim()
                      .toLowerCase()
                      .contains(_temporaryCountryController.text
                          .trim()
                          .toLowerCase())));
            },
            itemBuilder: (context, rg.Value suggestion) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                        title: Text(suggestion.name.toString(),
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400))),
                    const Divider(color: kDividerColor, height: 1.0)
                  ]);
            },
            onSuggestionSelected: (rg.Value suggestion) {
              _temporaryCountryController.text = suggestion.name.toString();
              context.read<AddProposalProvider>().temporaryAddressCountryId =
                  suggestion.id;
              context.read<AddProposalProvider>().temporaryAddressCountry =
                  suggestion.name;
            }),
        const SizedBox(height: 36.0),
        TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: _temporaryRegionController,
                cursorColor: kBlackTextColor.withOpacity(0.5),
                textAlignVertical: TextAlignVertical.center,
                cursorWidth: 1.0,
                decoration: InputDecoration(
                    hintText: context.read<AddProposalProvider>().temporaryAddressRegion ??
                        '',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                    contentPadding: const EdgeInsets.only(
                        left: 6.0, right: 9.0, bottom: 9.0, top: 9.0),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    label: LocaleText("city",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 12.0, color: kBlackTextColor)),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    isDense: true,
                    suffixIcon: SizedBox(
                        width: 60,
                        height: 30,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: const Icon(
                                  Icons.close_outlined,
                                  size: 18.0,
                                  color: kBlackTextColor,
                                ),
                                onTap: () {
                                  _temporaryCountryController.clear();
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddressCountryId = '';
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddressCountry = '';
                                  _temporaryRegionController.clear();
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddressRegionId = '';
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddressRegion = '';
                                  _temporaryDistrictController.clear();
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddressDistrictId = '';
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddressDistrict = '';
                                },
                              ),
                              const SizedBox(width: 16.0),
                              SvgPicture.asset(
                                "assets/icons/down_black.svg",
                              ),
                              const SizedBox(width: 8.0),
                            ])),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: kBlackTextColor.withOpacity(0.5),
                            width: 1.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: kBlackTextColor.withOpacity(0.5),
                            width: 1.0)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: kBlackTextColor.withOpacity(0.5),
                            width: 1.0))),
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                )),
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                borderRadius: BorderRadius.circular(5.0)),
            loadingBuilder: (context) => Center(child: CupertinoActivityIndicator(radius: kHeight(16.0).h)),
            noItemsFoundBuilder: (context) =>
                LocaleText("no_item_found", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12.0, fontWeight: FontWeight.w400)),
            suggestionsCallback: (v) async {
              return await AddressCityService.getRequest(context
                      .read<AddProposalProvider>()
                      .temporaryAddressCountryId)
                  .then((value) => value.value!.where(
                      (element) => element.name!.trim().toLowerCase().contains(
                            _temporaryRegionController.text
                                .trim()
                                .toLowerCase(),
                          )));
            },
            itemBuilder: (context, rg.Value suggestion) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                        title: Text(suggestion.name.toString(),
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400))),
                    const Divider(color: kDividerColor, height: 1.0)
                  ]);
            },
            onSuggestionSelected: (rg.Value suggestion) {
              _temporaryRegionController.text = suggestion.name.toString();
              context.read<AddProposalProvider>().temporaryAddressRegionId =
                  suggestion.id;
              context.read<AddProposalProvider>().temporaryAddressRegion =
                  suggestion.name;
            }),
        const SizedBox(height: 36.0),
        TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: _temporaryDistrictController,
                cursorColor: kBlackTextColor.withOpacity(0.5),
                textAlignVertical: TextAlignVertical.center,
                cursorWidth: 1.0,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                    hintText: context.read<AddProposalProvider>().temporaryAddressDistrict ??
                        '',
                    contentPadding: const EdgeInsets.only(
                        left: 6.0, right: 9.0, bottom: 9.0, top: 9.0),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    label: LocaleText("street",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 12.0, color: kBlackTextColor)),
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    isDense: true,
                    suffixIcon: SizedBox(
                        width: 60,
                        height: 30,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: const Icon(
                                  Icons.close_outlined,
                                  size: 18.0,
                                  color: kBlackTextColor,
                                ),
                                onTap: () {
                                  _temporaryCountryController.clear();
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddressCountryId = '';
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddressCountry = '';
                                  _temporaryRegionController.clear();
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddressRegionId = '';
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddressRegion = '';
                                  _temporaryDistrictController.clear();
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddressDistrictId = '';
                                  context
                                      .read<AddProposalProvider>()
                                      .temporaryAddressDistrict = '';
                                },
                              ),
                              const SizedBox(width: 16.0),
                              SvgPicture.asset(
                                "assets/icons/down_black.svg",
                              ),
                              const SizedBox(width: 8.0),
                            ])),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: kBlackTextColor.withOpacity(0.5),
                            width: 1.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: kBlackTextColor.withOpacity(0.5),
                            width: 1.0)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: kBlackTextColor.withOpacity(0.5),
                            width: 1.0))),
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                )),
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                borderRadius: BorderRadius.circular(5.0)),
            loadingBuilder: (context) => Center(child: CupertinoActivityIndicator(radius: kHeight(16.0).h)),
            noItemsFoundBuilder: (context) => LocaleText("no_item_found", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12.0, fontWeight: FontWeight.w400)),
            suggestionsCallback: (v) async {
              return await AddressStreetService.getRequest(context
                      .read<AddProposalProvider>()
                      .temporaryAddressRegionId)
                  .then((value) => value.value!.where(
                      (element) => element.name!.trim().toLowerCase().contains(
                            _temporaryDistrictController.text
                                .trim()
                                .toLowerCase(),
                          )));
            },
            itemBuilder: (context, rg.Value suggestion) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                        title: Text(suggestion.name.toString(),
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400))),
                    const Divider(color: kDividerColor, height: 1.0)
                  ]);
            },
            onSuggestionSelected: (rg.Value suggestion) {
              _temporaryDistrictController.text = suggestion.name.toString();
              context.read<AddProposalProvider>().temporaryAddressDistrict =
                  suggestion.name;
            }),
        const SizedBox(height: 36.0),
      ],
    );
  }
}
