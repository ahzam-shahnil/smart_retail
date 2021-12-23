// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:smart_retail/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.5,
      height: size.height * 0.075,
      decoration: BoxDecoration(
        color: kBtnColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}
