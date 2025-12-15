import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/layout/responsive.dart';
import '../../../shared/widgets/fade_in_scroll.dart';

class VisionMissionSection extends StatelessWidget {
  const VisionMissionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInScroll(
                child: Text(
                  "Our Vision & Mission",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.displayLarge?.color,
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              FadeInScroll(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  "Guided by innovation and integrity, we strive to make a lasting impact.",
                  style: TextStyle(
                    fontSize: 18, 
                    color: Theme.of(context).textTheme.bodyLarge?.color
                  ),
                ),
              ),

              const SizedBox(height: 50),

              if (isMobile)
                Column(
                  children: const [
                    _InfoCard(
                      title: "Our Vision",
                      desc: "To build a world where technology simplifies life, making the complex simple and accessible for everyone, everywhere.",
                      icon: Icons.visibility_outlined,
                    ),
                    SizedBox(height: 24),
                    _InfoCard(
                      title: "Our Mission",
                      desc: "To power progress for innovators by delivering custom digital solutions that unlock potential, enhance efficiency and drive meaningful growth.",
                      icon: Icons.track_changes_outlined,
                    ),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: _InfoCard(
                        title: "Our Vision",
                        desc: "To build a world where technology simplifies life, making the complex simple and accessible for everyone, everywhere.",
                        icon: Icons.visibility_outlined,
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: _InfoCard(
                        title: "Our Mission",
                        desc: "To build a world where technology simplifies life, making the complex simple and accessible for everyone, everywhere.",
                        icon: Icons.track_changes_outlined,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String desc;
  final IconData icon;

  const _InfoCard({required this.title, required this.desc, required this.icon});

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;
    final borderColor = Theme.of(context).dividerColor;

    return FadeInScroll(
      delay: const Duration(milliseconds: 200),
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10)
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 30),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.displayLarge?.color,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              desc,
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}