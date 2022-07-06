// ignore_for_file: must_be_immutable

import 'package:crm_merchant/constants/exports.dart';

class OrientrField extends StatelessWidget {
  TextEditingController textEditingController;
  OrientrField(this.textEditingController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          controller: textEditingController,
          maxLines: 6,
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.newline,
          cursorColor: kBlackTextColor,
          textCapitalization: TextCapitalization.sentences,
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 12.0,
            ),
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
            label: LocaleText(
              "orientr",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 12.0,
                    color: kBlackTextColor,
                  ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
        Positioned(
          bottom: 3,
          right: 4,
          child: SvgPicture.asset(
            "assets/icons/underline.svg",
            height: 15.0,
            width: 15.0,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
