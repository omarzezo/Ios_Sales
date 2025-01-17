import 'package:flutter/material.dart';
import 'package:sales/core/utils/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LayerOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:Adaptive.w(100),
      height: Adaptive.h(10),
      decoration: const BoxDecoration(
        color: AppColors.layerOneBg,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60.0),
            bottomRight: Radius.circular(60.0)
        ),
      ),
    );
  }
}