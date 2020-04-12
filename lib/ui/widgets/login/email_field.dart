import 'package:corona_tracker/services/strings.dart';
import 'package:corona_tracker/ui/custom_color.dart';
import 'package:corona_tracker/ui/reuseable/responsive_size.dart';
import 'package:corona_tracker/utils/validator.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final FocusNode focusNode;
  final Function onSave;
  const EmailField({this.focusNode, this.onSave});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSave ?? (text) {},
      validator: (value) {
        return !Validator.isEmail(value) ? Strings.emailInvalid['vi'] : null;
      },
      focusNode: focusNode,
      autofocus: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        isDense: true,
        hintText:Strings.hintEmailField['vi'],
        hintStyle: TextStyle(
          fontSize: ResponsiveSize.textMultiplier * 2,
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          Icons.email,
          color: CustomColor.primary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: CustomColor.primary,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
