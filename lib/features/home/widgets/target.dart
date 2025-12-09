import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Import Animate
import '../../../core/theme/app_colors.dart';

class TargetAudienceSection extends StatelessWidget {
  const TargetAudienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Capture Theme Colors
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Container(
      color: bgColor, // <--- Dynamic Background
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          // 1. HEADLINE (Animated)
          Text(
            "Built for every stage",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w800,
              color: textColor, // <--- Dynamic Text
              letterSpacing: -1.5,
            ),
            textAlign: TextAlign.center,
          ).animate()
           .scale(duration: 600.ms, curve: Curves.easeOutBack, begin: const Offset(0.9, 0.9)) // Pop
           .fade(duration: 600.ms),
          
          const SizedBox(height: 16),

          // 2. SUBTITLE (Animated)
          Text(
            "Create AI agents and automations tailored to run your business.\nCollaborate with teams or clients and plan campaigns together.",
            style: TextStyle(
              fontSize: 18,
              color: bodyColor, // <--- Dynamic Text
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ).animate()
           .scale(delay: 200.ms, duration: 600.ms, curve: Curves.easeOutBack, begin: const Offset(0.9, 0.9))
           .fade(delay: 200.ms, duration: 600.ms),

          const SizedBox(height: 60),

          // 3. THE CARDS
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _HoverTargetCard(
                title: "For Startups",
                description: "Centralized planning across multiple channels using CissyTech automations.",
                image: "https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?w=500&q=80",
                delay: 0,
              ),
              _HoverTargetCard(
                title: "For Enterprises",
                description: "Content creation powered by AI, brand kits and customizable templates.",
                image: "https://images.unsplash.com/photo-1542744173-8e7e53415bb0?w=500&q=80",
                delay: 100,
              ),
              _HoverTargetCard(
                title: "For Teams",
                description: "Comprehensive team management and approval flows with member roles.",
                image: "https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=500&q=80",
                delay: 200,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- NEW ANIMATED CARD WIDGET ---
class _HoverTargetCard extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final int delay;

  const _HoverTargetCard({
    required this.title,
    required this.description,
    required this.image,
    this.delay = 0,
  });

  @override
  State<_HoverTargetCard> createState() => _HoverTargetCardState();
}

class _HoverTargetCardState extends State<_HoverTargetCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Capture colors for the card context (Exact logic from your code)
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final borderColor = Theme.of(context).dividerColor;
    
    // For the inner mockup: White in light mode, Black in dark mode
    final innerMockupColor = Theme.of(context).brightness == Brightness.dark 
        ? Colors.black 
        : Colors.white;

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
          color: cardColor, // <--- Dynamic Card Background
          borderRadius: BorderRadius.circular(24),
          // 2. BORDER ANIMATION
          border: isHovered 
              ? Border.all(color: AppColors.primary.withOpacity(0.5), width: 1) 
              : Border.all(color: borderColor),
          // 3. GLOW/SHADOW ANIMATION
          boxShadow: isHovered 
              ? [BoxShadow(color: AppColors.primary.withOpacity(0.15), blurRadius: 30, offset: const Offset(0, 20))]
              : [],
        ),
        child: Column(
          children: [
            // Text Content
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 40, 32, 0),
              child: Column(
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor, // <--- Dynamic Text
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: bodyColor, // <--- Dynamic Text
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Animated "See pricing" Link
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
                            color: textColor, // <--- Dynamic Text
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.chevron_right, size: 16, color: bodyColor?.withOpacity(0.7)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            AnimatedScale(
              scale: isHovered ? 1.05 : 1.0, 
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              child: Container(
                height: 180, 
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(32, 0, 32, 32), 
                decoration: BoxDecoration(
                  color: innerMockupColor, 
                  borderRadius: BorderRadius.circular(16),
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
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor), // <--- Dynamic Inner Border
                  ),
                ),
              ),
            ),
          ],
        ),
      ).animate()
       .scale(
         delay: Duration(milliseconds: widget.delay), 
         duration: 800.ms, 
         curve: Curves.easeOutBack,
         begin: const Offset(0.8, 0.8),
         end: const Offset(1, 1)
       )
       .fade(delay: Duration(milliseconds: widget.delay), duration: 600.ms),
    );
  }
}