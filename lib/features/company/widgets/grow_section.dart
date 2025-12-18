import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fade_in_scroll.dart';

class GrowSection extends StatelessWidget {
  const GrowSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    
    // Clean white/black background to contrast with the colorful section above
    final sectionBg = isDark ? Colors.black : Colors.white;

    return Container(
      width: double.infinity,
      color: sectionBg,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 900;

              // The Text Content
              final textContent = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInScroll(
                    child: Text(
                      "Grow with CissyTech",
                      style: TextStyle(
                        fontSize: isMobile ? 32 : 48,
                        fontWeight: FontWeight.w500, // Google-style medium weight
                        color: textColor,
                        letterSpacing: -1.0,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FadeInScroll(
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      "Find specialized training and resources to help you upskill your staff, improve digital literacy, and ensure teams are proficient with the latest technologies.",
                      style: TextStyle(
                        fontSize: 18,
                        color: bodyColor,
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  FadeInScroll(
                    delay: const Duration(milliseconds: 200),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary, // Cissy Blue
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)), // Pill
                        elevation: 0,
                      ),
                      child: const Text(
                        "Get started",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              );

              // The Image Content
              final imageContent = FadeInScroll(
                delay: const Duration(milliseconds: 200),
                slideOffset: const Offset(-0.1, 0), // Slide in from Left
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24), // Google-style rounding
                  child: Image.network(
                    "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=800&q=80", // Professional learning/tech shot
                    fit: BoxFit.cover,
                    height: isMobile ? 300 : 450,
                    width: double.infinity,
                  ),
                ),
              );

              // Responsive Layout
              if (isMobile) {
                return Column(
                  children: [
                    imageContent,
                    const SizedBox(height: 40),
                    textContent,
                  ],
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image Left (Flex 5)
                    Expanded(flex: 5, child: imageContent),
                    const SizedBox(width: 80), // Generous whitespace
                    // Text Right (Flex 5)
                    Expanded(flex: 5, child: textContent),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}