import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Capture Theme Colors
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.displayLarge?.color; // Titles
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;    // Paragraphs
    final bgColor = Theme.of(context).scaffoldBackgroundColor;         // Background
    final dividerColor = Theme.of(context).dividerColor;

    return Container(
      color: bgColor, // Dynamic Background
      padding: const EdgeInsets.only(top: 80, bottom: 40, left: 40, right: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // --- TOP SECTION (Links & Logo) ---
              Wrap(
                spacing: 40,
                runSpacing: 40,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  // COLUMN 1: Brand & Socials
                  SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Logo & Brand Name
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/logo.png', // Ensure filename matches exactly
                              height: 32,
                              // OPTIONAL: This tints the logo white in dark mode if it's a transparent PNG
                              // Remove this line if your logo has specific brand colors you want to keep
                              color: textColor, 
                              errorBuilder: (c, o, s) => Icon(Icons.layers, size: 32, color: textColor),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "CissyTech",
                              style: TextStyle(
                                fontSize: 24, 
                                fontWeight: FontWeight.bold,
                                color: textColor, // Dynamic Color
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Social media management. Using AI.",
                          style: TextStyle(color: bodyColor, fontSize: 16), // Dynamic Color
                        ),
                        const SizedBox(height: 24),
                        // Social Icons
                        Row(
                          children: const [
                            _SocialIcon(Icons.facebook),
                            _SocialIcon(Icons.camera_alt),
                            _SocialIcon(Icons.close),
                            _SocialIcon(Icons.business),
                            _SocialIcon(Icons.music_note),
                            _SocialIcon(Icons.play_circle),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // COLUMN 2: Links
                  const _FooterColumn(
                    title: "Links",
                    links: ["Pricing", "Integrations", "Features", "Login"],
                  ),

                  // COLUMN 3: Support
                  const _FooterColumn(
                    title: "Support",
                    links: ["Help Center", "Service status", "Terms of service", "Privacy policy", "Cookie policy", "GDPR"],
                  ),

                  // COLUMN 4: Resources
                  const _FooterColumn(
                    title: "Resources",
                    links: ["Blog", "Affiliates", "Roadmap"],
                  ),

                  // COLUMN 5: Community
                  SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Community", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor)),
                        const SizedBox(height: 20),
                        Text(
                          "Join our community to learn how to use all of our tools faster and better.",
                          style: TextStyle(color: bodyColor, fontSize: 15, height: 1.5),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            // In Dark mode, make button White text on Primary Color
                            // In Light mode, make button White text on Dark Grey (Ocoya style)
                            backgroundColor: isDark ? AppColors.primary : const Color(0xFF1F2937),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("Join Community Group"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 80),
              
              // --- DIVIDER ---
              Divider(color: dividerColor),
              
              const SizedBox(height: 30),

              // --- BOTTOM SECTION (Copyright) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "© Copyright CissyTech Ltd. All Rights Reserved.",
                    style: TextStyle(color: bodyColor?.withOpacity(0.7), fontSize: 14),
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

// --- HELPER WIDGETS ---

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> links;

  const _FooterColumn({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    // Access Theme Data inside the helper
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;

    return SizedBox(
      width: 140, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor)),
          const SizedBox(height: 20),
          ...links.map((link) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                link,
                style: TextStyle(color: bodyColor, fontSize: 15),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  const _SocialIcon(this.icon);

  @override
  Widget build(BuildContext context) {
    // Icon color adapts to theme (Black in Light Mode, White in Dark Mode)
    final iconColor = Theme.of(context).iconTheme.color;

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Icon(icon, size: 24, color: iconColor),
    );
  }
}