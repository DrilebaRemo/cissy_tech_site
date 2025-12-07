import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class AgentsSection extends StatelessWidget {
  const AgentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          const Text(
            "CissyTech Solutions ready to go.", // Adapted for your brand
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              letterSpacing: -1.5,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),

          // 2. SUBTITLE
          const Text(
            "Templates designed to automate your workflow, manage data, \nand boost engagement. Or build your own custom solution!",
            style: TextStyle(
              fontSize: 18,
              color: AppColors.textBody,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 60),

          // 3. THE CARDS
          // We use Wrap so if the screen is too small, they stack automatically
          Wrap(
            spacing: 24, // Gap between cards horizontally
            runSpacing: 24, // Gap between cards vertically
            alignment: WrapAlignment.center,
            children: [
              _buildCard(
                title: "Social Poster",
                description: "Multi-channel posting with automatic post creation.",
                image: "https://images.unsplash.com/photo-1611162617474-5b21e879e113?w=500&q=80", // Social media placeholder
              ),
              _buildCard(
                title: "DM Chatbot",
                description: "Smart replies and support through DMs via chatbots.",
                image: "https://images.unsplash.com/photo-1531482615713-2afd69097998?w=500&q=80", // Chat placeholder
              ),
              _buildCard(
                title: "Comment-to-DM",
                description: "Keyword-based link promotions for discounts or courses.",
                image: "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=500&q=80", // Mobile notification placeholder
              ),
            ],
          ),
        ],
      ),
    );
  }

  // A helper method to build the individual cards
  Widget _buildCard({required String title, required String description, required String image}) {
    return Container(
      width: 350, // Fixed width for desktop consistency
      height: 480,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB), // Very light grey (almost white)
        borderRadius: BorderRadius.circular(24),
        // No border, just subtle background color contrast
      ),
      child: Column(
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 32,0),
            child:Column(
              children: [
                Text(
                    title,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: -0.5,
                    ),
                ),
                const SizedBox(height: 12),
          
          // Description
                Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                color: AppColors.textBody,
                fontSize: 16,
                height: 1.5,
                ),
            ),
            const SizedBox(height: 24),
          
          // "See pricing" Link
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const Text(
                    "See pricing",
                    style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.chevron_right, size: 16, color: Colors.black.withOpacity(0.7)),
                ],
            ),
        ],
    ),
),


          const Spacer(),

          // Bottom Image (Mockup)
          Container(
            height: 180,
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            decoration: BoxDecoration(
                color: Colors.white,
              borderRadius:  BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
              boxShadow: [
                 BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}