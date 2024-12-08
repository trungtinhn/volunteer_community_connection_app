import 'package:flutter/material.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';

class InputText extends StatefulWidget {
  final String label;
  final String hinttext;
  final String name;
  final bool isRequired;
  final ValueChanged<String> onChanged;
  final bool? readOnly;
  final bool? obscureText;

  const InputText(
      {super.key,
      required this.label,
      required this.name,
      required this.hinttext,
      required this.isRequired,
      required this.onChanged,
      this.readOnly,
      this.obscureText});

  @override
  State<InputText> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputText> {
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
              if (widget.isRequired)
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
              obscureText:
                  widget.obscureText != null && widget.obscureText == true
                      ? true
                      : false,
              readOnly: widget.readOnly != null && widget.readOnly == true
                  ? true
                  : false,
              initialValue: widget.name,
              validator: (value) =>
                  (value?.isEmpty ?? true) ? 'Title is required' : null,
              onChanged: (value) {
                widget.onChanged(value);
              },
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
                  labelStyle: const TextStyle(
                      fontFamily: 'CeraPro', fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: AppColors.white)),
        ],
      ),
    );
  }
}
