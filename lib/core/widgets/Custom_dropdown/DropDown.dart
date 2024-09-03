import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Dropdown extends StatefulWidget {
  final List<String> dropDownItem;
  final String? label;
  final String hint;

  const Dropdown({
    super.key,
    required this.dropDownItem,
    this.label,
    required this.hint,
  });

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String? selectedValue;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedValue = widget.dropDownItem.isNotEmpty ? widget.dropDownItem[0] : null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
              enabledBorder: InputBorder.none, // Remove border
              focusedBorder: InputBorder.none, // Remove focus border
            ),
            hint: Text(
              widget.hint,
              style: const TextStyle(fontSize: 14),
            ),
            items: widget.dropDownItem.map((item) {
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
            // This to clear the search value when you close the menu
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
