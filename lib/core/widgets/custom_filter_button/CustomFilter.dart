import 'package:devti_agro/core/config/constants/assets.dart';
import 'package:devti_agro/core/config/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class CustomFilter extends StatelessWidget {
  final VoidCallback? filterAction;
  const CustomFilter({super.key, this.filterAction});

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context).state.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: DashedBorder.fromBorderSide(
          dashLength: 4.w,
          side: const BorderSide(
            color: Color(0xFFF4F4F4),
            width: 2,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
        child: InkWell(
          splashColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          highlightColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
          onTap: filterAction,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: SvgPicture.asset(
              Assets.kSvgFilter,
              color: themeBloc ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
