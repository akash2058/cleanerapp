import 'package:binbookingapp/custom_widget/button.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/form_validation.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FieldBottomSheet extends StatelessWidget {
  const FieldBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: CleanerAppcolors.primarylightgreycolor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10).r,
          child: Column(
            spacing: 5.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 10.r,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order No:', style: listiletitlefont),
                      TextFormField(
                        validator: enterserialnumber,
                        style: entertexttile,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10).r,
                          hintText: 'Enter serial number',
                          hintStyle: hintStyle,
                          errorStyle: errorstyle,
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CleanerAppcolors
                                      .primaryminigreycolor, // change this to your color
                              width: 1.5.r, // change thickness here
                            ),
                          ),
                          // 🔽 Default border when not focused
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CleanerAppcolors
                                      .primaryminidarkgreycolor, // change this to your color
                              width: 1.5.r, // change thickness here
                            ),
                          ),

                          // 🔽 Border when focused (on tap)
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CleanerAppcolors
                                      .primarypurple, // focused color
                              width: 1.5.r, // focused thickness
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        validator: enterserialnumber,
                        style: entertexttile,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10).r,
                          hintText: 'Enter serial number',
                          hintStyle: hintStyle,
                          errorStyle: errorstyle,
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CleanerAppcolors
                                      .primaryminigreycolor, // change this to your color
                              width: 1.5.r, // change thickness here
                            ),
                          ),
                          // 🔽 Default border when not focused
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CleanerAppcolors
                                      .primaryminidarkgreycolor, // change this to your color
                              width: 1.5.r, // change thickness here
                            ),
                          ),

                          // 🔽 Border when focused (on tap)
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CleanerAppcolors
                                      .primarypurple, // focused color
                              width: 1.5.r, // focused thickness
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        validator: enterserialnumber,
                        style: entertexttile,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10).r,
                          hintText: 'Enter serial number',
                          hintStyle: hintStyle,
                          errorStyle: errorstyle,
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CleanerAppcolors
                                      .primaryminidarkgreycolor, // change this to your color
                              width: 1.5.r, // change thickness here
                            ),
                          ),
                          // 🔽 Default border when not focused
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CleanerAppcolors
                                      .primaryminidarkgreycolor, // change this to your color
                              width: 1.5.r, // change thickness here
                            ),
                          ),

                          // 🔽 Border when focused (on tap)
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  CleanerAppcolors
                                      .primarypurple, // focused color
                              width: 1.5.r, // focused thickness
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CleanerButton.elevated(
                height: 55.r,
                backgroundcolor: CleanerAppcolors.primarypurple,
                width: MediaQuery.sizeOf(context).width,
                label: 'Confirm',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
