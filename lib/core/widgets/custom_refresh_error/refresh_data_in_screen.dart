import 'package:flutter/material.dart';

class RefreshDataInScreen extends StatelessWidget {
  final String? message;
  final VoidCallback? onPressed;

  const RefreshDataInScreen({Key? key, this.message, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (message != null) ...[
            Text(
              message!,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
            const SizedBox(height: 16),
          ],
          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/reload.png"))),
            ),
          )
        ],
      ),
    );
  }
}