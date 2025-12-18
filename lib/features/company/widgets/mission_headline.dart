import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fade_in_scroll.dart';

class MissionHeadline extends StatelessWidget {
  const MissionHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive Font Size
    final double screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = screenWidth < 800 ? 40 : 80;
    
    final textColor = Theme.of(context).textTheme.displayLarge?.color;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: FadeInScroll(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Inter', // Or Google Sans if you have it
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500, // Google uses Medium/Regular weight for headings
                  height: 1.1,
                  letterSpacing: -1.5,
                  color: textColor,
                ),
                children: const [
                  TextSpan(text: "Our mission is to "),
                  TextSpan(
                    text: "power progress",
                    style: TextStyle(color: AppColors.primary), // Cissy Blue
                  ),
                  TextSpan(text: " for innovators by delivering "),
                  TextSpan(
                    text: "custom digital solutions",
                    style: TextStyle(color: Colors.purpleAccent), // Accent color 1
                  ),
                  TextSpan(text: " that unlock potential, enhance efficiency "),
                  TextSpan(
                    text: "and drive",
                    style: TextStyle(color: Colors.green), // Accent color 2
                  ),
                  TextSpan(text: " meaningful "),
                  TextSpan(
                    text: "growth.",
                    style: TextStyle(color: AppColors.accent), // Cissy Orange
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}