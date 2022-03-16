import 'package:crm_merchant/constants/exports.dart';

class InputField extends StatelessWidget {
  TextEditingController kontroller;
  String hintTitle;
  TextInputType keyboardingType;
  bool hasPrefix;
  InputField(
    this.kontroller,
    this.hintTitle,
    this.keyboardingType, {
    this.hasPrefix = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kHeight(50.0).h,
      width: kWidth(368.0).w,
      margin: const EdgeInsets.symmetric(
        horizontal: kInpHorPad,
        vertical: kInpVerPad,
      ),
      child: TextFormField(
        controller: kontroller,
        keyboardType: keyboardingType,
        // edit
        validator: (v) {},
        textAlign: TextAlign.start,
        enabled: true,
        textAlignVertical: TextAlignVertical.top,
        style: Theme.of(context).textTheme.titleMedium,
        decoration: InputDecoration(
          labelText: hintTitle,
          labelStyle:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12.0),
          prefixIcon: Text(
            hasPrefix ? "  + 998 " : "   ",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          isDense: true,
          prefixStyle: Theme.of(context).textTheme.titleMedium,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: kBlackTextColor,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
