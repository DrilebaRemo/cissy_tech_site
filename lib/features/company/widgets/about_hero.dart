import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fade_in_scroll.dart';

class AboutHero extends StatelessWidget {
  const AboutHero({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Container(
      width: double.infinity,
      // Top padding accounts for the navbar height
      padding: const EdgeInsets.fromLTRB(20, 180, 20, 80),
      child: Column(
        children: [
          FadeInScroll(
            child: Text(
              "Driving the Future with CissyTech",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w800,
                color: textColor,
                letterSpacing: -1.5,
                fontFamily: 'Inter',
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          FadeInScroll(
            delay: const Duration(milliseconds: 100),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Text(
                "Innovating for Tomorrow. To build a world where technology simplifies life and empowers businesses to reach their full potential.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: bodyColor,
                  height: 1.6,
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          FadeInScroll(
            delay: const Duration(milliseconds: 200),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
              child: const Text("Start Your Journey", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}