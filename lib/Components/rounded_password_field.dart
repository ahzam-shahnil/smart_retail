// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:smart_retail/constants.dart';
import 'text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? textController;

  const RoundedPasswordField({
    Key? key,
    this.onChanged,
    this.textController,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: _isObscure,
        onChanged: widget.onChanged,
        cursorColor: kActiveBtnColor,
        controller: widget.textController,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          hintText: "Password",
          icon: const Icon(
            Icons.lock,
            color: kActiveBtnColor,
          ),
          suffix: IconButton(
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
            icon: Icon(
              _isObscure ? Icons.visibility : Icons.visibility_off,
              color: kActiveBtnColor,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
