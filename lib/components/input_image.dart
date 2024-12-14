import 'package:flutter/material.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';

class InputImage extends StatefulWidget {
  final String label;
  final VoidCallback onPress;
  const InputImage({super.key, required this.label, required this.onPress});

  @override
  State<InputImage> createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
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


          
          
        ],
      ),
    );
  }
}
