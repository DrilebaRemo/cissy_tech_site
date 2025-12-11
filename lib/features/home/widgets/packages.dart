import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Import Animate
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fade_in_scroll.dart';

class PricingSection extends StatefulWidget {
  const PricingSection({super.key});

  @override
  State<PricingSection> createState() => _PricingSectionState();
}

class _PricingSectionState extends State<PricingSection> {
  bool isYearly = false;

  final List<Map<String, dynamic>> _plans = [
    {
      "title": "Bronze",
      "monthly": "15", "yearly": "12",
      "desc": "For individuals with scheduling needs.",
      "features": {"Workspaces": "1", "Users": "1", "Social profiles": "5", "AI credits": "100"},
      "popular": false,
      "delay": 100
    },
    {
      "title": "Silver",
      "monthly": "39", "yearly": "31",
      "desc": "For small teams building their brand.",
      "features": {"Workspaces": "5", "Users": "5", "Social profiles": "20", "AI credits": "500"},
      "popular": false,
      "delay": 200
    },
    {
      "title": "Gold",
      "monthly": "79", "yearly": "63",
      "desc": "For bigger teams or solo freelancers.",
      "features": {"Workspaces": "20", "Users": "20", "Social profiles": "50", "AI credits": "1,500"},
      "popular": true,
      "delay": 300
    },
    {
      "title": "Diamond",
      "monthly": "159", "yearly": "127",
      "desc": "For large teams or marketing agencies.",
      "features": {"Workspaces": "∞", "Users": "50", "Social profiles": "150", "AI credits": "∞"},
      "popular": false,
      "delay": 400
    },
  ];


  @override
  Widget build(BuildContext context) {
    // 1. Capture Theme Colors
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Toggle Background
    final toggleBg = isDark ? const Color(0xFF1F2937) : Colors.grey.shade100;

    return Container(
      width: double.infinity,
      color: bgColor, 
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          // 1. HEADLINE (Animated Pop)
          FadeInScroll(
            child: Text(
              "Flexible Plans",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.0,
                color: textColor,
              ),
            ),
          ),
           
          const SizedBox(height: 16),
          
          FadeInScroll(
            delay: const Duration(milliseconds: 100),
            child: Text(
              "Choose a plan that scales with your business needs.",
              style: TextStyle(fontSize: 18, color: bodyColor),
              textAlign: TextAlign.center,
            ),
          ),
          
          const SizedBox(height: 40),

          // 2. TOGGLE SWITCH (Animated Fade)
          FadeInScroll(
            delay: const Duration(milliseconds: 200),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: toggleBg, 
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildOption("Monthly", !isYearly, context),
                  _buildOption("Yearly (save 20%)", isYearly, context),
                ],
              ),
            ),
          ),

          const SizedBox(height: 60),

          // 3. PRICING CARDS
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: _plans.map((plan) {
                  return _HoverPricingCard(
                    title: plan['title'],
                    price: isYearly ? plan['yearly'] : plan['monthly'],
                    description: plan['desc'],
                    features: plan['features'],
                    isPopular: plan['popular'],
                    isYearly: isYearly,
                    delay: plan['delay'],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPER FOR TOGGLE ---
  Widget _buildOption(String text, bool isSelected, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Selected Tab Color
    final selectedColor = isDark ? const Color(0xFF374151) : Colors.white;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final unselectedTextColor = Theme.of(context).textTheme.bodyLarge?.color;

    return GestureDetector(
      onTap: () => setState(() => isYearly = text.contains("Yearly")),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]
              : [],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isSelected ? textColor : unselectedTextColor,
          ),
        ),
      ),
    );
  }
}

// --- NEW ANIMATED HOVER CARD ---
class _HoverPricingCard extends StatefulWidget {
  final String title;
  final String price;
  final String description;
  final Map<String, String> features;
  final bool isPopular;
  final bool isYearly;
  final int delay;

  const _HoverPricingCard({
    required this.title,
    required this.price,
    required this.description,
    required this.features,
    this.isPopular = false,
    required this.isYearly,
    this.delay = 0,
  });

  @override
  State<_HoverPricingCard> createState() => _HoverPricingCardState();
}

class _HoverPricingCardState extends State<_HoverPricingCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;
    final borderColor = Theme.of(context).dividerColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;

    return FadeInScroll(
      delay: Duration(milliseconds: widget.delay),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 280,
          padding: const EdgeInsets.all(32),
          // 1. LIFT EFFECT
          transform: isHovered ? Matrix4.translationValues(0, -10, 0) : Matrix4.identity(),
          decoration: BoxDecoration(
            color: cardColor, 
            borderRadius: BorderRadius.circular(16),
            // 2. BORDER HIGHLIGHT
            border: Border.all(
              color: isHovered ? AppColors.primary.withOpacity(0.5) : borderColor,
              width: isHovered ? 2 : 1
            ),
            // 3. GLOW EFFECT
            boxShadow: isHovered
              ? [BoxShadow(color: AppColors.primary.withOpacity(0.15), blurRadius: 30, offset: const Offset(0, 10))]
              : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title & Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      widget.title,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textColor),
                    ),
                  ),
                  if (widget.isPopular)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF064E3B) : const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "Most popular",
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: 12, 
                          color: isDark ? const Color(0xFF6EE7B7) : const Color(0xFF166534),
                        ),
                      ),
                    ),
                ],
              ),
              
              const SizedBox(height: 20),

              // Price
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "\$${widget.price}",
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, letterSpacing: -2.0, color: textColor),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.isYearly ? "/month (billed yearly)" : "/month",
                    style: TextStyle(color: bodyColor, fontSize: 14),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              
              // Description
              Text(widget.description, style: TextStyle(color: bodyColor, height: 1.5)),

              const SizedBox(height: 32),
              Divider(height: 1, color: borderColor),
              const SizedBox(height: 32),

              // Features List
              ...widget.features.entries.map((entry) => _buildFeatureRow(context, entry.key, entry.value)),

              const SizedBox(height: 32),

              // Button (Scales on hover via parent container lift)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? AppColors.primary : const Color(0xFF1F2937),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: isHovered ? 5 : 0, // Button shadow on hover
                  ),
                  child: const Text("Try 7 days free", style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(BuildContext context, String key, String value) {
    IconData icon;
    if (key.contains("Workspace")) icon = Icons.folder_outlined;
    else if (key.contains("User")) icon = Icons.person_outline;
    else if (key.contains("Social")) icon = Icons.camera_alt_outlined;
    else if (key.contains("AI")) icon = Icons.auto_awesome;
    else icon = Icons.cached;

    final iconColor = Theme.of(context).iconTheme.color;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final valueColor = Theme.of(context).textTheme.displayLarge?.color;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: iconColor?.withOpacity(0.7)),
          const SizedBox(width: 12),
          Text(key, style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: valueColor)),
        ],
      ),
    );
  }
}