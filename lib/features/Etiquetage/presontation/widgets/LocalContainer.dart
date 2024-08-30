import 'package:flutter/material.dart';

class LocalContainer extends StatelessWidget {
  final Widget? child;
  final double? paddingHor;

  const LocalContainer({super.key, this.child, this.paddingHor // Default padding if not provided
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 2, // Set width to 50% of screen width
      padding: EdgeInsets.symmetric(
        horizontal: paddingHor ?? 0.0, // Use default padding if paddingHor is null
      ),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}
