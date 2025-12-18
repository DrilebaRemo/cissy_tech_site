import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fade_in_scroll.dart';

class InnovationSection extends StatelessWidget {
  const InnovationSection({super.key});

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
                  "Innovation & Technology",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w500, // Google uses lighter weights for headings
                    color: textColor,
                    letterSpacing: -1.0,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FadeInScroll(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  "Our teams are working to solve complex business challenges, advance digital infrastructure, and help companies scale effortlessly.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: bodyColor,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 60),

              // --- CONTENT GRID ---
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 900;

                  if (isMobile) {
                    return Column(
                      children: const [
                        // Stack everything vertically on mobile
                        _VerticalGoogleCard(
                          title: "Collecto SaaS Platform",
                          image: "https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&q=80",
                          height: 350,
                        ),
                        SizedBox(height: 20),
                        _VerticalGoogleCard(
                          title: "Fintech Solutions",
                          image: "https://images.unsplash.com/photo-1556742049-0cfed4f7a07d?w=800&q=80",
                          height: 350,
                        ),
                        SizedBox(height: 20),
                        _VerticalGoogleCard(
                          title: "Custom Development",
                          image: "https://images.unsplash.com/photo-1555099962-4199c345e5dd?w=800&q=80",
                          height: 300,
                        ),
                        SizedBox(height: 20),
                        _VerticalGoogleCard(
                          title: "Cloud Infrastructure",
                          image: "https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&q=80",
                          height: 300,
                        ),
                        SizedBox(height: 20),
                        _VerticalGoogleCard(
                          title: "ICT Training",
                          image: "https://images.unsplash.com/photo-1524178232363-1fb2b075b655?w=800&q=80",
                          height: 300,
                        ),
                      ],
                    );
                  }

                  // DESKTOP LAYOUT
                  return Column(
                    children: [
                      // ROW 1: Two Big Cards
                      Row(
                        children: const [
                          Expanded(
                            child: _VerticalGoogleCard(
                              title: "Collecto SaaS Platform",
                              image: "https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800&q=80",
                              height: 400, // Taller for impact
                            ),
                          ),
                          SizedBox(width: 24),
                          Expanded(
                            child: _VerticalGoogleCard(
                              title: "Fintech Solutions",
                              image: "https://images.unsplash.com/photo-1556742049-0cfed4f7a07d?w=800&q=80",
                              height: 400,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),

                      // ROW 2: Three Smaller Cards
                      Row(
                        children: const [
                          Expanded(
                            child: _VerticalGoogleCard(
                              title: "Custom Development",
                              image: "https://images.unsplash.com/photo-1555099962-4199c345e5dd?w=800&q=80",
                              height: 320,
                            ),
                          ),
                          SizedBox(width: 24),
                          Expanded(
                            child: _VerticalGoogleCard(
                              title: "Cloud Infrastructure",
                              image: "https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&q=80",
                              height: 320,
                            ),
                          ),
                          SizedBox(width: 24),
                          Expanded(
                            child: _VerticalGoogleCard(
                              title: "ICT Training",
                              image: "https://images.unsplash.com/photo-1524178232363-1fb2b075b655?w=800&q=80",
                              height: 320,
                            ),
                          ),
                        ],
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

// --- THE VERTICAL CARD WIDGET ---
class _VerticalGoogleCard extends StatefulWidget {
  final String title;
  final String image;
  final double height;

  const _VerticalGoogleCard({
    required this.title,
    required this.image,
    required this.height,
  });

  @override
  State<_VerticalGoogleCard> createState() => _VerticalGoogleCardState();
}

class _VerticalGoogleCardState extends State<_VerticalGoogleCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1E2D) : Colors.white; // Surface color
    final borderColor = Theme.of(context).dividerColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;

    return FadeInScroll(
      delay: const Duration(milliseconds: 200),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.height,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16), // Rounded corners
            border: Border.all(
              color: isHovered ? AppColors.primary.withOpacity(0.5) : borderColor,
            ),
            boxShadow: [
              if (isHovered)
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. IMAGE AREA (Takes up most of the card)
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    widget.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // 2. TEXT AREA (Bottom)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500, // Google style medium weight
                        color: textColor,
                      ),
                    ),
                    
                    // The "External Link" Icon
                    Icon(
                      Icons.open_in_new,
                      size: 20,
                      color: isHovered ? AppColors.primary : Colors.blue, // Google Blue
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}