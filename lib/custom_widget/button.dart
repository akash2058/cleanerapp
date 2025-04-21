import 'package:binbookingapp/custom_widget/transaction_route.dart';
import 'package:binbookingapp/utils/appcolors.dart';
import 'package:binbookingapp/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

enum CleanerButtonType { elevated, outline, text, navigation }

class CleanerButton extends StatelessWidget {
  final CleanerButtonType type;
  final double? height;
  final double? width;
  final bool? isloading;
  final Color? bordercolor;
  final String label;
  final Color? backgroundcolor;
  final VoidCallback? onPressed;
  final Widget? destination;

  const CleanerButton.elevated({
    super.key,
    required this.label,
    this.backgroundcolor,
    this.height,
    this.width,
    required this.onPressed,
    this.bordercolor, this.isloading,
  })  : type = CleanerButtonType.elevated,
        destination = null;

  const CleanerButton.outline({
    super.key,
    required this.label,
    required this.onPressed,
    this.height,
    this.width,
    this.backgroundcolor,
    this.bordercolor, this.isloading,
  })  : type = CleanerButtonType.outline,
        destination = null;

  const CleanerButton.text({
    super.key,
    required this.label,
    required this.onPressed,
    this.height,
    this.width,
    this.backgroundcolor, this.isloading,
  })  : type = CleanerButtonType.text,
        destination = null,
        bordercolor = null;
        

  const CleanerButton.navigation({
    super.key,
    required this.label,
    required this.destination,
    this.height,
    this.width,
    this.backgroundcolor, this.isloading,
  })  : type = CleanerButtonType.navigation,
        onPressed = null,
        bordercolor = null;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case CleanerButtonType.elevated:
        return SizedBox(
          height: height,
          width: width,
          child: ElevatedButton(
            
            style: ElevatedButton.styleFrom(
              elevation: 5.r,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)),
              backgroundColor:
                  backgroundcolor, // Background color for ElevatedButton
            ),
            onPressed: onPressed,
            child:isloading == true?LoadingAnimationWidget.hexagonDots(color: CleanerAppcolors.primaryWhitecolor, size: 30.r):
                Text(label, style: buttonfond // Text color for ElevatedButton
                    ),
          ),
        );
      case CleanerButtonType.outline:
        return SizedBox(
          height: height,
          width: width,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)),
              side: bordercolor != null
                  ? BorderSide(color: bordercolor!)
                  : BorderSide.none, // Border color for OutlinedButton
            ),
            onPressed: onPressed,
            child:
                Text(label, style: buttonfond // Text color for OutlinedButton
                    ),
          ),
        );
      case CleanerButtonType.text:
        return SizedBox(
          height: height,
          width: width,
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blue, // Text color for TextButton
            ),
            onPressed: onPressed,
            child: Text(
              label,
              style: forgotpasswordfont,
            ),
          ),
        );
      case CleanerButtonType.navigation:
        return SizedBox(
          height: height,
          width: width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)),
              backgroundColor:
                  backgroundcolor, // Background color for Navigation Button
            ),
            onPressed: () {
              Navigator.push(context, CustomPageRoute(child: destination!));
            },
            child: Text(
              label,
              style: buttonfond,
            ),
          ),
        );
    }
  }
}
