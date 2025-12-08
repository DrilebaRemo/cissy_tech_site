import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class PricingSection extends StatefulWidget {
  const PricingSection({super.key});

  @override
  State<PricingSection> createState() => _PricingSectionState();
}

class _PricingSectionState extends State<PricingSection> {
  bool isYearly = false;

  @override
  Widget build(BuildContext context) {
    // 1. Capture Theme Colors
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Toggle Background: Light Grey vs Dark Grey
    final toggleBg = isDark ? const Color(0xFF1F2937) : Colors.grey.shade100;

    return Container(
      width: double.infinity,
      color: bgColor, // Dynamic Background
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          // 1. HEADLINE
          Text(
            "Flexible Plans",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.0,
              color: textColor, // Dynamic
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Choose a plan that scales with your business needs.",
            style: TextStyle(fontSize: 18, color: bodyColor), // Dynamic
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 40),

          // 2. TOGGLE SWITCH
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: toggleBg, // Dynamic
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

          const SizedBox(height: 60),

          // 3. PRICING CARDS
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _PricingCard(
                    title: "Bronze",
                    price: isYearly ? "12" : "15",
                    description: "For individuals with scheduling needs.",
                    features: const {
                      "Workspaces": "1",
                      "Users": "1",
                      "Social profiles": "5",
                      "AI credits": "100",
                      "Automation runs": "10",
                    },
                    isYearly: isYearly,
                  ),
                  _PricingCard(
                    title: "Silver",
                    price: isYearly ? "31" : "39",
                    description: "For small teams building their brand.",
                    features: const {
                      "Workspaces": "5",
                      "Users": "5",
                      "Social profiles": "20",
                      "AI credits": "500",
                      "Automation runs": "100",
                    },
                    isYearly: isYearly,
                  ),
                  _PricingCard(
                    title: "Gold",
                    price: isYearly ? "63" : "79",
                    description: "For bigger teams or solo freelancers.",
                    isPopular: true,
                    features: const {
                      "Workspaces": "20",
                      "Users": "20",
                      "Social profiles": "50",
                      "AI credits": "1,500",
                      "Automation runs": "1,500",
                    },
                    isYearly: isYearly,
                  ),
                  _PricingCard(
                    title: "Diamond",
                    price: isYearly ? "127" : "159",
                    description: "For large teams or marketing agencies.",
                    features: const {
                      "Workspaces": "∞",
                      "Users": "50",
                      "Social profiles": "150",
                      "AI credits": "∞",
                      "Automation runs": "10,000",
                    },
                    isYearly: isYearly,
                  ),
                ],
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
    
    // Selected Tab Color: White (Light) or Dark Grey Card (Dark)
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

// --- THE CARD WIDGET ---
class _PricingCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final Map<String, String> features;
  final bool isPopular;
  final bool isYearly;

  const _PricingCard({
    required this.title,
    required this.price,
    required this.description,
    required this.features,
    this.isPopular = false,
    required this.isYearly,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).cardColor;
    final borderColor = Theme.of(context).dividerColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Container(
      width: 280,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: cardColor, // Dynamic
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor), // Dynamic
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Title & Badge
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
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textColor),
                ),
              ),
              if (isPopular)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    // Adaptive Green Badge: Darker green bg in dark mode
                    color: isDark ? const Color(0xFF064E3B) : const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "Most popular",
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 12, 
                      // Lighter green text in dark mode
                      color: isDark ? const Color(0xFF6EE7B7) : const Color(0xFF166534),
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: 20),

          // 2. Price
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                "\$$price",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, letterSpacing: -2.0, color: textColor),
              ),
              const SizedBox(width: 4),
              Text(
                isYearly ? "/month (billed yearly)" : "/month",
                style: TextStyle(color: bodyColor, fontSize: 14),
              ),
            ],
          ),

          const SizedBox(height: 16),
          
          // 3. Description
          Text(
            description,
            style: TextStyle(color: bodyColor, height: 1.5),
          ),

          const SizedBox(height: 32),
          Divider(height: 1, color: borderColor),
          const SizedBox(height: 32),

          // 4. Features List
          ...features.entries.map((entry) => _buildFeatureRow(context, entry.key, entry.value)),

          const SizedBox(height: 32),

          // 5. Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                // Dark Mode: Primary Blue. Light Mode: Dark Grey.
                backgroundColor: isDark ? AppColors.primary : const Color(0xFF1F2937),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Try 7 days free", style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
        ],
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