import 'package:corona_tracker/services/strings.dart';
import 'package:corona_tracker/ui/custom_color.dart';
import 'package:corona_tracker/ui/reuseable/responsive_size.dart';
import 'package:corona_tracker/utils/validator.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final FocusNode focusNode;
  final Function onSave;
  final String hint;
  final TextEditingController textEditingController;
  const PasswordField({this.focusNode, this.hint, this.textEditingController, this.onSave});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      onSaved: onSave?? (text) {},
      validator: (value) {
        return !Validator.isPassword(value)
            ? Strings.passInvalid['vi']
            : null;
      },
      focusNode: focusNode,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        isDense: true,
        hintText: hint??Strings.hintPassField['vi'],
        hintStyle: TextStyle(
          fontSize: ResponsiveSize.textMultiplier * 2,
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          Icons.vpn_key,
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
