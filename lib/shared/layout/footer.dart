import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Import Animate
import '../../core/theme/app_colors.dart';
import '../widgets/fade_in_scroll.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Capture Theme Colors (Exact preservation of your logic)
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.displayLarge?.color; 
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;    
    final bgColor = Theme.of(context).scaffoldBackgroundColor;         
    final dividerColor = Theme.of(context).dividerColor;

    return Container(
      color: bgColor,
      padding: const EdgeInsets.only(top: 80, bottom: 40, left: 40, right: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: FadeInScroll(
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
                              'assets/images/cissy_logo.png', 
                              height: 32,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "CissyTech",
                              style: TextStyle(
                                fontSize: 24, 
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : AppColors.brandGray,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Social media management. Using AI.",
                          style: TextStyle(color: bodyColor, fontSize: 16),
                        ),
                        const SizedBox(height: 24),
                        // Social Icons (Now Animated)
                        Row(
                          children: const [
                            _AnimatedSocialIcon(Icons.facebook),
                            _AnimatedSocialIcon(Icons.camera_alt),
                            _AnimatedSocialIcon(Icons.close),
                            _AnimatedSocialIcon(Icons.business),
                            _AnimatedSocialIcon(Icons.music_note),
                            _AnimatedSocialIcon(Icons.play_circle),
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
                        // Animated Button
                        _AnimatedButton(
                          isDark: isDark, 
                          text: "Join Community Group"
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 80),
              
              // --- DIVIDER ---
              Divider(
                color: isDark 
                    ? dividerColor 
                    : AppColors.brandGray.withOpacity(0.2)
              ),
              
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
            ]
          ),
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
            // Replaced static Text with Animated Link Widget
            child: _HoverLink(text: link, baseColor: bodyColor),
          )),
        ],
      ),
    );
  }
}

// --- NEW ANIMATED LINK WIDGET ---
class _HoverLink extends StatefulWidget {
  final String text;
  final Color? baseColor;

  const _HoverLink({required this.text, required this.baseColor});

  @override
  State<_HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<_HoverLink> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        // Slide right by 5px on hover
        transform: isHovered ? Matrix4.translationValues(5, 0, 0) : Matrix4.identity(),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            // Change color to Primary Blue on hover, otherwise use baseColor
            color: isHovered ? AppColors.primary : widget.baseColor,
            fontSize: 15,
            fontWeight: isHovered ? FontWeight.w500 : FontWeight.normal,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}

// --- NEW ANIMATED SOCIAL ICON ---
class _AnimatedSocialIcon extends StatefulWidget {
  final IconData icon;
  const _AnimatedSocialIcon(this.icon);

  @override
  State<_AnimatedSocialIcon> createState() => _AnimatedSocialIconState();
}

class _AnimatedSocialIconState extends State<_AnimatedSocialIcon> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : AppColors.brandGray;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.only(right: 16),
        // Lift up by 3px on hover
        transform: isHovered ? Matrix4.translationValues(0, -3, 0) : Matrix4.identity(),
        child: Icon(
          widget.icon, 
          size: 24, 
          // Turn Blue on hover
          color: isHovered ? AppColors.primary : iconColor
        ),
      ),
    );
  }
}

// --- NEW ANIMATED BUTTON ---
class _AnimatedButton extends StatefulWidget {
  final bool isDark;
  final String text;

  const _AnimatedButton({required this.isDark, required this.text});

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedScale(
        scale: isHovered ? 1.05 : 1.0, // Scale up 5% on hover
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.isDark ? AppColors.primary : const Color(0xFF1F2937),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: isHovered ? 5 : 0, 
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}