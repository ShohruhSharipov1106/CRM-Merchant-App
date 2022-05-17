import 'package:crm_merchant/constants/exports.dart';

class FullPersonalInformationPage extends StatelessWidget {
  const FullPersonalInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kHeight(20.0).h),
            Padding(
              padding: EdgeInsets.only(left: kWidth(kInpHorPad).w),
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
              padding: EdgeInsets.only(left: kWidth(kInpHorPad).w),
              child: LocaleText(
                "gender",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            _genderField(context),
            SizedBox(height: kHeight(16.0).h),
            Padding(
              padding: EdgeInsets.only(left: kWidth(kInpHorPad).w),
              child: LocaleText(
                "address_of_residence",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            _addressOfResidenceField(context),
            _dateOfGivenField(context),
            _validityField(context),
            Padding(
              padding: EdgeInsets.only(left: kWidth(75.0).w),
              child: MainButton(
                context,
                'continue',
                () {},
              ),
            ),
          ],
        ),
        physics: const BouncingScrollPhysics(),
      ),
    );
  }

  InputField _name(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().name,
      'name',
      '',
      TextInputType.name,
      30,
      "* * * * * * * * * * * * * * *",
      "* * * * * * * * * * * * * * *",
      {"*": RegExp(r'[A-Za-z]')},
    );
  }

  InputField _surname(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().surname,
      'surname',
      '',
      TextInputType.name,
      50,
      "* * * * * * * * * * * * * * *",
      "* * * * * * * * * * * * * * *",
      {"*": RegExp(r'[A-Za-z]')},
    );
  }

  InputField _dadname(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().dadname,
      'dadname',
      '',
      TextInputType.name,
      50,
      "* * * * * * * * * * * * * * *",
      "* * * * * * * * * * * * * * *",
      {"*": RegExp(r'[A-Za-z]')},
    );
  }

  CalendarInputField _birthday(BuildContext context) {
    return CalendarInputField(
      context,
      context.watch<AddProposalProvider>().birthday,
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
      context.watch<AddProposalProvider>().seriesNumber,
      'series_and_number',
      '',
      TextInputType.visiblePassword,
      17,
      "* * * * * * * * *",
      "# # * * * * * * *",
      {
        "#": RegExp(r'[A-Za-z]'),
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
      context.watch<AddProposalProvider>().dateOfGiven,
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
      context.watch<AddProposalProvider>().validity,
      'validity',
      '',
      "**  **  ****",
      'dd MM yyyy',
      DateTime.now(),
      DateTime(2100),
    );
  }
}
