// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:sixth_man_travia/widgets/text_widget.dart';

// class AddNewCardScreen extends StatelessWidget {
//   const AddNewCardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: const Color(0xFFF9F9F9), // full background color fix
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Icon(Icons.arrow_back, color: Color(0xFFF86624)),
//                 SizedBox(height: 2.h),
//                 Center(
//                   child: text_widget(
//                     "Add New Card",
//                     fontSize: 18.sp,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 SizedBox(height: 3.h),

//                 /// Card Preview
//                 Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           text_widget(
//                             "Card Holder’s Name",
//                             color: Colors.white,
//                             fontSize: 16.sp,
//                           ),
//                           Image.asset(
//                             'assets/images/apple.png', // You can change this to 'mastercard.png'
//                             width: 30,
//                             height: 30,
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 2.h),
//                       text_widget(
//                         "****  ****  ****  5037",
//                         color: Colors.white,
//                         fontSize: 17.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       SizedBox(height: 2.h),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           text_widget(
//                             "VALID THRU\n05/28",
//                             fontSize: 14.sp,
//                             color: Colors.white,
//                           ),
//                           text_widget(
//                             "Balance\n\$1149",
//                             fontSize: 14.sp,
//                             color: Colors.white,
//                             textAlign: TextAlign.right,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 4.h),

//                 /// Form Fields
//                 text_widget(
//                   "Card Name",
//                   fontWeight: FontWeight.bold,
//                   fontSize: 14.sp,
//                   color: Color.fromARGB(255, 24, 23, 23),
//                 ),
//                 SizedBox(height: 1.h),
//                 _inputField("Write Here"),

//                 SizedBox(height: 2.h),
//                 text_widget(
//                   "Card Number",
//                   fontWeight: FontWeight.bold,
//                   fontSize: 14.sp,
//                   color: Color.fromARGB(255, 24, 23, 23),
//                 ),
//                 SizedBox(height: 1.h),
//                 _inputField("Write Here"),

//                 SizedBox(height: 2.h),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           text_widget(
//                             "Expiry Date",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14.sp,
//                             color: Color.fromARGB(255, 24, 23, 23),
//                           ),
//                           SizedBox(height: 1.h),
//                           _inputField("Write Here"),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 4.w),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           text_widget(
//                             "CVV",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14.sp,
//                             color: Color.fromARGB(255, 24, 23, 23),
//                           ),
//                           SizedBox(height: 1.h),
//                           _inputField("Write Here"),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: 5.h),

//                 /// Save Card Button
//                 GestureDetector(
//                   onTap: () {
//                     // Save logic here
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     padding: EdgeInsets.symmetric(vertical: 1.6.h),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF86624),
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     alignment: Alignment.center,
//                     child: text_widget(
//                       "Save Card",
//                       color: Colors.white,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 2.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _inputField(String hint) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: TextField(
//         decoration: InputDecoration(hintText: hint, border: InputBorder.none),
//         style: TextStyle(fontSize: 14.sp),
//       ),
//     );
//   }
// }
