import 'package:binbookingapp/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CleanerChip extends StatelessWidget {
  final double? height;
  final double? width;
  final String label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final IconData? icon;
  const CleanerChip({
    super.key,
    required this.label,
    this.onPressed,
    this.backgroundColor,
    this.height,
    this.width, this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: height,
        width: width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: backgroundColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10).r,
            child: Text(
              label,
              style: dashboardlablefontwhite,
            ),
          ),
        ),
      ),
    );
  }
}

class CleanerWhiteFontChip extends StatelessWidget {
  final double? height;
  final double? width;
  final String label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  const CleanerWhiteFontChip({
    super.key,
    required this.label,
    this.onPressed,
    this.backgroundColor,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: height,
        width: width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: backgroundColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8).r,
            child: Text(
              label,
              style: tabfonts,
            ),
          ),
        ),
      ),
    );
  }
}
