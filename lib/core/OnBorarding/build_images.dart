import 'package:flutter/material.dart';

class BuildImages extends StatelessWidget {
  const BuildImages({super.key, required this.image});

  final String image;
  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(image), width: 350);
  }
}