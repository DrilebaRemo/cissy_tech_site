import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';

class BentoGridSection extends StatelessWidget {
  const BentoGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Capture Background Color
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      color: bgColor, 
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 900;
              
              if (isMobile) {
                return Column(
                  children: const[
                    _HoverBentoCard(
                      height: 380, 
                      delay: 200,
                      child: _BentoVideoItem()
                    ),
                    const SizedBox(height: 20),
                    _HoverBentoCard(
                      height: 220, 
                      delay: 400,
                      child: _BentoIntegrationsItem()
                    ),
                    const SizedBox(height: 20),
                    _HoverBentoCard(
                      height: 380, 
                      delay: 600,
                      child: _BentoApprovalsItem()
                    ),
                    const SizedBox(height: 20),
                    _HoverBentoCard(
                      height: 220, 
                      delay: 800,
                      child: _BentoFeatureItem(title: "Powerful Plugins", desc: "Design assets instantly with our built-in tools.", icon: Icons.brush_outlined)
                    ),
                  ],
                );
              } else {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // COLUMN 1
                    Expanded(
                      child: Column(
                        children: const[
                          _HoverBentoCard(
                            height: 380, 
                            delay: 200,
                            child: _BentoVideoItem()
                          ),
                          const SizedBox(height: 20),
                          _HoverBentoCard(
                            height: 220, 
                            delay: 400, // Staggered
                            child: _BentoFeatureItem(title: "Powerful Plugins", desc: "Design assets instantly with our built-in tools.", icon: Icons.brush_outlined)
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    // COLUMN 2
                    Expanded(
                      child: Column(
                        children: const[
                          _HoverBentoCard(
                            height: 290, // Increased from 220 to fix overflow
                            delay: 600, // Staggered
                            child: _BentoIntegrationsItem()
                          ),
                          const SizedBox(height: 20),
                          _HoverBentoCard(
                            height: 310, // Decreased from 380 to balance column
                            delay: 800, // Staggered
                            child: _BentoApprovalsItem()
                          ),
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
}

// --- NEW ANIMATED BENTO CARD ---
// Replaces the old _BentoCard with added Hover & Entrance effects
class _HoverBentoCard extends StatefulWidget {
  final Widget child;
  final double height;
  final int delay;

  const _HoverBentoCard({
    required this.child, 
    required this.height, 
    this.delay = 0
  });

  @override
  State<_HoverBentoCard> createState() => _HoverBentoCardState();
}

class _HoverBentoCardState extends State<_HoverBentoCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Preserve exact color logic
    final cardColor = Theme.of(context).cardColor;
    final borderColor = Theme.of(context).dividerColor;
    
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        height: widget.height,
        width: double.infinity,
        // 1. LIFT ANIMATION
        transform: isHovered ? Matrix4.translationValues(0, -6, 0) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: cardColor, 
          borderRadius: BorderRadius.circular(20),
          // 2. BORDER HIGHLIGHT (Subtle)
          border: Border.all(
            color: isHovered ? AppColors.primary.withOpacity(0.3) : borderColor,
            width: 1
          ),
          // 3. GLOW ANIMATION
          boxShadow: [
             if (isHovered)
               BoxShadow(color: AppColors.primary.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: widget.child,
        ),
      ),
    ).animate() // 4. ENTRANCE POP-IN
     .scale(
        delay: Duration(milliseconds: widget.delay), 
        duration: 600.ms, 
        curve: Curves.easeOutBack,
        begin: const Offset(0.9, 0.9), // Start slightly smaller
        end: const Offset(1, 1)
     )
     .fade(delay: Duration(milliseconds: widget.delay), duration: 600.ms);
  }
}

// --- 1. DYNAMIC VIDEO ITEM ---
class _BentoVideoItem extends StatelessWidget {
  const _BentoVideoItem();

  @override
  Widget build(BuildContext context) {
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
}

// --- 2. DYNAMIC FEATURE ITEM ---
class _BentoFeatureItem extends StatelessWidget {
  final String title;
  final String desc;
  final IconData icon;

  const _BentoFeatureItem({required this.title, required this.desc, required this.icon});

  @override
  Widget build(BuildContext context) {
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
}

// --- 3. DYNAMIC INTEGRATIONS ITEM ---
class _BentoIntegrationsItem extends StatelessWidget {
  const _BentoIntegrationsItem();

  @override
  Widget build(BuildContext context) {
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
            children: const [
               _BentoPill(text: "Shopify", icon: Icons.shopping_bag, color: Colors.green),
               _BentoPill(text: "Slack", icon: Icons.chat_bubble, color: Colors.orange),
               _BentoPill(text: "Stripe", icon: Icons.credit_card, color: Colors.blue),
            ],
          ),
        ],
      ),
    );
  }
}

// --- 4. DYNAMIC APPROVALS ITEM ---
class _BentoApprovalsItem extends StatelessWidget {
  const _BentoApprovalsItem();

  @override
  Widget build(BuildContext context) {
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
            children: const [
              _UserBubble(text: "Internal approval", img: "https://i.pravatar.cc/150?img=5"),
              SizedBox(height: 10),
              _UserBubble(text: "Client feedback", img: "https://i.pravatar.cc/150?img=9"),
            ],
          ),
        )
      ],
    );
  }
}

// --- 5. HELPER WIDGETS (Pills & Bubbles) ---
class _BentoPill extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;

  const _BentoPill({required this.text, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pillBg = isDark ? const Color(0xFF2D303E) : AppColors.primary.withOpacity(0.1);
    final textColor = isDark ? Colors.white : AppColors.brandGray;
    final borderColor = Theme.of(context).dividerColor;
    final border = isDark ? Border.all(color: borderColor) : null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: pillBg,
        border: isDark ? Border.all(color: Colors.white12) : null,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primary, size: 16),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: textColor)),
        ],
      ),
    );
  }
}

class _UserBubble extends StatelessWidget {
  final String text;
  final String img;

  const _UserBubble({required this.text, required this.img});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bubbleBg = isDark ? const Color(0xFF2D303E) : Colors.white;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bubbleBg,
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