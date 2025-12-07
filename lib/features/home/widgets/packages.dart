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
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          // 1. HEADLINE
          const Text(
            "Flexible Plans",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.0,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Choose a plan that scales with your business needs.",
            style: TextStyle(fontSize: 18, color: AppColors.textBody),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 40),

          // 2. TOGGLE SWITCH (Monthly / Yearly)
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOption("Monthly", !isYearly),
                _buildOption("Yearly (save 20%)", isYearly),
              ],
            ),
          ),

          const SizedBox(height: 60),

          // 3. PRICING CARDS
          // We use Wrap to ensure responsiveness (stacks on mobile, row on desktop)
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
  Widget _buildOption(String text, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => isYearly = text.contains("Yearly")),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]
              : [],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.black : Colors.grey.shade600,
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
    return Container(
      width: 280, // Fixed width to match the columns look
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
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
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              if (isPopular)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7), // Light green
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "Most popular",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF166534)),
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
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, letterSpacing: -2.0),
              ),
              const SizedBox(width: 4),
              Text(
                isYearly ? "/month (billed yearly)" : "/month",
                style: const TextStyle(color: AppColors.textBody, fontSize: 14),
              ),
            ],
          ),

          const SizedBox(height: 16),
          
          // 3. Description
          Text(
            description,
            style: const TextStyle(color: AppColors.textBody, height: 1.5),
          ),

          const SizedBox(height: 32),
          const Divider(height: 1),
          const SizedBox(height: 32),

          // 4. Features List
          ...features.entries.map((entry) => _buildFeatureRow(entry.key, entry.value)),

          const SizedBox(height: 32),

          // 5. Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F2937), // Dark button
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

  Widget _buildFeatureRow(String key, String value) {
    IconData icon;
    // Simple logic to choose icon based on text key
    if (key.contains("Workspace")) icon = Icons.folder_outlined;
    else if (key.contains("User")) icon = Icons.person_outline;
    else if (key.contains("Social")) icon = Icons.camera_alt_outlined;
    else if (key.contains("AI")) icon = Icons.auto_awesome;
    else icon = Icons.cached; // Automation

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          Text(key, style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}