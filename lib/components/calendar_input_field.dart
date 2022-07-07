import 'package:crm_merchant/constants/exports.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CalendarInputField extends StatefulWidget {
  BuildContext kontext;
  TextEditingController kontroller;
  String labelTitle;
  String errorTitle;
  String maskText;
  String dateFormat;
  DateTime minDate;
  DateTime maxDate;
  bool hasError;
  CalendarInputField(
    this.kontext,
    this.kontroller,
    this.labelTitle,
    this.errorTitle,
    this.maskText,
    this.dateFormat,
    this.minDate,
    this.maxDate, {
    this.hasError = false,
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CalendarInputField> {
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
      child: GestureDetector(
        child: TextFormField(
          controller: widget.kontroller,
          keyboardType: TextInputType.datetime,
          textAlign: TextAlign.start,
          focusNode: _focusNode,
          enabled: false,
          maxLength: 12,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          textAlignVertical: TextAlignVertical.top,
          inputFormatters: [
            MaskTextInputFormatter(
              mask: widget.maskText,
              filter: {"*": RegExp(r'[0-9]')},
            )
          ],
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
            hintText: widget.maskText,
            hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: kBlackTextColor.withOpacity(0.5),
                ),
            prefixIconConstraints:
                BoxConstraints(minWidth: 0, minHeight: kHeight(0).h),
            isDense: false,
            contentPadding: EdgeInsets.only(
              top: kHeight(15.0).h,
            ),
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
            suffixIcon: Padding(
              padding: EdgeInsets.only(
                right: kWidth(10.0).w,
              ),
              child: SvgPicture.asset(
                "assets/icons/calendar.svg",
              ),
            ),
            suffixIconConstraints: BoxConstraints(
              maxHeight: kHeight(25.0).h,
              maxWidth: kWidth(40.0).w,
            ),
          ),
        ),
        onTap: () {
          DatePicker.showDatePicker(
            context,
            minDateTime: widget.minDate,
            pickerTheme: const DateTimePickerTheme(
              confirm: LocaleText("ready"),
              cancel: LocaleText("cancel"),
            ),
            maxDateTime: widget.maxDate,
            dateFormat: widget.dateFormat,
            initialDateTime: DateTime(2020, 6, 15),
            onConfirm: (v, i) {
              String formats = DateFormat(widget.dateFormat).format(
                DateTime(v.year, v.month, v.day),
              );
              widget.kontroller.text = formats;
            },
          );
        },
      ),
    );
  }
}
