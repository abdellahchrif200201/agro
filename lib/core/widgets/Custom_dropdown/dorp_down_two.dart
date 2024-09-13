import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownTwo extends StatefulWidget {
  final List<String> dropDownItems;
  final String? label;
  final String hint;
  final ValueChanged<String?>? onChanged;
  final bool border;

  const DropdownTwo({super.key, required this.dropDownItems, this.label, required this.hint, this.onChanged, this.border = false});

  @override
  _DropdownTwoState createState() => _DropdownTwoState();
}

class _DropdownTwoState extends State<DropdownTwo> {
  String? selectedValue;
  List<String> uniqueItems = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    uniqueItems = widget.dropDownItems.toSet().toList();
    if (uniqueItems.isNotEmpty) {
      selectedValue = null; // Ensure initial value is null
    }
  }

  @override
  void didUpdateWidget(covariant DropdownTwo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.dropDownItems != oldWidget.dropDownItems) {
      setState(() {
        uniqueItems = widget.dropDownItems.toSet().toList();
        if (selectedValue == null || !uniqueItems.contains(selectedValue)) {
          selectedValue = null;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: widget.border ? Border.all(color: Colors.black.withOpacity(0.1)) : null, borderRadius: BorderRadius.circular(10)),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.label != null)
            Text(
              widget.label!,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          Expanded(
            child: DropdownButtonFormField2<String>(
              isExpanded: true,
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              hint: Text(
                selectedValue == null ? widget.hint : selectedValue!,
                style: const TextStyle(fontSize: 14),
              ),
              items: uniqueItems.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
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
                  return (item.value.toString().toLowerCase().contains(searchValue.toLowerCase()));
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
      ),
    );
  }
}
