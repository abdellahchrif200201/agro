import 'package:devti_agro/core/config/constants/assets.dart';
import 'package:devti_agro/core/config/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:devti_agro/features/chambre/presontaion/bloc/chambres_bloc.dart';

class DateRangePicker extends StatefulWidget {
  final Function(DateTimeRange) onDateRangeSelected; // Callback function

  const DateRangePicker({super.key, required this.onDateRangeSelected});

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTimeRange? _selectedDateRange;

  Future<void> _pickDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      barrierColor: Colors.green,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDateRange: _selectedDateRange ??
          DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(const Duration(days: 7)),
          ),
    );

    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
      widget.onDateRangeSelected(_selectedDateRange!); // Notify parent widget
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context).state.isDarkMode;

    final DateFormat dateFormat = DateFormat('MMM dd, yyyy');

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => _pickDateRange(context),
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: themeBloc ? Colors.white : Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                  child: SvgPicture.asset(
                    Assets.kSvgDate,
                    height: 40,
                    width: 40,
                    color: themeBloc ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(width: 2),
                Text(
                  _selectedDateRange == null
                      ? '${dateFormat.format(DateTime.now())} - ${dateFormat.format(DateTime.now())}'
                      : '${dateFormat.format(_selectedDateRange!.start)} - ${dateFormat.format(_selectedDateRange!.end)}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),
                ),
                const SizedBox(width: 2),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
