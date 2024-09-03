import 'package:flutter/material.dart';

class RefreshData extends StatelessWidget {
  final String? message;
  final VoidCallback? onPressed;

  const RefreshData({Key? key, this.message, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (message != null) ...[
            Text(
              message!,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
            const SizedBox(height: 16),
          ],
          TextButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.refresh, color: Colors.blue),
            label: const Text(
              'Retry',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
