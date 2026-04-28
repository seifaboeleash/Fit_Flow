import 'package:fit_flow/core/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.color,
    this.height,
    this.radius,
    this.textColor,
    this.prefix,
    this.sufix,
    this.gap,
    this.fontSize,
  });

  final String text;
  final Function()? onTap;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? color;
  final double? radius;
  final Color? textColor;
  final Widget? prefix;
  final Widget? sufix;
  final double? gap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width?.w,
        height: height?.h ?? 50.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(radius?.r ?? 12.r),
        ),
        child: Row(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            prefix ?? SizedBox.shrink(),
            CustomText(
              text: text, 
              color: textColor ?? Colors.black,
               fontsize: fontSize?.sp ?? 16.sp, weight: FontWeight.w500),
            Gap(gap ?? 0.0),
            sufix ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}