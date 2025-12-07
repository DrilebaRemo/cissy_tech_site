import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class BentoGridSection extends StatelessWidget {
  const BentoGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40), // Reduced vertical padding
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000), // Reduced max width to keep it tighter
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- LEFT COLUMN ---
              Expanded(
                child: Column(
                  children: [
                    // Card 1: Video (Reduced height 500 -> 380)
                    _BentoCard(
                      height: 380,
                      child: _buildVideoContent(),
                    ),
                    const SizedBox(height: 20),
                    // Card 2: Features (Reduced height 300 -> 220)
                    _BentoCard(
                      height: 220,
                      child: _buildFeatureContent(
                        "Powerful Plugins",
                        "Design assets instantly with our built-in tools.",
                        Icons.brush_outlined,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 20), // Tighter gap

              // --- RIGHT COLUMN ---
              Expanded(
                child: Column(
                  children: [
                    // Card 3: Integrations (Reduced height 300 -> 220)
                    _BentoCard(
                      height: 220,
                      child: _buildIntegrationContent(),
                    ),
                    const SizedBox(height: 20),
                    // Card 4: Approvals (Reduced height 500 -> 380)
                    _BentoCard(
                      height: 380,
                      child: _buildApprovalContent(),
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

  // --- CONTENT BUILDERS ---

  Widget _buildVideoContent() {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              "https://images.unsplash.com/photo-1557804506-669a67965ba0?w=800&q=80",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ),
        Center(
          // Made play button smaller (80 -> 60)
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10)),
              ],
            ),
            child: const Icon(Icons.play_arrow_rounded, size: 40, color: AppColors.primary),
          ),
        ),
        const Positioned(
          bottom: 24,
          left: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "See how it works",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                "2 min demo video",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildFeatureContent(String title, String desc, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(24), // Reduced padding inside card
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 12),
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Text(desc, style: const TextStyle(color: AppColors.textBody, fontSize: 15, height: 1.4)),
          const Spacer(),
          Row(
            children: [
              const Text("Check all features", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(width: 5),
              Icon(Icons.arrow_forward, size: 14, color: Colors.black.withOpacity(0.7)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildIntegrationContent() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Integrations", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text("Connect your favorite tools.", style: TextStyle(color: AppColors.textBody, fontSize: 15)),
          const Spacer(),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _pill("Shopify", Icons.shopping_bag, Colors.green),
              _pill("Slack", Icons.chat_bubble, Colors.orange),
              _pill("Stripe", Icons.credit_card, Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildApprovalContent() {
    return Stack(
      children: [
        const Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Approvals", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                "Get feedback from internal teams or clients with one link.",
                style: TextStyle(color: AppColors.textBody, fontSize: 15, height: 1.4),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 24,
          right: 24,
          left: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _userBubble("Internal approval", "https://i.pravatar.cc/150?img=5"),
              const SizedBox(height: 10),
              _userBubble("Client feedback", "https://i.pravatar.cc/150?img=9"),
            ],
          ),
        )
      ],
    );
  }

  Widget _pill(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _userBubble(String text, String img) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(backgroundImage: NetworkImage(img), radius: 12),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }
}

class _BentoCard extends StatelessWidget {
  final Widget child;
  final double height;

  const _BentoCard({required this.child, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(20), // Slightly reduced radius
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: child,
      ),
    );
  }
}