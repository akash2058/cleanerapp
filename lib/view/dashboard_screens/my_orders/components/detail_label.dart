import 'package:binbookingapp/utils/style.dart';
import 'package:flutter/material.dart';

class DetailsLabel extends StatelessWidget {
  final String label;
  final String sublabel;
  const DetailsLabel({super.key, required this.label, required this.sublabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: subtitlefonts),
        Text(sublabel, style: resendfontminigrey),
      ],
    );
  }
}