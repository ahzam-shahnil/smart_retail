// import 'package:flutter/material.dart';

// class TextField extends StatelessWidget {
//   TextEditingController controller;
//   TextInputType textInputType;
//   String label;
//   IconData? icon;
//   Color? filledColor;
//   Color? textColor;
//   bool? fill;
//   String? hint;

//   TextField(
//       {required this.controller,
//       required this.textInputType,
//       required this.label,
//       this.icon,
//       this.filledColor,
//       this.textColor,
//       this.fill,
//       this.hint});

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
   
  
//       : InputDecoration(
//         border: const OutlineInputBorder(
//           borderRadius:  BorderRadius.all(
//              Radius.circular(20),
//           ),
//         ),
//         enabledBorder: const OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.white, width: 2),
//           borderRadius: BorderRadius.all(
//             Radius.circular(20),
//           ),
//         ),
//         labelText: label,
//         labelStyle: const TextStyle(color: Colors.white),
//         hintText: hint,
//         prefixIcon: Icon(
//           icon,
//           color: Colors.white,
//         ),
//         fillColor: filledColor,
//         filled: fill,
//       ), label: '', textInputType: null,
//     );
//   }
// }


// // TextField(
// //                 controller: _passwordController,
// //                 keyboardType: TextInputType.visiblePassword,
// //                 obscureText: true,
// //                 textAlign: TextAlign.center,
// //                 decoration: kTextFieldDecoration.copyWith(
// //                     icon: Icon(
// //                       Icons.password,
// //                       color: Colors.white,
// //                     ),
// //                     hintText: 'enter pass',
// //                     filled: true,
// //                     fillColor: Colors.white),
// //               ),