import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fade_in_scroll.dart';

class InfoCardGrid extends StatelessWidget {
  const InfoCardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 900;
              
              if (isMobile) {
                return Column(
                  children: const [
                    _GoogleCard(
                      title: "Locations",
                      linkText: "Visit our offices",
                      image: "https://images.unsplash.com/photo-1497366216548-37526070297c?w=500&q=80",
                    ),
                    SizedBox(height: 20),
                    _GoogleCard(
                      title: "Contact Us",
                      linkText: "Get support",
                      image: "https://images.unsplash.com/photo-1596524430615-b46475ddff6e?w=500&q=80",
                    ),
                  ],
                );
              }

              return Row(
                children: const [
                  Expanded(
                    child: _GoogleCard(
                      title: "Locations",
                      linkText: "Visit our offices",
                      image: "https://images.unsplash.com/photo-1497366216548-37526070297c?w=500&q=80",
                    ),
                  ),
                  SizedBox(width: 24),
                  Expanded(
                    child: _GoogleCard(
                      title: "Contact Us",
                      linkText: "Get support",
                      image: "https://images.unsplash.com/photo-1596524430615-b46475ddff6e?w=500&q=80",
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _GoogleCard extends StatefulWidget {
  final String title;
  final String linkText;
  final String image;

  const _GoogleCard({
    required this.title,
    required this.linkText,
    required this.image,
  });

  @override
  State<_GoogleCard> createState() => _GoogleCardState();
}

class _GoogleCardState extends State<_GoogleCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1E2D) : Colors.white;
    final borderColor = Theme.of(context).dividerColor;

    return FadeInScroll(
      delay: const Duration(milliseconds: 100),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 280,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12), // Slightly less rounded than images
            border: Border.all(color: borderColor),
            boxShadow: [
              if (isHovered)
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))
            ],
          ),
          child: Row(
            children: [
              // LEFT: TEXT Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_forward, 
                            color: isHovered ? AppColors.primary : Colors.blue, // Google Blue
                            size: 24
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // RIGHT: IMAGE
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}