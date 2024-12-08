import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';

class InputNumberField extends StatefulWidget {
  final String label;
  final String hinttext;
  final String name;
  final ValueChanged<String> onChanged;

  const InputNumberField(
      {super.key,
      required this.label,
      required this.name,
      required this.hinttext,
      required this.onChanged});

  @override
  State<InputNumberField> createState() => _InputNumberComponentState();
}

class _InputNumberComponentState extends State<InputNumberField> {
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
            initialValue: widget.name,
            validator: (value) =>
                (value?.isEmpty ?? true) ? 'Title is required' : null,
            onChanged: (value) {
              widget.onChanged(value);
            },
            style: kLableSize15Black,
            keyboardType: TextInputType.number,
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
                fillColor: AppColors.white),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ],
      ),
    );
  }
}
