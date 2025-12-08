import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 80, bottom: 40, left: 40, right: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // --- TOP SECTION (Links & Logo) ---
              // We use Wrap so it automatically stacks on smaller screens
              Wrap(
                spacing: 40, // Horizontal gap
                runSpacing: 40, // Vertical gap when wrapped
                alignment: WrapAlignment.spaceBetween,
                children: [
                  // COLUMN 1: Brand & Socials
                  SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Logo (Reusing your asset)
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/cissy_logo.png',
                              height: 32,
                              errorBuilder: (c, o, s) => const Icon(Icons.layers, size: 32),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "CissyTech",
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Social media management. Using AI.",
                          style: TextStyle(color: AppColors.textBody, fontSize: 16),
                        ),
                        const SizedBox(height: 24),
                        // Social Icons
                        Row(
                          children: [
                            _SocialIcon(Icons.facebook),
                            _SocialIcon(Icons.camera_alt), // Instagram
                            _SocialIcon(Icons.close),      // X (Twitter)
                            _SocialIcon(Icons.business),   // LinkedIn
                            _SocialIcon(Icons.music_note), // TikTok
                            _SocialIcon(Icons.play_circle),// YouTube
                          ],
                        ),
                      ],
                    ),
                  ),

                  // COLUMN 2: Links
                  _FooterColumn(
                    title: "Links",
                    links: const ["Pricing", "Integrations", "Features", "Login"],
                  ),

                  // COLUMN 3: Support
                  _FooterColumn(
                    title: "Support",
                    links: const ["Help Center", "Service status", "Terms of service", "Privacy policy", "Cookie policy", "GDPR"],
                  ),

                  // COLUMN 4: Resources
                  _FooterColumn(
                    title: "Resources",
                    links: const ["Blog", "Affiliates", "Roadmap"],
                  ),

                  // COLUMN 5: Community
                  SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Community", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 20),
                        const Text(
                          "Join our community to learn how to use all of our tools faster and better.",
                          style: TextStyle(color: AppColors.textBody, fontSize: 15, height: 1.5),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1F2937),
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
              Divider(color: Colors.grey.shade200),
              
              const SizedBox(height: 30),

              // --- BOTTOM SECTION (Copyright) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "© Copyright CissyTech Ltd. All Rights Reserved.",
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
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
    return SizedBox(
      width: 140, // Fixed width for alignment
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 20),
          ...links.map((link) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                link,
                style: const TextStyle(color: AppColors.textBody, fontSize: 15),
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
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Icon(icon, size: 24, color: Colors.black),
    );
  }
}