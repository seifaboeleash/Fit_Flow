import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text,  this.color,  this.weight,  this.fontsize, this.fontfamily});
  final String text;
  final Color? color;
  final FontWeight? weight;
  final double? fontsize;
  final String? fontfamily;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      
      textScaler: TextScaler.linear(1),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: fontfamily,
        fontSize: fontsize!.sp,
        fontWeight: weight,
        color: color,
      ),
    );
  }
}
