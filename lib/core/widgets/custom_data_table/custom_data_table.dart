import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDataTable extends StatefulWidget {
  final List<List<String>> rowsData;
  final List<String> headerTitles;
  final Function(int rowIndex)? onEditPressed;
  final Function(int rowIndex)? onDeletePressed;
  final int initialPage; // Parameter to set the initial page
  final int rowsPerPage; // Number of rows per page
  final int allPage;
  final int pageNow;
  final VoidCallback? onPressNextPage; // Callback for next page button
  final VoidCallback? onPressPreviousPage; // Callback for previous page button

  const CustomDataTable(
      {super.key,
      required this.rowsData,
      required this.headerTitles,
      this.onEditPressed,
      this.onDeletePressed,
      this.initialPage = 0,
      this.rowsPerPage = 20,
      this.onPressNextPage,
      this.onPressPreviousPage,
      this.allPage = 1,
      this.pageNow = 1});

  @override
  State<CustomDataTable> createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  bool isAscendingOrder = true;
  int sortColumnIndex = 0;
  late int currentPage;
  late int rowsPerPage;

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPage; // Initialize currentPage with the parameter
    rowsPerPage = widget.rowsPerPage; // Initialize rowsPerPage with the parameter
  }

  @override
  Widget build(BuildContext context) {
    final int totalRows = widget.rowsData.length;
    // final int totalPages = (totalRows / rowsPerPage).ceil();

    // Calculate the paginated rows
    final startIndex = currentPage * rowsPerPage;
    final endIndex = (currentPage + 1) * rowsPerPage;
    final paginatedRows = widget.rowsData.sublist(
      startIndex,
      endIndex < totalRows ? endIndex : totalRows,
    );

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Enable horizontal scrolling
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical, // Enable vertical scrolling if needed
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: const Color(0xFFD8D8D8),
              ),
              child: DataTable(
                sortAscending: isAscendingOrder,
                headingRowColor: MaterialStateColor.resolveWith((states) => const Color(0xffFAFAFA)),
                sortColumnIndex: sortColumnIndex,
                columnSpacing: 20.w,
                columns: [
                  ...widget.headerTitles.map(
                    (headerTitle) {
                      return DataColumn(
                        label: Text(
                          headerTitle,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: const Color(0xff727272),
                              ),
                        ),
                        onSort: (int columnIndex, bool ascending) {
                          setState(() {
                            if (sortColumnIndex != columnIndex) {
                              sortColumnIndex = columnIndex;
                              isAscendingOrder = true;
                            } else {
                              isAscendingOrder = ascending;
                            }
                            widget.rowsData.sort((listA, listB) {
                              final cellA = listA[columnIndex];
                              final cellB = listB[columnIndex];

                              if (columnIndex == 2) {
                                final tempA = double.tryParse(cellA.replaceAll('°C', '')) ?? 0;
                                final tempB = double.tryParse(cellB.replaceAll('°C', '')) ?? 0;
                                return isAscendingOrder ? tempA.compareTo(tempB) : tempB.compareTo(tempA);
                              } else {
                                return isAscendingOrder ? cellA.compareTo(cellB) : cellB.compareTo(cellA);
                              }
                            });
                          });
                        },
                      );
                    },
                  ).toList(),
                  const DataColumn(
                    label: Text(
                      'Actions',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Color(0xff727272)),
                    ),
                  ),
                ],
                rows: paginatedRows.asMap().entries.map(
                  (entry) {
                    final index = entry.key + startIndex; // Adjust index based on pagination
                    final row = entry.value;

                    return DataRow(
                      cells: [
                        ...row.map(
                          (String cell) {
                            final Text child = Text(
                              cell,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: const Color(0xff000000),
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
                                      padding: const EdgeInsets.all(10),
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
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: widget.onEditPressed != null ? () => widget.onEditPressed!(index) : null,
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: widget.onDeletePressed != null ? () => widget.onDeletePressed!(index) : null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ),
        // Pagination controls
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // To First Page Button

              // Previous Page Button
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: widget.onPressPreviousPage,
              ),
              // Page Number Display
              Text('Page ${widget.pageNow} of ${widget.allPage}'),
              // Next Page Button
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: widget.onPressNextPage,
              ),
              // To Last Page Button
            ],
          ),
        ),
      ],
    );
  }
}
