import 'package:akkhara_tracker/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TinySubTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color color;
  const TinySubTile(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kindaBlack,
        borderRadius: BorderRadius.circular(15),
        border: Border(
          top: BorderSide(
            color: color,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
              color: Colors.grey,
            ),
          ),
          Text(
            subTitle,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
