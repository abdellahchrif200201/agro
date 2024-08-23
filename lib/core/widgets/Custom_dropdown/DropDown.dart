import 'package:devti_agro/features/Etiquetage/presontation/widgets/LocalContainer.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


class Dropdown extends StatefulWidget {
  final List<String> dropDownItem;
  final String label;
  final String hint;

  Dropdown({
    required this.dropDownItem,
    required this.label,
    required this.hint,
  });

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    // Set the default value to the first item in the dropdown list
    selectedValue = widget.dropDownItem.isNotEmpty ? widget.dropDownItem[0] : null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        LocalContainer(
          child: DropdownButtonFormField2<String>(
            isExpanded: true,
            /*decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ), */
            hint: Text(
              widget.hint,
              style: TextStyle(fontSize: 14),
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
          ),
        ),
      ],
    );
  }
}
