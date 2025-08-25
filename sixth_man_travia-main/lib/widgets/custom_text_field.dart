import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget customTextField({
  required String hint,
  bool obscureText = false,
  bool hasSuffix = false,
  bool enabled = true,
  Widget? suffixIcon,
  TextEditingController? controller,
  TextInputType? keyboardType,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.h),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obscureText,
      enabled: enabled,
      style: TextStyle(
        color: Colors.black,
        fontSize: 14.5.sp,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 13.5.sp,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: hasSuffix ? suffixIcon : null,
        contentPadding: EdgeInsets.symmetric(
          vertical: 1.4.h,
          horizontal: 5.w,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(
            color: Colors.transparent, // 👈 transparent border
            width: 1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(
            color: Colors.transparent, // 👈 transparent border
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(
            color: Color(0xFFFF6A00), // 👈 orange on focus
            width: 1.5,
          ),
        ),
      ),
    ),
  );
}
