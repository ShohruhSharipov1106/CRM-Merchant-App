import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/components/full_pers_info_components.dart/mini_components.dart/orientr_field.dart';

// ignore: must_be_immutable
class HomeNumberField extends StatefulWidget {
  BuildContext kontext;
  TextEditingController textEditingControllerHome;
  TextEditingController textEditingControllerApartment;
  String textFieldHome;
  String textFieldApartment;
  bool value;
  TextEditingController textEditingControllerOrientr;
  bool isTemporary;

  HomeNumberField(
      this.kontext,
      this.textEditingControllerHome,
      this.textFieldApartment,
      this.textFieldHome,
      this.textEditingControllerApartment,
      this.value,
      this.textEditingControllerOrientr,
      {this.isTemporary = false,
      Key? key})
      : super(key: key);

  @override
  State<HomeNumberField> createState() => _HomeNumberFieldState();
}

class _HomeNumberFieldState extends State<HomeNumberField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _inputHomeNumberCard(
          widget.kontext,
          widget.textEditingControllerHome,
          widget.textFieldHome,
        ),
        Row(
          children: [
            LocaleText(
              "is_apartment",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 14.0,
                    color: kBlackTextColor,
                  ),
            ),
            const Spacer(),
            Switch(
                value: widget.value,
                onChanged: (v) {
                  setState(() {
                    
                  });
                  widget.value = !widget.value;
                })
          ],
        ),
        Visibility(
          child: _inputHomeNumberCard(
            widget.kontext,
            widget.textEditingControllerApartment,
            widget.textFieldApartment,
          ),
          visible: widget.value,
        ),
        const SizedBox(height: 36.0),
        OrientrField(widget.textEditingControllerOrientr),
        const SizedBox(height: 21.0),
      ],
    );
  }

  SizedBox _inputHomeNumberCard(
    BuildContext context,
    TextEditingController textEditingController,
    String textField,
  ) {
    return SizedBox(
      height: kHeight(50.0).h,
      width: kWidth(120.0).w,
      child: TextField(
        controller: textEditingController,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: Colors.black.withOpacity(0.5),
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        textAlignVertical: TextAlignVertical.center,
        cursorColor: kBlackTextColor,
        textAlign: TextAlign.start,
        maxLength: 10,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: InputDecoration(
          counterText: "",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: kBlackTextColor.withOpacity(0.5),
              width: 1.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: kBlackTextColor.withOpacity(0.5),
              width: 1.0,
            ),
          ),
          contentPadding: EdgeInsets.only(
              left: kWidth(10.0).w,
              top: kHeight(10.0).h,
              bottom: kHeight(20.0).h),
          label: AutoSizeText(
            Locales.string(context, textField),
            maxLines: 1,
            style: const TextStyle(color: kBlackTextColor),
            minFontSize: 8.0,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
