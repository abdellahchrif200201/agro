import 'package:devti_agro/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomDataIsEmpty extends StatelessWidget {
  final VoidCallback? onPressed;
  const CustomDataIsEmpty({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(S.of(context).no_data_available),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/refresh.png"))),
            ),
          )
        ],
      ),
    );
  }
}
