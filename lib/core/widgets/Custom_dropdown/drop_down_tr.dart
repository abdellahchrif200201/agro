import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownTr<T> extends StatefulWidget {
  final List<T> dropDownItems;
  final T? selectedItem;
  final String? label;
  final String hint;
  final String Function(T) itemToString;
  final ValueChanged<T?>? onChanged;

  const DropdownTr({
    super.key,
    required this.dropDownItems,
    this.selectedItem,
    this.label,
    required this.hint,
    required this.itemToString,
    this.onChanged,
  });

  @override
  _DropdownTrState<T> createState() => _DropdownTrState<T>();
}

class _DropdownTrState<T> extends State<DropdownTr<T>> {
  T? selectedValue;
  List<T> uniqueItems = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    uniqueItems = widget.dropDownItems.toSet().toList();
    selectedValue = widget.selectedItem ?? (uniqueItems.isNotEmpty ? uniqueItems[0] : null);
  }

  @override
  void didUpdateWidget(covariant DropdownTr<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.dropDownItems != oldWidget.dropDownItems) {
      setState(() {
        uniqueItems = widget.dropDownItems.toSet().toList();
        if (selectedValue == null || !uniqueItems.contains(selectedValue)) {
          selectedValue = uniqueItems.isNotEmpty ? uniqueItems[0] : null;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedValue != null && !uniqueItems.contains(selectedValue)) {
      selectedValue = null; // Reset selectedValue if not valid
    }

    return Row(
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        Expanded(
          child: DropdownButtonFormField2<T>(
            isExpanded: true,
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            hint: Text(
              widget.hint,
              style: const TextStyle(fontSize: 14),
            ),
            items: uniqueItems.map((item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(
                  widget.itemToString(item),
                  style: const TextStyle(fontSize: 14),
                ),
              );
            }).toList(),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(right: 8),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 24,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              maxHeight: 200,
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
            dropdownSearchData: DropdownSearchData(
              searchController: searchController,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'Search...',
                    hintStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return widget.itemToString(item as T).toLowerCase().contains(searchValue.toLowerCase());
              },
            ),
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                searchController.clear();
              }
            },
          ),
        ),
      ],
    );
  }
}
