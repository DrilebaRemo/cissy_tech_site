import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class BentoGridSection extends StatelessWidget {
  const BentoGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Capture Background Color
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      color: bgColor, // <--- CHANGED: Dynamic Background
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 900;
              if (isMobile) {
                return Column(
                  children: [
                    _BentoCard(height: 380, child: _buildVideoContent(context)),
                    const SizedBox(height: 20),
                    _BentoCard(height: 220, child: _buildIntegrationContent(context)),
                    const SizedBox(height: 20),
                    _BentoCard(height: 380, child: _buildApprovalContent(context)),
                    const SizedBox(height: 20),
                    _BentoCard(height: 220, child: _buildFeatureContent(context, "Powerful Plugins", "Design assets instantly with our built-in tools.", Icons.brush_outlined)),
                  ],
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _BentoCard(height: 380, child: _buildVideoContent(context)),
                          const SizedBox(height: 20),
                          _BentoCard(height: 220, child: _buildFeatureContent(context, "Powerful Plugins", "Design assets instantly with our built-in tools.", Icons.brush_outlined)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        children: [
                          _BentoCard(height: 220, child: _buildIntegrationContent(context)),
                          const SizedBox(height: 20),
                          _BentoCard(height: 380, child: _buildApprovalContent(context)),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // --- CONTENT BUILDERS ---

  Widget _buildVideoContent(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network("https://images.unsplash.com/photo-1557804506-669a67965ba0?w=800&q=80", fit: BoxFit.cover),
          ),
        ),
        Positioned.fill(child: Container(color: Colors.black.withOpacity(0.3))),
        Center(
          child: Container(
            width: 60, height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))],
            ),
            child: const Icon(Icons.play_arrow_rounded, size: 40, color: AppColors.primary),
          ),
        ),
        const Positioned(
          bottom: 24, left: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("See how it works", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text("2 min demo video", style: TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildFeatureContent(BuildContext context, String title, String desc, IconData icon) {
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final iconColor = Theme.of(context).iconTheme.color;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 12),
              Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
            ],
          ),
          const SizedBox(height: 12),
          Text(desc, style: TextStyle(color: bodyColor, fontSize: 15, height: 1.4)),
          const Spacer(),
          Row(
            children: [
              Text("Check all features", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textColor)),
              const SizedBox(width: 5),
              Icon(Icons.arrow_forward, size: 14, color: iconColor?.withOpacity(0.7)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildIntegrationContent(BuildContext context) {
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Integrations", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
          const SizedBox(height: 8),
          Text("Connect your favorite tools.", style: TextStyle(color: bodyColor, fontSize: 15)),
          const Spacer(),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: [
              _pill(context, "Shopify", Icons.shopping_bag, Colors.green),
              _pill(context, "Slack", Icons.chat_bubble, Colors.orange),
              _pill(context, "Stripe", Icons.credit_card, Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildApprovalContent(BuildContext context) {
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Approvals", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 8),
              Text(
                "Get feedback from internal teams or clients with one link.",
                style: TextStyle(color: bodyColor, fontSize: 15, height: 1.4),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 24, right: 24, left: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _userBubble(context, "Internal approval", "https://i.pravatar.cc/150?img=5"),
              const SizedBox(height: 10),
              _userBubble(context, "Client feedback", "https://i.pravatar.cc/150?img=9"),
            ],
          ),
        )
      ],
    );
  }

  Widget _pill(BuildContext context, String text, IconData icon, Color color) {
    // 2. Logic for Pill Colors:
    // In Dark Mode, we want a dark card background, not white.
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pillBg = isDark ? const Color(0xFF2D303E) : Colors.white;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final borderColor = Theme.of(context).dividerColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: pillBg, // <--- CHANGED
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: textColor)),
        ],
      ),
    );
  }

  Widget _userBubble(BuildContext context, String text, String img) {
    // Logic for Bubble Colors
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bubbleBg = isDark ? const Color(0xFF2D303E) : Colors.white;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bubbleBg, // <--- CHANGED
        borderRadius: BorderRadius.circular(50),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(backgroundImage: NetworkImage(img), radius: 12),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: textColor)),
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
        color: Theme.of(context).cardColor, // <--- CHANGED: Dynamic Card Background
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor), // <--- Dynamic Border
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: child,
      ),
    );
  }
}