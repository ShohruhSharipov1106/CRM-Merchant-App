import 'package:crm_merchant/constants/exports.dart';

// ignore: must_be_immutable
class InputField extends StatefulWidget {
  BuildContext kontext;
  TextEditingController kontroller;
  String labelTitle;
  String errorTitle;
  TextInputType keyboardingType;
  int maxLen;
  String hintTitle;
  String maskText;
  Map<String, RegExp> maskFilter;
  bool hasError;

  InputField(
    this.kontext,
    this.kontroller,
    this.labelTitle,
    this.errorTitle,
    this.keyboardingType,
    this.maxLen,
    this.hintTitle,
    this.maskText,
    this.maskFilter, {
    this.hasError = false,
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
      margin: const EdgeInsets.symmetric(
        horizontal: kInpHorPad,
        vertical: kInpVerPad,
      ),
      child: TextFormField(
        controller: widget.kontroller,
        keyboardType: widget.keyboardingType,
        textAlign: TextAlign.start,
        focusNode: _focusNode,
        maxLength: widget.maxLen,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        textAlignVertical: TextAlignVertical.top,
        inputFormatters: [
          MaskTextInputFormatter(
            mask: widget.maskText,
            filter: widget.maskFilter,
          )
        ],
        onTap: () {
          context.read<HasErrorProvider>().hasNotError();
        },
        onChanged: (v) {
          widget.hasError = false;
          widget.maxLen == widget.kontroller.text.length
              ? _focusNode.unfocus()
              : _focusNode.requestFocus();
        },
        cursorColor: kBlackTextColor,
        textCapitalization: TextCapitalization.sentences,
        style: Theme.of(context).textTheme.titleMedium,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: widget.hasError
              ? Locales.string(context, widget.errorTitle)
              : Locales.string(context, widget.labelTitle),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: kBlackTextColor,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: kBlackTextColor,
              width: 1.0,
            ),
          ),
          errorStyle: _focusNode.hasFocus
              ? null
              : const TextStyle(fontSize: 0.0, height: 0),
          labelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 12.0,
                color: widget.hasError ? kMainColor : kBlackTextColor,
              ),
          prefixIcon: Text(
            "   ",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          counterText: "",
          hintText: widget.hintTitle,
          hintStyle: TextStyle(
            color: kBlackTextColor.withOpacity(0.5),
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
          prefixIconConstraints:
              BoxConstraints(minWidth: 0, minHeight: kHeight(0).h),
          isDense: false,
          contentPadding: const EdgeInsets.only(top: 14),
          prefixStyle: Theme.of(context).textTheme.titleMedium,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: kBlackTextColor,
              width: 1.0,
            ),
          ),
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
