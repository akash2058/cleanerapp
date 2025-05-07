import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class SelectedImageCard extends StatelessWidget {
  final VoidCallback? onTap;
  final XFile imagepath;
  const SelectedImageCard({super.key, required this.imagepath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.r,
      width: 100.r,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: 80.r,
            width: 100.r,
            child: DecoratedBox(
              decoration: BoxDecoration(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.file(File(imagepath.path), fit: BoxFit.fill),
              ),
            ),
          ),
          Positioned(
            top: -10.r,
            right: -10.r,
            child: GestureDetector(
              onTap: onTap,
              child: Icon(Icons.remove_circle, color: Colors.red, size: 40.r),
            ),
          ),
        ],
      ),
    );
  }
}
