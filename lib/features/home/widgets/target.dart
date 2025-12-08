import 'package:flutter/material.dart';
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
          // 1. HEADLINE
          Text(
            "Built for every stage",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w800,
              color: textColor, // <--- Dynamic Text
              letterSpacing: -1.5,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),

          // 2. SUBTITLE
          Text(
            "Create AI agents and automations tailored to run your business.\nCollaborate with teams or clients and plan campaigns together.",
            style: TextStyle(
              fontSize: 18,
              color: bodyColor, // <--- Dynamic Text
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 60),

          // 3. THE CARDS
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _buildAudienceCard(
                context,
                title: "For Startups",
                description: "Centralized planning across multiple channels using CissyTech automations.",
                image: "https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?w=500&q=80", 
              ),
              _buildAudienceCard(
                context,
                title: "For Enterprises",
                description: "Content creation powered by AI, brand kits and customizable templates.",
                image: "https://images.unsplash.com/photo-1542744173-8e7e53415bb0?w=500&q=80", 
              ),
              _buildAudienceCard(
                context,
                title: "For Teams",
                description: "Comprehensive team management and approval flows with member roles.",
                image: "https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=500&q=80", 
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method for the cards
  Widget _buildAudienceCard(BuildContext context, {required String title, required String description, required String image}) {
    // Capture colors for the card context
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final borderColor = Theme.of(context).dividerColor;
    // For the inner mockup: White in light mode, Black in dark mode
    final innerMockupColor = Theme.of(context).brightness == Brightness.dark 
        ? Colors.black 
        : Colors.white;

    return Container(
      width: 350,
      height: 480, 
      decoration: BoxDecoration(
        color: cardColor, // <--- Dynamic Card Background
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor), // <--- Dynamic Border (Subtle)
      ),
      child: Column(
        children: [
          // Text Content
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 40, 32, 0),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor, // <--- Dynamic Text
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: bodyColor, // <--- Dynamic Text
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                
                // "See pricing" Link
                Row(
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
              ],
            ),
          ),

          const Spacer(),

          // The "Floating" Image Mockup
          Container(
            height: 180, 
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(32, 0, 32, 32), 
            decoration: BoxDecoration(
              color: innerMockupColor, // <--- Dynamic Inner Background
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                 BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(image),
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
        ],
      ),
    );
  }
}