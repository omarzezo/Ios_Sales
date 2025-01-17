import 'package:flutter/material.dart';
import 'package:sales/core/utils/app_colors.dart';
import 'package:sales/core/utils/globals.dart';
import 'dart:core';
import 'p_text.dart';




class PButton extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final String? title;
  final PSize size;
  final PStyle style;
  final List<String>? dropDown;
  final IconData? icon;
  final Color textColor;
  final bool isFitWidth;
  final Color? fillColor;

  const PButton({Key? key, required this.onPressed,this.size = PSize.medium,this.isFitWidth=false,this.title, this.style = PStyle.secondary, this.icon, this.dropDown, this.textColor
  = AppColors.primary,this.fillColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color buttonColor = style == PStyle.primary ? AppColors.primary : style == PStyle.secondary ?
    AppColors.primary : AppColors.white;
    return   ElevatedButton(onPressed: onPressed,onHover:(m){},

          style: ElevatedButton.styleFrom(backgroundColor: fillColor ?? buttonColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26),
              side:style == PStyle.tertiary ? const BorderSide(width: 1.0, color: AppColors.hintText) : BorderSide.none),
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
              minimumSize:isFitWidth?const Size.fromHeight(40): const Size(80, 40)
          ), child:  Row(
      mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              icon != null ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Icon(icon,color: style == PStyle.tertiary ? textColor : AppColors.white,size: 20,),
              ) : const SizedBox.shrink(),
              title != null ? Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: PText(title: title!, size: size,fontColor: style == PStyle.tertiary ? textColor : AppColors.white),
                ),
              ): const SizedBox.shrink(),

            ],
          ));
  }

}


class RoundedButton extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final Color backgroundColor;
  final String? title;
  final PSize size;
  final PStyle style;
  final IconData? icon;
  final Color textColor;
  final Color? fillColor;

  const RoundedButton({Key? key, required this.onPressed,this.backgroundColor=AppColors.primary,
    this.size = PSize.medium, this.title, this.style = PStyle.secondary, this.icon, this.textColor = AppColors.primary,this.fillColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Color buttonColor = style == PStyle.primary ? Constants.yellow : style == PStyle.secondary ? Constants.violet : Constants.white;
    return   TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: backgroundColor)
                ),
            ),
          backgroundColor:MaterialStateProperty.all<Color>(backgroundColor),
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(left: 14,right: 14)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon,size: 20,color: textColor,),
            const SizedBox(width: 2,),
            PText(title: title!, size: size,fontColor: textColor,)
          ],
        )
    );
  }

}