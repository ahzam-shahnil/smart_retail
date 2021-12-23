// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:smart_retail/constants.dart';
import 'text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? textController;
  final TextInputType? textInputType;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.textController,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        controller: textController,
        keyboardType: textInputType,
        cursorColor: kActiveBtnColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kActiveBtnColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
