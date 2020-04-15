import 'package:corona_tracker/services/strings.dart';
import 'package:corona_tracker/ui/custom_color.dart';
import 'package:corona_tracker/ui/reuseable/responsive_size.dart';
import 'package:corona_tracker/utils/validator.dart';
import 'package:flutter/material.dart';

class PhoneField extends StatelessWidget {
  final FocusNode focusNode;
  final Function onSave;
  final TextEditingController _textEditingController = TextEditingController();
  PhoneField({this.focusNode, this.onSave});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSave?? (text) {},
      validator: (value) {
        return !Validator.isPhone(value) ? Strings.phoneInvalid['vi'] : null;
      },
      controller: _textEditingController,
      focusNode: focusNode,
      maxLength: 10,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        isDense: true,
        hintText: Strings.hintPhoneField['vi'],
        hintStyle: TextStyle(
          fontSize: ResponsiveSize.textMultiplier * 2,
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          Icons.phone,
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
