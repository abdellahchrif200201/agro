import 'package:flutter/material.dart';

class EditItem extends StatelessWidget {
  final Widget? widget;
  final String title;
  final TextEditingController? controller;
  const EditItem({
    super.key,
    this.widget,
     this.controller,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 5,
          child: widget ??
               TextField(
                 controller: controller,
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // Black border when not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green), // Green border when focused
                  ),
                ),
              ),
        )
      ],
    );
  }
}
