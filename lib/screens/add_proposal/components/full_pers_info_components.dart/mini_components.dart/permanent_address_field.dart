import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/services/address_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:crm_merchant/models/marketplace/region_model.dart' as rg;

class PermanentAddressField extends StatefulWidget {
  const PermanentAddressField({Key? key}) : super(key: key);

  @override
  State<PermanentAddressField> createState() => _PermanentAddressFieldState();
}

class _PermanentAddressFieldState extends State<PermanentAddressField> {
  final TextEditingController _permanentCountryController =
      TextEditingController();
  final TextEditingController _permanentRegionController =
      TextEditingController();
  final TextEditingController _permanentDistrictController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: _permanentCountryController,
                cursorColor: kBlackTextColor.withOpacity(0.5),
                textAlignVertical: TextAlignVertical.center,
                cursorWidth: 1.0,
                decoration: InputDecoration(
                    hintText: context.read<AddProposalProvider>().permanentAddressCountry ??
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
                    label: LocaleText("region",
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
                                  _permanentCountryController.clear();
                                  context
                                      .read<AddProposalProvider>()
                                      .permanentAddressCountryId = '';
                                  context
                                      .read<AddProposalProvider>()
                                      .permanentAddressCountry = '';
                                  _permanentRegionController.clear();
                                  context
                                      .read<AddProposalProvider>()
                                      .permanentAddressRegionId = '';
                                  context
                                      .read<AddProposalProvider>()
                                      .permanentAddressRegion = '';
                                  _permanentDistrictController.clear();
                                  context
                                      .read<AddProposalProvider>()
                                      .permanentAddressDistrictId = '';
                                  context
                                      .read<AddProposalProvider>()
                                      .permanentAddressDistrict = '';
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
            loadingBuilder: (context) => const Center(child: CupertinoActivityIndicator()),
            noItemsFoundBuilder: (context) => LocaleText("no_item_found", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 12.0, fontWeight: FontWeight.w400)),
            suggestionsCallback: (v) async {
              return await AddressRegionService.getRequest(null).then((value) =>
                  value.value!.where((element) => element.name!
                      .trim()
                      .toLowerCase()
                      .contains(_permanentCountryController.text
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
              _permanentCountryController.text = suggestion.name.toString();
              context.read<AddProposalProvider>().permanentAddressCountryId =
                  suggestion.id;
              context.read<AddProposalProvider>().permanentAddressCountry =
                  suggestion.name;
            }),
        const SizedBox(height: 36.0),
        TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: _permanentRegionController,
                cursorColor: kBlackTextColor.withOpacity(0.5),
                textAlignVertical: TextAlignVertical.center,
                cursorWidth: 1.0,
                decoration: InputDecoration(
                    hintText: context.read<AddProposalProvider>().permanentAddressRegion ??
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
                                  _permanentCountryController.clear();
                                  context
                                      .read<AddProposalProvider>()
                                      .permanentAddressCountryId = '';
                                  context
                                      .read<AddProposalProvider>()
                                      .permanentAddressCountry = '';
                                  _permanentRegionController.clear();
                                  context
                                      .read<AddProposalProvider>()
                                      .permanentAddressRegionId = '';
                                  context
                                      .read<AddProposalProvider>()
                                      .permanentAddressRegion = '';
                                  _permanentDistrictController.clear();
                                  context
                                      .read<AddProposalProvider>()
                                      .permanentAddressDistrictId = '';
                                  context
                                      .read<AddProposalProvider>()
                                      .permanentAddressDistrict = '';
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
                      .permanentAddressCountryId)
                  .then((value) => value.value!.where(
                      (element) => element.name!.trim().toLowerCase().contains(
                            _permanentRegionController.text
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
              _permanentRegionController.text = suggestion.name.toString();
              context.read<AddProposalProvider>().permanentAddressRegionId =
                  suggestion.id;
              context.read<AddProposalProvider>().permanentAddressRegion =
                  suggestion.name;
            }),
        const SizedBox(height: 36.0),
        TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: _permanentDistrictController,
                cursorColor: kBlackTextColor.withOpacity(0.5),
                textAlignVertical: TextAlignVertical.center,
                cursorWidth: 1.0,
                decoration: InputDecoration(
                    hintText: context.read<AddProposalProvider>().permanentAddressDistrict ??
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
                                  _permanentCountryController.clear();
                                  context
                                      .read<AddProposalProvider>()
                                      .permanentAddressCountryId = '';
                                  context
                                      .read<AddProposalProvider>()
                                      .permanentAddressCountry = '';
                                  _permanentRegionController.clear();
                                  context
                                      .read<AddProposalProvider>()
                                      .permanentAddressRegionId = '';
                                  context
                                      .read<AddProposalProvider>()
                                      .permanentAddressRegion = '';
                                  _permanentDistrictController.clear();
                                  context
                                      .read<AddProposalProvider>()
                                      .permanentAddressDistrictId = '';
                                  context
                                      .read<AddProposalProvider>()
                                      .permanentAddressDistrict = '';
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
                      .permanentAddressRegionId)
                  .then((value) => value.value!.where(
                      (element) => element.name!.trim().toLowerCase().contains(
                            _permanentDistrictController.text
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
              _permanentDistrictController.text = suggestion.name.toString();
              context.read<AddProposalProvider>().permanentAddressDistrict =
                  suggestion.name;
            }),
        const SizedBox(height: 36.0),
      ],
    );
  }
}
