// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:sixth_man_travia/new_screens/profile_upated/Subscription/AddNewCardScreen.dart';
// import 'package:sixth_man_travia/widgets/text_widget.dart';

// class CheckoutScreen extends StatefulWidget {
//   const CheckoutScreen({super.key});

//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   int selectedPaymentIndex = 0;

//   final List<String> paymentIcons = [
//     'assets/images/apple.png',
//     'assets/images/apple.png',
//     'assets/images/Group 495.png',
//   ];

//   final List<Map<String, dynamic>> savedCards = [
//     {
//       "cardNumber": "**** **** **** 5037",
//       "holder": "Card Holder’s Name",
//       "valid": "05/28",
//       "balance": "\$1149",
//       "isDark": true,
//     },
//     {
//       "cardNumber": "**** **** **** 2079",
//       "holder": "Card Holder’s Name",
//       "valid": "05/28",
//       "balance": "\$680",
//       "isDark": false,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Icon(Icons.arrow_back, color: Color(0xFFF86624)),

//               Center(
//                 child: text_widget(
//                   "Checkout",
//                   fontSize: 19.sp,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(height: 3.h),

//               /// Payment Method Title
//               text_widget(
//                 "Select Payment Method",
//                 fontWeight: FontWeight.w500,
//                 fontSize: 16.sp,
//                 color: Colors.black,
//               ),
//               SizedBox(height: 1.5.h),

//               /// Payment Method Toggle Row
//               Row(
//                 children: List.generate(paymentIcons.length, (index) {
//                   final bool isSelected = index == selectedPaymentIndex;
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedPaymentIndex = index;
//                       });
//                     },
//                     child: Padding(
//                       padding: EdgeInsets.only(right: 3.w),
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 200),
//                         width: 26.w,
//                         height: 8.h,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(
//                             color: isSelected
//                                 ? const Color(0xFFF86624)
//                                 : Colors.transparent,
//                             width: 1.5,
//                           ),
//                         ),
//                         child: Center(
//                           child: Image.asset(
//                             paymentIcons[index],
//                             width: 24,
//                             height: 24,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//               ),

//               SizedBox(height: 3.h),

//               /// Saved Cards
//               text_widget(
//                 "Save Card",
//                 fontWeight: FontWeight.w500,
//                 fontSize: 16.sp,
//                 color: Color.fromARGB(255, 30, 30, 30),
//               ),
//               SizedBox(height: 0.5.h),
//               text_widget(
//                 "You Have a 2Credit Card",
//                 fontSize: 15.sp,
//                 color: Color.fromARGB(255, 131, 131, 131),
//               ),
//               SizedBox(height: 2.h),

//               /// Cards Scroll View
//               SizedBox(
//                 height: 18.h,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: savedCards.length,
//                   itemBuilder: (context, index) {
//                     final card = savedCards[index];
//                     final bool isDark = card['isDark'];

//                     return Container(
//                       width: 70.w,
//                       margin: EdgeInsets.only(right: 4.w),
//                       padding: EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: isDark ? Colors.black : Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                           color: isDark
//                               ? Colors.transparent
//                               : const Color(0xFFE0E0E0),
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           text_widget(
//                             card['holder'],
//                             color: isDark ? Colors.white : Colors.black,
//                             fontSize: 16.sp,
//                           ),
//                           SizedBox(height: 1.h),
//                           text_widget(
//                             card['cardNumber'],
//                             color: isDark ? Colors.white : Colors.black,
//                             fontSize: 17.sp,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           SizedBox(height: 1.5.h),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               text_widget(
//                                 "VALID THRU\n${card['valid']}",
//                                 fontSize: 14.sp,
//                                 color: isDark ? Colors.white : Colors.black,
//                               ),
//                               text_widget(
//                                 "Balance\n${card['balance']}",
//                                 fontSize: 14.sp,
//                                 color: isDark ? Colors.white : Colors.black,
//                                 textAlign: TextAlign.right,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 2.h),

//               /// Add New Card
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const AddNewCardScreen()),
//                   );
//                 },
//                 child: text_widget(
//                   "+ Add New Card",
//                   color: const Color(0xFFF86624),
//                   fontSize: 15.sp,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),

//               SizedBox(height: 4.h),

//               /// Pay Summary
//               text_widget(
//                 "Pay Now",
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16.sp,
//                 color: Color.fromARGB(255, 30, 30, 30),
//               ),
//               SizedBox(height: 1.5.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   text_widget(
//                     "Sub Total",
//                     color: Color.fromARGB(255, 24, 23, 23),
//                     fontSize: 15.sp,
//                   ),
//                   text_widget(
//                     "\$27.00",
//                     color: Color.fromARGB(255, 24, 23, 23),
//                     fontSize: 15.sp,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 0.8.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   text_widget(
//                     "Discount",
//                     color: Color.fromARGB(255, 24, 23, 23),
//                     fontSize: 15.sp,
//                   ),
//                   text_widget(
//                     "\$3.00",
//                     color: Color.fromARGB(255, 24, 23, 23),
//                     fontSize: 15.sp,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 1.5.h),
//               Divider(color: Colors.grey.shade300),
//               SizedBox(height: 1.5.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   text_widget(
//                     "Total",
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16.sp,
//                     color: Color.fromARGB(255, 30, 30, 30),
//                   ),
//                   text_widget(
//                     "\$24.00",
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16.sp,
//                     color: Color.fromARGB(255, 30, 30, 30),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 4.h),

//               /// Pay Now Button
//               GestureDetector(
//                 onTap: () {
//                   showPaymentSuccessDialog(context);
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.symmetric(vertical: 1.8.h),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF86624),
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   alignment: Alignment.center,
//                   child: text_widget(
//                     "Pay Now",
//                     color: Colors.white,
//                     fontSize: 17.sp,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),

//               SizedBox(height: 2.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void showPaymentSuccessDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       barrierColor: Colors.black.withOpacity(0.3),
//       builder: (context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           child: Stack(
//             alignment: Alignment.topCenter,
//             children: [
//               /// Popup Card
//               Container(
//                 margin: EdgeInsets.only(top: 5.h),
//                 padding: EdgeInsets.fromLTRB(5.w, 8.h, 5.w, 3.h),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Stack(
//                   children: [
//                     /// Payment Info
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         text_widget(
//                           "Great",
//                           fontSize: 17.sp,
//                           fontWeight: FontWeight.w600,
//                           color: const Color(0xFFF86624),
//                         ),
//                         SizedBox(height: 0.5.h),
//                         text_widget(
//                           "Payment Success",
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         SizedBox(height: 3.h),

//                         _paymentRow("Payment Mode", "Apple Pay"),
//                         _paymentRow("Total Amount", "\$23.00"),
//                         _paymentRow("Pay Date", "Apr 10, 2023"),
//                         _paymentRow("Pay Time", "10:45 am"),

//                         Divider(height: 3.h),

//                         text_widget("Total Pay", fontSize: 16.sp),
//                         text_widget(
//                           "\$23.00",
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.bold,
//                           color: const Color(0xFFF86624),
//                         ),
//                       ],
//                     ),

//                     /// Close Icon (Top Right)
//                     Positioned(
//                       top: 0,
//                       right: 0,
//                       child: IconButton(
//                         icon: const Icon(Icons.close, color: Colors.grey),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               /// Top Circular Check Icon
//               Positioned(
//                 top: 16,
//                 child: CircleAvatar(
//                   radius: 40,
//                   backgroundColor: Colors.white,
//                   child: Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: LinearGradient(
//                         colors: [Color(0xFFF86624), Color(0xFFFF9E45)],
//                       ),
//                     ),
//                     child: const Icon(
//                       Icons.check,
//                       color: Colors.white,
//                       size: 32,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _paymentRow(String label, String value) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 0.8.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           text_widget(label, fontSize: 16.sp, color: Colors.black),
//           text_widget(value, fontSize: 16.sp, color: Colors.black),
//         ],
//       ),
//     );
//   }
// }
