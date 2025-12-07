import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class TargetAudienceSection extends StatelessWidget {
  const TargetAudienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          // 1. HEADLINE
          const Text(
            "Built for every stage",
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
            "Create AI agents and automations tailored to run your business.\nCollaborate with teams or clients and plan campaigns together.",
            style: TextStyle(
              fontSize: 18,
              color: AppColors.textBody,
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
                title: "For Startups",
                description: "Centralized planning across multiple channels using CissyTech automations.",
                image: "https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?w=500&q=80", // Planner/Checklist vibe
              ),
              _buildAudienceCard(
                title: "For Enterprises",
                description: "Content creation powered by AI, brand kits and customizable templates.",
                image: "https://images.unsplash.com/photo-1542744173-8e7e53415bb0?w=500&q=80", // Analytics/Dashboard vibe
              ),
              _buildAudienceCard(
                title: "For Teams",
                description: "Comprehensive team management and approval flows with member roles.",
                image: "https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=500&q=80", // Team collaboration vibe
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method for the cards
  Widget _buildAudienceCard({required String title, required String description, required String image}) {
    return Container(
      width: 350,
      height: 480, // Same height as previous section for consistency
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB), // Light grey
        borderRadius: BorderRadius.circular(24),
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
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 16),
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

          // The "Floating" Image Mockup
          Container(
            height: 180, 
            width: double.infinity,
            // These margins create the "Floating" effect inside the card
            margin: const EdgeInsets.fromLTRB(32, 0, 32, 32), 
            decoration: BoxDecoration(
              color: Colors.white,
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
            // Optional: Add an inner overlay to make it look more like a UI
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}