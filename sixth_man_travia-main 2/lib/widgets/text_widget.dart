import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget text_widget(
  String text, {
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
  TextDecoration? decoration,
  TextAlign? textAlign,
  double? letterSpacing,
  Color? decorationColor,
  double? decorationWidth,
  double? height,
  int? maxline,
  bool isShadow = false,
  String? fontFamily, // ✅ NEW PARAMETER
}) {
  TextStyle baseStyle;

  switch (fontFamily?.toLowerCase()) {
    case 'poppins':
      baseStyle = GoogleFonts.poppins();
      break;
    case 'montserrat':
      baseStyle = GoogleFonts.montserrat();
      break;
    case 'inter':
      baseStyle = GoogleFonts.inter();
      break;
    case 'plusjakartasans':
    default:
      baseStyle = GoogleFonts.plusJakartaSans();
  }

  return Text(
    text,
    maxLines: maxline,
    textAlign: textAlign,
    style: baseStyle.copyWith(
      fontSize: fontSize ?? 17.sp,
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color ?? Colors.black,
      decoration: decoration ?? TextDecoration.none,
      decorationColor: decorationColor,
      decorationThickness: decorationWidth,
      letterSpacing: letterSpacing,
      height: height,
      shadows: isShadow
          ? [
              const Shadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(1, 1),
              )
            ]
          : [],
    ),
  );
}
