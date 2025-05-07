
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CleanerTextfield extends StatelessWidget {
  final Iterable<String>? autofills;
  final ValueChanged<String>? onChanged;
  final Color? fillColor;
  final VoidCallback? onTap;
  final String hintlabel;
  final Widget? suffix;
  final bool? obstructtext;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validation;
  final Widget? prefix;
  const CleanerTextfield(
      {super.key,
      required this.hintlabel,
      this.fillColor,
      this.autofills,
      this.suffix,
      this.onTap,
      this.onChanged,
      this.controller,
      this.prefix,
      this.validation,
      this.obstructtext});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: autofills,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: obstructtext ?? false,
      validator: validation,
      controller: controller,
      style: dashboardlabelfontblack,
      decoration: InputDecoration(
        focusedErrorBorder:OutlineInputBorder(
              borderSide: BorderSide(color: CleanerAppcolors.primaryRedcolor),
              borderRadius: BorderRadius.circular(20.r)),
          fillColor: fillColor,
          filled: true,
          prefixIconConstraints: BoxConstraints(minWidth: 45.r),
          suffixIconConstraints: BoxConstraints(minWidth: 45.r),
          prefixIconColor: CleanerAppcolors.primarygreycolor,
          errorStyle: errorstyle,
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CleanerAppcolors.primarypurple),
              borderRadius: BorderRadius.circular(20.r)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 20).r,
          hintStyle: dashboardlablefontgrey,
          disabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: CleanerAppcolors.primaryminidarkgreycolor),
              borderRadius: BorderRadius.circular(20.r)),
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: CleanerAppcolors.primaryRedcolor),
              borderRadius: BorderRadius.circular(20.r)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: CleanerAppcolors.primaryminidarkgreycolor),
              borderRadius: BorderRadius.circular(20.r)),
          prefixIcon: prefix,
          suffixIcon: suffix,
          hintText: hintlabel),
    );
  }
}
