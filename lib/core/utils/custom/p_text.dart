import 'package:flutter/material.dart';
import 'package:sales/core/utils/app_colors.dart';
import 'package:sales/core/utils/globals.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class PText extends StatelessWidget {
  final String title;
  final PSize size;
  final TextDecoration? decoration;
  final FontWeight fontWeight;
  final Color fontColor;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? alignText;
  const PText({Key? key, required this.title, required this.size,this.fontColor = AppColors.black,
    this.fontWeight = FontWeight.w600, this.overflow,this.maxLines,this.decoration=TextDecoration.none, this.alignText,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   double fontSize = size == PSize.large ? 17.0.sp : size == PSize.medium ? 14.0.sp : size == PSize.small ? 12.0.sp :
   size==PSize.veryLarge ?20.sp:size==PSize.veryVeryLarge ?24.sp:10.sp;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(title,textAlign: alignText ?? TextAlign.start,style: TextStyle(fontWeight: fontWeight,
            fontSize: fontSize,
            color: fontColor,
            height: 1.2,
            fontFamily: 'regular',
            letterSpacing: -0.02,
            decoration: decoration,
            overflow: overflow),maxLines:maxLines,)),
      ],
    );
  }

}

