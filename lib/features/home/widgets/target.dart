import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Import Animate
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fade_in_scroll.dart';

class TargetAudienceSection extends StatelessWidget {
  const TargetAudienceSection({super.key});

  static const List<Map<String, dynamic>> _audiences = [
    {
      "title": "Custom Software Development",
      "desc": "We design and deiver custom enterprise sofftware from web platforms to mobile apps supported by secure hosting services.",
      "image": "assets/images/web.gif",
      "delay": 100,
    },
    {
      "title": "ICT Infrastructure & Managed Services",
      "desc": "Management of ICT and utility infrastructure including surveillance,biometric systems and enterprise hardware.",
      "image": "assets/images/sofware.gif",
      "delay": 200,
    },
    {
      "title": "Brand Strategy & Corporate Communications",
      "desc": ".",
      "image": "assets/images/email.gif",
      "delay": 300,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // 1. Capture Theme Colors
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          FadeInScroll(
            child: Text(
              "Professional & ManagedServices",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w800,
                color: textColor,
                letterSpacing: -1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          const SizedBox(height: 16),

          // 2. SUBTITLE (Animated)
          FadeInScroll(
            delay: const Duration(milliseconds: 100),
            child: Text(
              "We also offer a variety of didgital services that help you run business online.",
              style: TextStyle(
                fontSize: 18,
                color: bodyColor, // <--- Dynamic Text
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 60),

          // 3. THE CARDS
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: _audiences.map((item){ 
              return _HoverTargetCard(
                title: item["title"],
                description: item["desc"],
                image: item["image"],
                delay: item["delay"],
              );
            }).toList(),
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

    return FadeInScroll(
      delay: Duration(milliseconds: widget.delay),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: 400,
          height: 500, 
          // 1. LIFT ANIMATION
          transform: isHovered ? Matrix4.translationValues(0, -10, 0) : Matrix4.identity(),
          decoration: BoxDecoration(
            color: cardColor, // <--- Dynamic Card Background
            borderRadius: BorderRadius.circular(24),
            border: isHovered 
                ? Border.all(color: AppColors.primary.withOpacity(0.5), width: 1) 
                : Border.all(color: borderColor),
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
                  ],
                ),
              ),

              const Spacer(),

              AnimatedScale(
                scale: isHovered ? 1.05 : 1.0, 
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                child: Container(
                  height: 240, 
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
                      image: widget.image.startsWith('http') 
                        ? NetworkImage(widget.image)
                        : AssetImage(widget.image) as ImageProvider,
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
        ),
      ),
    );
  }
}