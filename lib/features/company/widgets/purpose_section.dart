import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fade_in_scroll.dart';

class PurposeSection extends StatelessWidget {
  const PurposeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // --- HEADER ---
              FadeInScroll(
                child: Text(
                  "Why we do what we do",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                    letterSpacing: -1.0,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FadeInScroll(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  "From the beginning, our passion for building technology that simplifies business has guided our work.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: bodyColor,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 60),

              // --- MASONRY LAYOUT ---
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 900;
                  final isDark = Theme.of(context).brightness == Brightness.dark;

                  // Define Pastel Colors for Cards (Light tints of brand colors)
                  // Dark Mode: Use darker, muted versions so they don't blind the user
                  final colorBlue = isDark ? const Color(0xFF0D2339) : const Color(0xFFE0F5FF);
                  final colorOrange = isDark ? const Color(0xFF332200) : const Color(0xFFFFF4E5);
                  final colorGreen = isDark ? const Color(0xFF0F392B) : const Color(0xFFE6F4F1);
                  final colorGray = isDark ? const Color(0xFF252836) : const Color(0xFFF3F4F6);

                  if (isMobile) {
                    return Column(
                      children: [
                        _PurposeCard(
                          category: "OUR STORY",
                          title: "From a local startup to powering enterprise payments across the region.",
                          bgColor: colorBlue,
                          image: "https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=800&q=80",
                          height: 400,
                        ),
                        const SizedBox(height: 24),
                        _PurposeCard(
                          category: "SOCIAL IMPACT",
                          title: "Discover how we enable small businesses to access digital economy tools.",
                          bgColor: colorGreen,
                          icon: Icons.groups_rounded,
                          iconColor: Colors.teal,
                          height: 300,
                        ),
                        const SizedBox(height: 24),
                        _PurposeCard(
                          category: "SECURITY & POLICY",
                          title: "We are committed to the highest standards of financial data protection.",
                          bgColor: colorOrange,
                          icon: Icons.gpp_good_rounded,
                          iconColor: AppColors.accent,
                          height: 300,
                        ),
                        const SizedBox(height: 24),
                        _PurposeCard(
                          category: "OUR TECHNOLOGY",
                          title: "Building robust infrastructure that handles millions of transactions daily.",
                          bgColor: colorGray,
                          image: "https://images.unsplash.com/photo-1558494949-ef526b0042a0?w=800&q=80",
                          height: 400,
                        ),
                      ],
                    );
                  }

                  // DESKTOP: Two Columns
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT COLUMN
                      Expanded(
                        child: Column(
                          children: [
                            // 1. Tall Image Card (Our Story)
                            _PurposeCard(
                              category: "OUR STORY",
                              title: "From a local startup to powering enterprise payments across the region.",
                              bgColor: colorBlue,
                              image: "https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=800&q=80",
                              height: 480,
                            ),
                            const SizedBox(height: 24),
                            // 3. Short Icon Card (Security)
                            _PurposeCard(
                              category: "SECURITY & POLICY",
                              title: "We are committed to the highest standards of financial data protection.",
                              bgColor: colorOrange,
                              icon: Icons.gpp_good_rounded,
                              iconColor: AppColors.accent,
                              height: 320,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      // RIGHT COLUMN
                      Expanded(
                        child: Column(
                          children: [
                            // 2. Short Icon Card (Social Impact)
                            _PurposeCard(
                              category: "SOCIAL IMPACT",
                              title: "Discover how we enable small businesses to access digital economy tools.",
                              bgColor: colorGreen,
                              icon: Icons.groups_rounded,
                              iconColor: Colors.teal,
                              height: 320,
                            ),
                            const SizedBox(height: 24),
                            // 4. Tall Image Card (Technology)
                            _PurposeCard(
                              category: "OUR TECHNOLOGY",
                              title: "Building robust infrastructure that handles millions of transactions daily.",
                              bgColor: colorGray,
                              image: "https://images.unsplash.com/photo-1558494949-ef526b0042a0?w=800&q=80",
                              height: 480,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- THE PURPOSE CARD WIDGET ---
// ... imports

// ... (PurposeSection class remains unchanged)

// --- THE PURPOSE CARD WIDGET ---
class _PurposeCard extends StatefulWidget {
  final String category;
  final String title;
  final Color bgColor;
  final double height;
  final String? image;
  final IconData? icon;
  final Color? iconColor;

  const _PurposeCard({
    required this.category,
    required this.title,
    required this.bgColor,
    required this.height,
    this.image,
    this.icon,
    this.iconColor,
  });

  @override
  State<_PurposeCard> createState() => _PurposeCardState();
}

class _PurposeCardState extends State<_PurposeCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return FadeInScroll(
      delay: const Duration(milliseconds: 200),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.height,
          width: double.infinity,
          
          // FIX: 'transform' goes here (Property of Container), NOT inside decoration
          transform: isHovered ? Matrix4.translationValues(0, -5, 0) : Matrix4.identity(),
          
          decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                // CONTENT (Centered Column)
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 1. Top Element: Image or Icon
                      if (widget.image != null) ...[
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                )
                              ],
                              image: DecorationImage(
                                image: NetworkImage(widget.image!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ] else if (widget.icon != null) ...[
                        Icon(widget.icon, size: 48, color: widget.iconColor),
                        const SizedBox(height: 20),
                      ],

                      // 2. Category Label
                      Text(
                        widget.category,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Colors.black54, 
                        ),
                      ),
                      
                      const SizedBox(height: 16),

                      // 3. Main Title
                      Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87, 
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 4. Link Icon
                      const Icon(
                        Icons.open_in_new,
                        size: 20,
                        color: AppColors.primary,
                      ),
                      
                      if (widget.image != null) 
                        const Spacer(), 
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}