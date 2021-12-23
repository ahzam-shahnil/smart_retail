// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:ndialog/ndialog.dart';

// Project imports:
import 'package:smart_retail/Components/rounded_input_field.dart';
import 'package:smart_retail/Components/rounded_password_field.dart';
import 'package:smart_retail/Screens/admin_screen/admin_home_page.dart';
import 'package:smart_retail/Screens/register_screen/signup_page.dart';
import 'package:smart_retail/Screens/retail_home.dart';
import 'package:smart_retail/Screens/user_home.dart';
import 'package:smart_retail/constants.dart';
import 'package:smart_retail/services/database.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late final Database _database = Database();
  // Logger log = Logger();
  int selected = 0;

  Widget radioButton(String text, int value) {
    return Material(
      color: (selected == value)
          ? const Color(0xFFFE725D)
          : const Color(0xFF30475E),
      borderRadius: BorderRadius.circular(25),
      elevation: 5,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            selected = value;
          });
        },
        minWidth: 30,
        height: 15,
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBgColor,
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Icon(
              Icons.shopping_cart_outlined,
              size: 150,
              color: kActiveBtnColor,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Smart Retail',
                style: TextStyle(
                  color: kActiveBtnColor,
                  fontSize: 45,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundedInputField(
              hintText: 'Enter your email',
              icon: Icons.email,
              textController: _emailController,
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 30.0,
            ),
            RoundedPasswordField(
              textController: _passwordController,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                radioButton('Admin', 0),
                const SizedBox(width: 15),
                radioButton('Retailer', 1),
                const SizedBox(width: 15),
                radioButton('Customer', 2),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: OutlinedButton(
                onPressed: () => _login(context),
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                    elevation: 5.0,
                    side: const BorderSide(
                      color: kActiveBtnColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    primary: kBtnColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignupPage.id);
                },
                child: const Text(
                  'Sign Up or Register',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                  elevation: 5.0,
                  side: const BorderSide(
                    color: kActiveBtnColor,
                  ),
                  // backgroundColor: kActiveBtnColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // shadowColor: kActiveBtnColor
                  // primary: const Color(0xFF00003B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _login(BuildContext context) async {
    //trim for white spaces khtm krne k lea :D
    var email = _emailController.text.trim();
    var password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      // show error toast
      Fluttertoast.showToast(
          msg: 'Please fill all fields', backgroundColor: kBtnColor);
      return;
    }

    // request to firebase auth
    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('Logging In'),
      message: const Text('Please wait'),
      dismissable: false,
      blur: 2,
    );

    progressDialog.show();

    try {
      // FirebaseAuth auth = FirebaseAuth.instance;
      //userdetails=usercredential
      UserCredential? userCredential =
          await _database.logInUser(email, password);
      // log.i(userCredential);
      if (userCredential == null) {
        progressDialog.dismiss();
        Fluttertoast.showToast(
            msg: 'User not found', backgroundColor: kBtnColor);
      }
      if (userCredential?.user != null) {
        final FirebaseFirestore _firestore = FirebaseFirestore.instance;
        final CollectionReference _mainCollection;

        //* Checking User to store Data
        if (selected == 0) {
          _mainCollection = _firestore.collection(kAdminData);
        } else if (selected == 1) {
          _mainCollection = _firestore.collection(kRetailerData);
        } else {
          _mainCollection = _firestore.collection(kUserData);
        }
        bool isUser = false;
        var collection = _mainCollection
            .where("uid", isEqualTo: userCredential?.user?.uid)
            .get();

        await collection.then((QuerySnapshot querySnapshot) => {
              // ignore: avoid_function_literals_in_foreach_calls
              querySnapshot.docs.forEach((doc) {
                if (doc["uid"] == (userCredential?.user?.uid)) {
                  setState(() {
                    isUser = true;
                  });
                  // return;
                }
              })
            });
        if (isUser) {
          progressDialog.dismiss();
          if (selected == 0) {
            Get.to(() => const AdminHomePage());
          } else if (selected == 1) {
            Get.to(() => const RetailHome());
          } else {
            Get.to(() => const UserHome());
          }
        } else {
          progressDialog.dismiss();
          Fluttertoast.showToast(
              msg: 'User not found', backgroundColor: kBtnColor);
        }
      }
    } on FirebaseAuthException catch (e) {
      progressDialog.dismiss();

      if (e.code == 'user-not-found') {
        progressDialog.dismiss();
        Fluttertoast.showToast(
            msg: 'User not found', backgroundColor: kBtnColor);
      } else if (e.code == 'wrong-password') {
        progressDialog.dismiss();
        Fluttertoast.showToast(
            msg: 'Wrong password', backgroundColor: kBtnColor);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong', backgroundColor: kBtnColor);
      debugPrint('e : $e');
      progressDialog.dismiss();
    }
  }
}
