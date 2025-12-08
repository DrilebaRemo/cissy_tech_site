import 'package:flutter/material.dart';
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
      color: bgColor, // <--- CHANGED: Dynamic Background
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          // 1. HEADLINE
          Text(
            "CissyTech Solutions ready to go.",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w800,
              color: textColor, // <--- CHANGED: Dynamic Text
              letterSpacing: -1.5,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),

          // 2. SUBTITLE
          Text(
            "Templates designed to automate your workflow, manage data, \nand boost engagement. Or build your own custom solution!",
            style: TextStyle(
              fontSize: 18,
              color: bodyColor, // <--- CHANGED: Dynamic Text
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
              _buildCard(
                context, // Pass context
                title: "Social Poster",
                description: "Multi-channel posting with automatic post creation.",
                image: "https://images.unsplash.com/photo-1611162617474-5b21e879e113?w=500&q=80", 
              ),
              _buildCard(
                context, // Pass context
                title: "DM Chatbot",
                description: "Smart replies and support through DMs via chatbots.",
                image: "https://images.unsplash.com/photo-1531482615713-2afd69097998?w=500&q=80", 
              ),
              _buildCard(
                context, // Pass context
                title: "Comment-to-DM",
                description: "Keyword-based link promotions for discounts or courses.",
                image: "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=500&q=80", 
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required String title, required String description, required String image}) {
    // Capture colors inside the widget
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final borderColor = Theme.of(context).dividerColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 350,
      height: 480, 
      decoration: BoxDecoration(
        color: cardColor, // <--- CHANGED: Dynamic Card Background
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor), // <--- Added Border for definition
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor, // <--- CHANGED: Dynamic Text
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: bodyColor, // <--- CHANGED: Dynamic Text
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "See pricing",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: textColor, // <--- CHANGED
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.chevron_right, size: 16, color: bodyColor),
                  ],
                ),
              ],
            ),
          ),

          const Spacer(),

          // The Image Container
          Container(
            height: 180, 
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(24, 0, 24, 24), 
            decoration: BoxDecoration(
              // In Dark Mode, make the inner box Black. In Light Mode, make it White.
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
                image: NetworkImage(image),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter, 
              ),
            ),
          ),
        ],
      ),
    );
  }
}