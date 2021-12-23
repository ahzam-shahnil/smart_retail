// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:animated_text_kit/animated_text_kit.dart';

// Project imports:
import 'package:smart_retail/constants.dart';
import '../login_screen/login_page.dart';

class SplashPage extends StatefulWidget {
  static String id = 'splash_page';

  const SplashPage({Key? key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBgColor,
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
            height: 200.0,
            width: 200.0,
            margin: const EdgeInsets.only(
              top: 150.0,
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: kBtnColor,
            ),
            child: const Center(
                child: Icon(
              Icons.shopping_cart_outlined,
              color: kActiveBtnColor,
              size: 150,
            )),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Center(
            child: DefaultTextStyle(
              style: const TextStyle(
                color: kActiveBtnColor,
                fontSize: 50,
                fontWeight: FontWeight.w900,
              ),
              child: AnimatedTextKit(
                animatedTexts: [TypewriterAnimatedText('Smart Retail')],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
