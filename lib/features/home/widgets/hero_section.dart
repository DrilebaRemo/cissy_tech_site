import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'infinite_scroll.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine screen width to adjust layout (Basic responsiveness)
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.fromLTRB(60, 140, 60, 80),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- LEFT COLUMN (Text & Actions) ---
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Headline
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 64, // Big Headline
                      height: 1.1,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textMain,
                      letterSpacing: -2.0,
                      fontFamily: 'Inter', // Ensure Inter is in pubspec
                    ),
                    children: [
                      TextSpan(text: "Software that\n"),
                      TextSpan(
                        text: "means business.",
                        style: TextStyle(color: AppColors.primary), // Cissy Blue
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // 2. Subtitle
                const Text(
                  "Don't hire an expensive agency. Automate your workflow, host securely, and manage your team with CissyTech's all-in-one ecosystem.",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.textBody,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 60),

                // 4. Trusted By (Logos)
                Row(
                  children: [
                    const _HoverAvatar(imagePath: 'assets/images/bulk_sms.png'),
                    const _HoverAvatar(imagePath: 'assets/images/cissy_cloud.png'),
                    const _HoverAvatar(imagePath: 'assets/images/collecto.png'),
                    const _HoverAvatar(imagePath: 'assets/images/eworker.png'),
                    const SizedBox(width: 20),
                    const Text(
                      "Trusted by 500+ companies\nin Uganda",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBody,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 60),

         Expanded(
            flex: 6,
            child: SizedBox(
              height: 700,
              // CENTER + WIDTH CONSTRAINT: This makes the cards look like a sleek mobile feed
              child: Center(
                child: SizedBox(
                  width: 420, // <--- This restricts the width (Makes them smaller)
                  child: InfiniteScrollColumn(
                    speed: 0.8,
                    children: [
                      // CARD 1
                      _buildTestimonialCard(
                        name: "Benjamin Austin",
                        role: "Account Executive, Uber Eats",
                        avatarUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&q=80",
                        text: "The AI-driven workflows do a solid job and saves an incredible amount of time.",
                      ),

                      // CARD 2
                      _buildImageCard(
                        "https://images.unsplash.com/photo-1556761175-5973dc0f32e7?w=800&q=80",
                      ),

                      // CARD 3
                      _buildTestimonialCard(
                        name: "Sarah Jenkins",
                        role: "Marketing Director, Netflix",
                        avatarUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80",
                        text: "CissyTech transformed how we handle our server deployment. It's simply seamless.",
                      ),

                      // CARD 4
                      _buildImageCard(
                        "https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&q=80",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPER 1: TESTIMONIAL CARD (Smaller Text) ---
  Widget _buildTestimonialCard({
    required String name,
    required String role,
    required String avatarUrl,
    required String text,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24), // Reduced padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24, // Smaller Avatar
                backgroundImage: NetworkImage(avatarUrl),
              ),
              const SizedBox(width: 14),
              Expanded( // Prevents text overflow
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      role,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.textBody, fontSize: 13),
                    ),
                  ],
                ),
              ),
              // Stars
              const Row(
                children: [
                  Icon(Icons.star_rounded, color: AppColors.accent, size: 20),
                  Icon(Icons.star_rounded, color: AppColors.accent, size: 20),
                  Icon(Icons.star_rounded, color: AppColors.accent, size: 20),
                  Icon(Icons.star_rounded, color: AppColors.accent, size: 20),
                  Icon(Icons.star_rounded, color: AppColors.accent, size: 20),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            text,
            style: const TextStyle(
              fontSize: 15, // Smaller body text
              height: 1.5,
              color: AppColors.textBody,
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPER 2: IMAGE CARD (Smaller Height) ---
  Widget _buildImageCard(String imageUrl) {
    return Container(
      width: double.infinity,
      height: 260, // Reduced height to fit better with the width
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
    );
  }
  // Helper for the circular logos
  Widget _circleLogo(Color color) {
    return Align(
      widthFactor: 0.7, // This tells Flutter: "Only take up 70% of the space", causing the next item to overlap.
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
        ),
      ),
    );
  }
}
class _HoverAvatar extends StatefulWidget {
  final String imagePath;
  const _HoverAvatar({required this.imagePath});

  @override
  State<_HoverAvatar> createState() => _HoverAvatarState();
}

class _HoverAvatarState extends State<_HoverAvatar> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      widthFactor: 0.7, // Keeps them overlapped
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true), // Mouse goes in
        onExit: (_) => setState(() => isHovered = false), // Mouse leaves
        child: AnimatedScale(
          scale: isHovered ? 1.2 : 1.0, // Scale up to 120%
          duration: const Duration(milliseconds: 200), // Smooth 0.2s animation
          curve: Curves.easeOutBack, // Bouncy effect
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white, // Background in case image has transparency
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3), // White border
              boxShadow: [
                if (isHovered) // Only show shadow when hovered for "Pop" effect
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
              ],
            ),
            // The Image
            child: ClipOval(
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover, // Fill the circle
                // If asset not found, show a grey fallback
                errorBuilder: (c, o, s) => Container(color: Colors.grey.shade300),
              ),
            ),
          ),
        ),
      ),
    );
  }
}