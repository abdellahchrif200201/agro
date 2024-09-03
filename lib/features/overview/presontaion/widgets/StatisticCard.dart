// Flutter imports:
import 'package:devti_agro/core/config/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final int index;
  final Color? bgColor;
  final Widget? child;

  const StatisticCard({
    super.key,
    required this.title,
    required this.value,
    required this.index,
    this.bgColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Check the orientation of the device
    final themeBloc = BlocProvider.of<ThemeBloc>(context).state.isDarkMode;

    return Expanded(
      child: Container(
        height: 123.h, // Adjust the height based on orientation
        padding: EdgeInsets.all(3),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: themeBloc ? Colors.white : Colors.black, width: 0.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                color: bgColor ?? Colors.transparent,
                borderRadius: BorderRadius.circular(25.r),
              ),
              alignment: Alignment.center,
              child: child,
            ),
            Gap(12.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Gap(5.h),
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "${value} %",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xffFFFFFF),
                  fontFamily: "Poppins",
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
