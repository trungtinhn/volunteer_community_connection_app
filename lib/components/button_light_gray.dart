import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';

class ButtonLightGray extends StatelessWidget {
  final String des;
  final VoidCallback onPress;
  final bool? isLoading;
  const ButtonLightGray(
      {super.key, required this.des, required this.onPress, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: MediaQuery.sizeOf(context).width - 40,
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: ShapeDecoration(
          color: AppColors.lightGray,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Center(
          child: isLoading != null && isLoading == true
              ? const CircularProgressIndicator(
                  color: AppColors.white,
                )
              : Text(
                  des,
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
        ),
      ),
    );
  }
}
