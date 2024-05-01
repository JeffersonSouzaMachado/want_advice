import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text, this.size, this.align, this.color, this.height});

  final String text;
  final double? size;
  final TextAlign? align;
  final Color? color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: align ?? TextAlign.start,
        style: TextStyle(
          height: height ?? 0.6,
          fontFamily: 'Jomhuria',
          fontSize: size ?? 18,
          color: color ?? Colors.white
        ));
  }
}
