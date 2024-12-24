import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';

class InputImage extends StatefulWidget {
  final String label;
  final bool required;
  final Function(File?) onImagePicked;

  const InputImage(
      {super.key,
      required this.label,
      required this.onImagePicked,
      required this.required});

  @override
  State<InputImage> createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
  File? _imageFile; // Lưu trữ ảnh đã chọn

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path); // Lưu ảnh trong state
      });
      widget.onImagePicked(_imageFile); // Gửi ảnh ra ngoài qua callback
    } else {
      widget.onImagePicked(null); // Gửi giá trị null nếu không chọn ảnh
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
              widget.required
                  ? const Text(
                      '*',
                      style: TextStyle(color: Colors.red),
                    )
                  : const Text(''),
            ],
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _pickImage, // Gọi hàm chọn ảnh
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: _imageFile == null
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo, color: Colors.grey, size: 40),
                          SizedBox(height: 8),
                          Text(
                            "Upload ảnh",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _imageFile!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
