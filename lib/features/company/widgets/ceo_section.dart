import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fade_in_scroll.dart';

class CeoSection extends StatelessWidget {
  const CeoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    
    // Subtle background distinction (Google uses F8F9FA for light mode sections)
    final sectionBg = isDark ? const Color(0xFF15171E) : const Color(0xFFF8F9FA);

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

              // The Content Widgets
              final textContent = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInScroll(
                    child: Text(
                      "“We are building the digital infrastructure that empowers businesses to compete globally. Technology should be the bridge, not the barrier.”",
                      style: TextStyle(
                        fontSize: isMobile ? 24 : 32, // Large, editorial font size
                        height: 1.4,
                        fontWeight: FontWeight.w400, // Regular weight looks more elegant
                        color: textColor,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  FadeInScroll(
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      "James Carter, CEO of CissyTech",
                      style: TextStyle(
                        fontSize: 18,
                        color: bodyColor,
                        fontWeight: FontWeight.w500,
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)), // Pill shape
                        elevation: 0, // Flat button like Google
                      ),
                      child: const Text(
                        "Read more from our CEO",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              );

              final imageContent = FadeInScroll(
                delay: const Duration(milliseconds: 200),
                slideOffset: const Offset(0.1, 0), // Slide in from right
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1556761175-5973dc0f32e7?w=1000&q=80", // Professional presentation shot
                    fit: BoxFit.cover,
                    height: isMobile ? 300 : 500,
                    width: double.infinity,
                  ),
                ),
              );

              // Responsive Layout Logic
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
                    Expanded(flex: 5, child: textContent),
                    const SizedBox(width: 60), // Breathing room
                    Expanded(flex: 6, child: imageContent),
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