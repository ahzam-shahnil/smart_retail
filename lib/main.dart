// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:smart_retail/Screens/login_screen/login_page.dart';
import 'package:smart_retail/Screens/splash_screen/splash_page.dart';
import 'package:smart_retail/constants.dart';
import 'Screens/admin_screen/admin_home_page.dart';
import 'Screens/register_screen/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SportsBuzz());
}

class SportsBuzz extends StatelessWidget {
  const SportsBuzz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kScaffoldBgColor,
      ),
      initialRoute: SplashPage.id,
      routes: {
        SplashPage.id: (context) => const SplashPage(),
        LoginPage.id: (context) => const LoginPage(),
        SignupPage.id: (context) => const SignupPage(),
        AdminHomePage.id: (context) => const AdminHomePage(),
      },
    );
  }
}
