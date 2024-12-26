import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';

class InputTimePicker extends StatefulWidget {
  final String label;
  final String hinttext;
  final String? name;
  final ValueChanged<DateTime> onChanged;

  const InputTimePicker(
      {super.key,
      required this.label,
      required this.name,
      required this.hinttext,
      required this.onChanged});

  @override
  State<InputTimePicker> createState() => _InputNumberComponentState();
}

class _InputNumberComponentState extends State<InputTimePicker> {
  DateTime? selectedDate;

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onChanged(selectedDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.label,
                style: kLableSize15Black,
              ),
              const Text(
                '*',
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            validator: (value) =>
                (value?.isEmpty ?? true) ? 'Title is required' : null,
            readOnly: true,
            controller: TextEditingController(
              text: selectedDate != null
                  ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                  : widget.name,
            ),
            style: kLableSize15Black,
            decoration: InputDecoration(
                hintText: widget.hinttext,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.greyIron),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.greyShuttle),
                ),
                filled: true,
                suffixIcon: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: const Icon(Icons.date_range_outlined),
                ),
                fillColor: AppColors.white),
          ),
        ],
      ),
    );
  }
}
