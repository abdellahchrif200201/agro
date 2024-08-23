// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDataTable extends StatefulWidget {
  final List<List<String>> rowsData;
  final List<String> headerTitles;

  const CustomDataTable({
    super.key,
    required this.rowsData,
    required this.headerTitles,
  });

  @override
  State<CustomDataTable> createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  bool isAscendingOrder = true;
  int sortColumnIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Color(0xFFD8D8D8),
        ),
        child: PaginatedDataTable(
          rowsPerPage: 12,
          availableRowsPerPage: const [12, 25, 50],
          onRowsPerPageChanged: (value) {
            // TODO: Replace this with a state management solution
            // setState(() {
            //   _pageSize = value!;
            // });
          },
          sortAscending: isAscendingOrder,
          headingRowColor: WidgetStatePropertyAll(Color(0xffFAFAFA)),
          showCheckboxColumn: true,
          sortColumnIndex: sortColumnIndex,
          columnSpacing: 20.w,
          source: _DataSource(data: widget.rowsData, sortColumnIndex: sortColumnIndex, isAscendingOrder: isAscendingOrder),
          columns: widget.headerTitles.map(
            (headerTitle) {
              return DataColumn(
                label: Text(
                  headerTitle,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Color(0xff727272),
                      ),
                ),
                onSort: (int columnIndex, bool ascending) {
                  setState(
                    () {
                      if (sortColumnIndex != columnIndex) {
                        sortColumnIndex = columnIndex;
                        isAscendingOrder = true;
                      } else {
                        isAscendingOrder = ascending;
                      }
                      widget.rowsData.sort((listA, listB) {
                        final cellA = listA[columnIndex];
                        final cellB = listB[columnIndex];

                        // Handle numeric and string sorting
                        if (columnIndex == 2) {
                          // Assuming column 2 is for temperatures
                          final tempA = double.tryParse(cellA.replaceAll('°C', '')) ?? 0;
                          final tempB = double.tryParse(cellB.replaceAll('°C', '')) ?? 0;
                          return isAscendingOrder ? tempA.compareTo(tempB) : tempB.compareTo(tempA);
                        } else {
                          return isAscendingOrder ? cellA.compareTo(cellB) : cellB.compareTo(cellA);
                        }
                      });
                    },
                  );
                },
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<List<String>> data;
  final int sortColumnIndex;
  final bool isAscendingOrder;

  _DataSource({
    required this.data,
    required this.sortColumnIndex,
    required this.isAscendingOrder,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final row = data[index];

    return DataRow(
      cells: row.map(
        (String cell) {
          final Text child = Text(
            cell,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Color(0xff000000),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          );

          if (cell.endsWith("°C")) {
            final temperature = double.tryParse(cell.replaceAll('°C', '')) ?? 0;
            return DataCell(
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Chip(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: temperature > 25 ? Colors.red[100] : Colors.blue[100],
                      padding: EdgeInsets.zero,
                      labelStyle: TextStyle(
                        fontSize: 10.sp,
                      ),
                      label: Align(
                        alignment: Alignment.centerLeft,
                        child: child,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return DataCell(
            Align(
              alignment: Alignment.centerLeft,
              child: child,
            ),
          );
        },
      ).toList(),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
