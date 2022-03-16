import 'package:crm_merchant/constants/exports.dart';
import 'package:flutter/services.dart';

class InputField extends StatefulWidget {
  TextEditingController kontroller;
  String hintTitle;
  TextInputType keyboardingType;
  bool hasPrefix;
  String? Function(String?) validateFunc;

  int maxLen;
  InputField(
    this.kontroller,
    this.hintTitle,
    this.keyboardingType,
    this.validateFunc,
    this.maxLen, {
    this.hasPrefix = false,
    
    Key? key,
  }) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final FocusNode _focusNode = FocusNode();
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
        controller: widget.kontroller,
        keyboardType: widget.keyboardingType,
        validator: widget.validateFunc,
        textAlign: TextAlign.start,
        focusNode: _focusNode,
        enabled: true,
        maxLength: widget.maxLen,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        textAlignVertical: TextAlignVertical.top,
        style: Theme.of(context).textTheme.titleMedium,
        decoration: InputDecoration(
          labelText: widget.hintTitle,
          errorStyle: _focusNode.hasFocus
              ? null
              : const TextStyle(fontSize: 0.0, height: 0),
          labelStyle:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12.0),
          prefixIcon: Text(
            widget.hasPrefix ? "  + 998 " : "   ",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          counterText: "",
          prefixIconConstraints:
              BoxConstraints(minWidth: 0, minHeight: kHeight(0).h),
          isDense: false,
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
