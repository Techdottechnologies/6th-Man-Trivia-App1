import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget socialIcon(String path) {
  return Container(
    height: 5.h,
    width: 5.h,
    decoration: const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Color(0xFF0000001A),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    padding: EdgeInsets.all(0.2.h),
    child: Image.asset(path, fit: BoxFit.contain),
  );
}
