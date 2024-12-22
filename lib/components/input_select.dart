import 'package:flutter/material.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';

class InputSelectData extends StatefulWidget {
  final String label;
  final String hinttext;
  final String selectedOption;
  final Function(String) onChanged;
  final List<String> list;

  const InputSelectData({
    super.key,
    required this.list,
    required this.selectedOption,
    required this.onChanged,
    required this.label,
    required this.hinttext,
  });

  @override
  State<InputSelectData> createState() => _InputSelectDataState();
}

class _InputSelectDataState extends State<InputSelectData> {
  late String? value = 'Quyên góp tiền';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.label, style: kLableSize15Black),
              const Text(
                '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.whitePorcelain,
              border: Border.all(width: 1, color: AppColors.greyIron),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              value: value ?? widget.selectedOption,
              onChanged: (newValue) {
                setState(() {
                  value = newValue;
                });
                if (newValue != null) widget.onChanged(newValue);
              },
              hint: Text(widget.hinttext, style: kLableSize15Black),
              dropdownColor: AppColors.whitePorcelain,
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 20,
              underline: const SizedBox(),
              isExpanded: true,
              style: const TextStyle(color: Colors.black, fontSize: 15),
              items: widget.list.map((valueItem) {
                return DropdownMenuItem(
                  value: valueItem,
                  child: Text(valueItem),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
