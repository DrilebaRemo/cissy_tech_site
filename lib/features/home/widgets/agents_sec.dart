import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fade_in_scroll.dart';

class AgentsSection extends StatelessWidget {
  const AgentsSection({super.key});

  static const List<Map<String, dynamic>> _features = [
    {
      "titleImage": "assets/images/collecto_logo2.png",
      "desc": "A secure SaaS platform integrating business management, value-added services, and digital payments.",
      "image": "assets/images/im1.png",
      "delay": 100,
    },
    {
      "titleImage": "assets/images/eworker.png",
      "desc": "An enterprise workforce platform optimized for casual and large-scale labor environments using biometrics to automate payroll and attendance tracking.",
      "image": "assets/images/biometric.webp",
      "delay": 200,
    },
    {
      "titleImage": "assets/images/bulk_logo.png",
      "desc": "Allow us to handle your bulk payments saving you time and resources you would take doing manual transfers.",
      "image": "assets/images/money1.gif",
      "delay": 300,
    },
     {
      "titleImage": "assets/images/cissy_cloud.png",
      "desc": "A suite of AI-powered tools for Business, Education, Leisure, and Commerce, built for emerging markets.",
      "image": "assets/images/cloud3.gif",
      "delay": 400,
    },
     {
      "titleImage": "assets/images/cissydrive.png", 
      "desc": "A scalable multivendor commerce platform enabling enterprises and institutions to operate and grow digital marketplaces.",
      "image": "assets/images/drive3.gif",
      "delay": 500,
    },
    {
      "titleImage": "assets/images/cissydrive.png", 
      "desc": "An enterprise property and asset management system designed to support landlords, real estate firms, and asset managers operating across multiple markets.",
      "image": "assets/images/drive3.gif",
      "delay": 600,
    },
  ];

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
          FadeInScroll(
            child: Text(
              "Enterprise Platforms.",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w800,
                color: textColor,
                letterSpacing: -1.5,
                fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          const SizedBox(height: 16),

          // 2. SUBTITLE (Animated)
          FadeInScroll(
            delay: const Duration(milliseconds: 200),
            child: Text(
              "Tailored modules designed to automate workflows, \nmanage cash flow, and boost engagement.",
              style: TextStyle(
                fontSize: 18,
                color: bodyColor,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 60),

          // 3. THE CARDS (Swapped to Stateful Widget for Hover Animation)
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: _features.map((feature) => _HoverFeatureCard(
              titleImage: feature["titleImage"],
              description: feature["desc"],
              image: feature["image"],
              entranceDelay: feature["delay"],
            )).toList(),
          ),
        ],
      ),
    );
  }
}

// --- NEW STATEFUL WIDGET FOR ANIMATION ---
class _HoverFeatureCard extends StatefulWidget {
  final String titleImage;
  final String description;
  final String image;
  final int entranceDelay;

  const _HoverFeatureCard({
    required this.titleImage,
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

    return FadeInScroll(
      delay: Duration(milliseconds: widget.entranceDelay),
      child: MouseRegion(
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
                  Image.asset(widget.titleImage, height: 40),
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
                height: 240, 
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
                     image: widget.image.startsWith('http') 
                        ? NetworkImage(widget.image)
                        : AssetImage(widget.image) as ImageProvider,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter, 
                  ),
                ),
              ),
            ),
          ],
        ), // Column
      ), // AnimatedContainer
    ), // MouseRegion
    ); // FadeInScroll
  }
}