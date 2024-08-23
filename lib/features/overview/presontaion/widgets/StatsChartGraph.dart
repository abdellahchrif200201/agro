// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsChartGraph extends StatelessWidget {
  const StatsChartGraph({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    final List<_ChartData> data = [
      _ChartData('Feb', 40, 60, 70),
      _ChartData('Mar', 30, 50, 80),
      _ChartData('Apr', 50, 70, 90),
      _ChartData('May', 40, 60, 70),
      _ChartData('Jun', 30, 50, 80),
      _ChartData('Jul', 50, 70, 90),
      _ChartData('Aug', 40, 60, 70),
      _ChartData('Sep', 30, 50, 80),
      _ChartData('Oct', 50, 70, 110),
    ];

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      margin: EdgeInsets.only(left: 10.w),
      primaryXAxis: const CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: const NumericAxis(
        majorGridLines: MajorGridLines(
          width: 1,
          dashArray: [5, 5], // Dotted line configuration
        ),
      ),
      series: [
        ColumnSeries(
          dataSource: data,
          xValueMapper: (dynamic data, _) => data.month,
          yValueMapper: (dynamic data, _) => data.value1,
          name: 'Taches réalisées',
          color: Color(0xFF4669FA),
        ),
        ColumnSeries(
          dataSource: data,
          xValueMapper: (dynamic data, _) => data.month,
          yValueMapper: (dynamic data, _) => data.value2,
          name: 'Taches réalisées',
          color: Color(0xFF0CE7FA),
        ),
        ColumnSeries(
          dataSource: data,
          xValueMapper: (dynamic data, _) => data.month,
          yValueMapper: (dynamic data, _) => data.value3,
          name: 'Taches réalisées',
          color: Color(0xFFFA916B),
        ),
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.month, this.value1, this.value2, this.value3);
  final String month;
  final double value1;
  final double value2;
  final double value3;
}
