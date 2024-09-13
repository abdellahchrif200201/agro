import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomDataTable extends StatefulWidget {
  final List<List<String>> rowsData;
  final List<String> headerTitles;
  final Function(int rowIndex)? onEditPressed;
  final Function(int rowIndex)? onDeletePressed;
  final int initialPage;
  final int rowsPerPage;
  final int allPage;
  final int pageNow;
  final VoidCallback? onPressNextPage;
  final VoidCallback? onPressPreviousPage;

  const CustomDataTable({
    super.key,
    required this.rowsData,
    required this.headerTitles,
    this.onEditPressed,
    this.onDeletePressed,
    this.initialPage = 0,
    this.rowsPerPage = 20,
    this.onPressNextPage,
    this.onPressPreviousPage,
    this.allPage = 1,
    this.pageNow = 1,
  });

  @override
  State<CustomDataTable> createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  bool isAscendingOrder = true;
  int sortColumnIndex = 0;
  late int currentPage;
  late int rowsPerPage;
  late List<bool> isDeleting;

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPage;
    rowsPerPage = widget.rowsPerPage;
    isDeleting = List.filled(widget.rowsData.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final int totalRows = widget.rowsData.length;
    final startIndex = currentPage * rowsPerPage;
    final endIndex = (currentPage + 1) * rowsPerPage;
    final paginatedRows = widget.rowsData.sublist(
      startIndex,
      endIndex < totalRows ? endIndex : totalRows,
    );

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: const Color(0xFFD8D8D8),
              ),
              child: DataTable(
                sortAscending: isAscendingOrder,
                headingRowColor: MaterialStateColor.resolveWith((states) => const Color(0xffFAFAFA)),
                sortColumnIndex: sortColumnIndex,
                columnSpacing: 20,
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
                    final index = entry.key + startIndex;
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
                                fontSize: 12,
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
                                          fontSize: 10,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 40,
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    onPressed: widget.onEditPressed != null ? () => widget.onEditPressed!(index) : null,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.info,
                                    animType: AnimType.rightSlide,
                                    title: 'Delete chambre',
                                    desc: 'Are you sure?',
                                    titleTextStyle: Theme.of(context).textTheme.titleMedium,
                                    descTextStyle: Theme.of(context).textTheme.titleMedium,
                                    btnOkText: 'Delete',
                                    btnCancelOnPress: () {
                                      setState(() {
                                        isDeleting[index] = false;
                                      });
                                    },
                                    btnOkOnPress: () async {
                                      setState(() {
                                        isDeleting[index] = true;
                                      });
                                      if (widget.onDeletePressed != null) {
                                        await widget.onDeletePressed!(index);
                                        setState(() {
                                          isDeleting[index] = false;
                                        });
                                      }
                                    },
                                  ).show();
                                },
                                child: Container(
                                  width: 40,
                                  margin: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: isDeleting[index]
                                        ? LoadingAnimationWidget.fallingDot(
                                            color: Colors.green,
                                            size: 30,
                                          )
                                        : const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                  ),
                                ),
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
        // if( if (widget.allPage > 1))
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Column(
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           IconButton(
        //             icon: const Icon(
        //               Icons.chevron_left,
        //             ),
        //             onPressed: widget.onPressPreviousPage,
        //           ),
        //           Text('Page ${widget.pageNow} of ${widget.allPage}'),
        //           IconButton(
        //             icon: const Icon(
        //               Icons.chevron_right,
        //             ),
        //             onPressed: widget.onPressNextPage,
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
