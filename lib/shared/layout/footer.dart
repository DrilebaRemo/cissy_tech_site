import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Import Animate
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 800;
              
              // Define sections for reuse
              final brandSection = SizedBox(
                width: isMobile ? double.infinity : null, 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/cissy_logo.png', height: 32),
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
                      "Check us out on social media.",
                      style: TextStyle(color: bodyColor, fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: const [
                        _AnimatedSocialIcon(FontAwesomeIcons.whatsapp, url: "https://api.whatsapp.com/send?phone=256781776645&text=Hey%20CissyTech"),
                        _AnimatedSocialIcon(FontAwesomeIcons.instagram, url: "https://www.instagram.com/cissytech?igsh=MXU3YTh4NGx2NWp2bQ=="),
                        _AnimatedSocialIcon(FontAwesomeIcons.xTwitter, url: "https://x.com/cissytech"),
                        _AnimatedSocialIcon(FontAwesomeIcons.tiktok, url: "https://vm.tiktok.com/ZMHw9LjdJRAF9-oPRWx/"),
                        _AnimatedSocialIcon(FontAwesomeIcons.youtube, url: "https://www.youtube.com/@cissytech"),
                      ],
                    ),
                  ],
                ),
              );

              final linksSection = const _FooterColumn(
                title: "Links",
                links: {
                  "Services": "/services", 
                  "Products": "/products", 
                  "Features": "/features", 
                },
              );

              final supportSection = const _FooterColumn(
                title: "Support",
                links: {
                  "Help Center": "/help", 
                  "Service status": "/status"
                },
              );

              final contactSection = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text("Contact us", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor)),
                   const SizedBox(height: 20),
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Icon(Icons.location_on_outlined, size: 20, color: bodyColor),
                       const SizedBox(width: 10),
                       Expanded(
                         child: Text(
                           "Plot 15A,\nNtinda Kampala, Uganda",
                           style: TextStyle(color: bodyColor, fontSize: 15),
                         ),
                       ),
                     ],
                   ),
                   const SizedBox(height: 16),
                   Row(
                     children: [
                       Icon(Icons.email_outlined, size: 20, color: bodyColor),
                       const SizedBox(width: 10),
                       _HoverLink(text: "info[@]cissytech.com", baseColor: bodyColor),
                     ],
                   ),
                   const SizedBox(height: 16),
                   Row(
                     children: [
                       Icon(Icons.phone_outlined, size: 20, color: bodyColor),
                       const SizedBox(width: 10),
                       _HoverLink(text: "+256 781 776 645", baseColor: bodyColor, url: "tel:+256781776645"),
                     ],
                   ),
                ],
              );

              return Column(
                children: [
                  // --- TOP SECTION ---
                  if (isMobile) 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        brandSection,
                        const SizedBox(height: 40),
                        linksSection, // Links
                        const SizedBox(height: 40),
                        supportSection, // Support
                        const SizedBox(height: 40),
                        contactSection
                      ],
                    )
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: brandSection),
                        Expanded(child: linksSection),
                        Expanded(child: supportSection),
                        Expanded(flex: 2, child: contactSection),
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

                  // --- BOTTOM SECTION ---
                  if (isMobile)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "© Copyright CissyTech Ltd. All Rights Reserved.",
                          style: TextStyle(color: bodyColor?.withOpacity(0.7), fontSize: 14),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 20,
                          runSpacing: 10,
                          children: [
                            _HoverLink(text: "Terms of service", baseColor: bodyColor?.withOpacity(0.7), url: "https://cissytech.com/policies/refund-and-cancellation"),
                            _HoverLink(text: "Privacy policy", baseColor: bodyColor?.withOpacity(0.7), url: "https://cissytech.com/policies/refund-and-cancellation"),
                          ],
                        )
                      ],
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "© Copyright CissyTech Ltd. All Rights Reserved.",
                          style: TextStyle(color: bodyColor?.withOpacity(0.7), fontSize: 14),
                        ),
                        Row(
                          children: [
                            _HoverLink(text: "Terms of service", baseColor: bodyColor?.withOpacity(0.7), url: "https://cissytech.com/policies/refund-and-cancellation"),
                            const SizedBox(width: 20),
                            _HoverLink(text: "Privacy policy", baseColor: bodyColor?.withOpacity(0.7), url: "https://cissytech.com/policies/refund-and-cancellation"),
                          ],
                        )
                      ],
                    ),
                ]
              );
            }
          ),
    );
  }
}

// --- HELPER WIDGETS ---

class _FooterColumn extends StatelessWidget {
  final String title;
  final Map<String, String> links;

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
          ...links.entries.map((entry) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            // Replaced static Text with Animated Link Widget
            child: _HoverLink(text: entry.key, baseColor: bodyColor, url: entry.value),
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
  final String? url;

  const _HoverLink({required this.text, required this.baseColor, this.url});

  @override
  State<_HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<_HoverLink> {
  bool isHovered = false;

  Future<void> _launchUrl() async {
    if (widget.url != null) {
      final Uri uri = Uri.parse(widget.url!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        debugPrint('Could not launch ${widget.url}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchUrl,
      child: MouseRegion(
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
      ),
    );
  }
}

// --- NEW ANIMATED SOCIAL ICON ---
class _AnimatedSocialIcon extends StatefulWidget {
  final IconData icon;
  final String? url;
  const _AnimatedSocialIcon(this.icon, {this.url});

  @override
  State<_AnimatedSocialIcon> createState() => _AnimatedSocialIconState();
}

class _AnimatedSocialIconState extends State<_AnimatedSocialIcon> {
  bool isHovered = false;

  Future<void> _launchUrl() async {
    if (widget.url != null) {
      final Uri uri = Uri.parse(widget.url!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
         debugPrint('Could not launch ${widget.url}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : AppColors.brandGray;

    return GestureDetector(
      onTap: _launchUrl,
      child: MouseRegion(
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