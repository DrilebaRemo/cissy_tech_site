import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // 1. Import Animate
import '../../../core/theme/app_colors.dart';

class AgentsSection extends StatelessWidget {
  const AgentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Capture Dynamic Colors
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;


    return Container(
      width: double.infinity,
      color: bgColor, 
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          // 1. HEADLINE (Animated)
          Text(
            "CissyTech Solutions ready to go.",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w800,
              color: textColor,
              letterSpacing: -1.5,
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ).animate() // Entrance
           .fade(duration: 600.ms)
           .slideY(begin: 0.2, end: 0),
          
          const SizedBox(height: 16),

          // 2. SUBTITLE (Animated)
          Text(
            "Templates designed to automate your workflow, manage data, \nand boost engagement. Or build your own custom solution!",
            style: TextStyle(
              fontSize: 18,
              color: bodyColor,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ).animate() // Entrance
           .fade(delay: 200.ms, duration: 600.ms)
           .slideY(begin: 0.2, end: 0),

          const SizedBox(height: 60),

          // 3. THE CARDS (Swapped to Stateful Widget for Hover Animation)
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _HoverFeatureCard(
                title: "Social Poster",
                description: "Multi-channel posting with automatic post creation.",
                image: "https://images.unsplash.com/photo-1611162617474-5b21e879e113?w=500&q=80",
                entranceDelay: 300,
              ),
              _HoverFeatureCard(
                title: "DM Chatbot",
                description: "Smart replies and support through DMs via chatbots.",
                image: "https://images.unsplash.com/photo-1531482615713-2afd69097998?w=500&q=80",
                entranceDelay: 500, // Staggered
              ),
              _HoverFeatureCard(
                title: "Comment-to-DM",
                description: "Keyword-based link promotions for discounts or courses.",
                image: "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=500&q=80",
                entranceDelay: 700, // Staggered
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- NEW STATEFUL WIDGET FOR ANIMATION ---
class _HoverFeatureCard extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final int entranceDelay;

  const _HoverFeatureCard({
    required this.title,
    required this.description,
    required this.image,
    this.entranceDelay = 0,
  });

  @override
  State<_HoverFeatureCard> createState() => _HoverFeatureCardState();
}

class _HoverFeatureCardState extends State<_HoverFeatureCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Capture colors inside the widget (Exact same logic as before)
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final borderColor = Theme.of(context).dividerColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: 350,
        height: 480,
        // 1. LIFT ANIMATION
        transform: isHovered ? Matrix4.translationValues(0, -10, 0) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: cardColor, 
          borderRadius: BorderRadius.circular(24),
          // 2. GLOW/SHADOW ANIMATION
          boxShadow: isHovered 
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.15), // Glow on hover
                  blurRadius: 30, 
                  offset: const Offset(0, 20)
                )
              ]
            : [
                // Inherited Shadow logic from your code
                // Note: I removed the static shadow to keep it clean, or we can add it back lightly
                BoxShadow(color: Colors.black.withOpacity(0.0), blurRadius: 0), 
              ],
          // 3. BORDER ANIMATION (Highlight on hover, Divider color on normal)
          border: isHovered 
            ? Border.all(color: AppColors.primary.withOpacity(0.5), width: 1)
            : Border.all(color: borderColor), 
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
              child: Column(
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: bodyColor,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // 4. LINK SLIDE ANIMATION
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.only(left: isHovered ? 8 : 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "See pricing",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.chevron_right, size: 16, color: bodyColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // 5. IMAGE SCALE ANIMATION
            AnimatedScale(
              scale: isHovered ? 1.05 : 1.0, // Slight zoom
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              child: Container(
                height: 180, 
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(24, 0, 24, 24), 
                decoration: BoxDecoration(
                  color: isDark ? Colors.black : Colors.white, 
                  borderRadius: BorderRadius.circular(16), 
                  border: Border.all(color: borderColor),
                  boxShadow: [
                     BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter, 
                  ),
                ),
              ),
            ),
          ],
        ),
      ).animate() // 6. STAGGERED ENTRANCE
       .fade(delay: Duration(milliseconds: widget.entranceDelay), duration: 600.ms)
       .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
    );
  }
}