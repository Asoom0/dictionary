import 'package:flutter/material.dart';
import '../../core/color.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color backgroundColor;
  final bool isItalic;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.backgroundColor,
    this.isItalic = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: MyColor.lightBlue,
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.cairo(
                fontWeight: FontWeight.w700,
                fontSize: 18),),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.cairo(
              fontSize: 16,

            ),
          ),
        ],
      ),
    );
  }
}