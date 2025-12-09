import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Import Animate
import '../../../core/theme/app_colors.dart';
import '../../../shared/layout/responsive.dart';

class ProductivitySection extends StatelessWidget {
  const ProductivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    
    // 1. Capture Theme Colors
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Container(
      color: bgColor,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              // HEADER (Animated)
              Text(
                "Maximum Productivity",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.0,
                  color: textColor,
                ),
              ).animate()
               .scale(duration: 600.ms, curve: Curves.easeOutBack, begin: const Offset(0.9, 0.9))
               .fade(duration: 600.ms),
              
              const SizedBox(height: 16),
              
              Text(
                "Everything you need to scale your operations without the headache.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: bodyColor),
              ).animate()
               .scale(delay: 200.ms, duration: 600.ms, curve: Curves.easeOutBack, begin: const Offset(0.9, 0.9))
               .fade(delay: 200.ms, duration: 600.ms),

              const SizedBox(height: 60),

              // --- ROW 1: Analytics + Status ---
              if (isMobile)
                Column(
                  children: [
                    _HoverBentoCard(
                      height: 320,
                      padding: EdgeInsets.zero,
                      delay: 0,
                      child: _buildAnalyticsContent(context),
                    ),
                    const SizedBox(height: 20),
                    _HoverBentoCard(
                      height: 320,
                      delay: 100,
                      child: _buildStatusContent(context),
                    ),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _HoverBentoCard(
                        height: 320,
                        padding: EdgeInsets.zero,
                        delay: 0,
                        child: _buildAnalyticsContent(context),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: _HoverBentoCard(
                        height: 320,
                        delay: 100,
                        child: _buildStatusContent(context),
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 20),

              // --- ROW 2: Three Small Features ---
              if (isMobile)
                Column(
                  children: [
                    _buildSmallFeature(context, "99.9% Uptime", Icons.cloud_done, Colors.green, 200),
                    const SizedBox(height: 20),
                    _buildSmallFeature(context, "24/7 Support", Icons.headset_mic, Colors.blue, 300),
                    const SizedBox(height: 20),
                    _buildSmallFeature(context, "Open API", Icons.code, Colors.orange, 400),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(child: _buildSmallFeature(context, "99.9% Uptime", Icons.cloud_done, Colors.green, 200)),
                    const SizedBox(width: 20),
                    Expanded(child: _buildSmallFeature(context, "24/7 Support", Icons.headset_mic, Colors.blue, 300)),
                    const SizedBox(width: 20),
                    Expanded(child: _buildSmallFeature(context, "Open API", Icons.code, Colors.orange, 400)),
                  ],
                ),

              const SizedBox(height: 20),

              // --- ROW 3: Task List + Infrastructure ---
              if (isMobile)
                Column(
                  children: [
                    _HoverBentoCard(
                      height: 320,
                      delay: 500,
                      child: _buildTaskListContent(context),
                    ),
                    const SizedBox(height: 20),
                    _HoverBentoCard(
                      height: 320,
                      padding: EdgeInsets.zero,
                      delay: 600,
                      child: _buildInfrastructureContent(),
                    ),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: _HoverBentoCard(
                        height: 320,
                        delay: 500,
                        child: _buildTaskListContent(context),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: _HoverBentoCard(
                        height: 320,
                        padding: EdgeInsets.zero,
                        delay: 600,
                        child: _buildInfrastructureContent(),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  // --- CONTENT BUILDERS ---

  Widget _buildAnalyticsContent(BuildContext context) {
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Real-time Analytics", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 8),
              Text("Track performance across all nodes.", style: TextStyle(color: bodyColor)),
            ],
          ),
        ),
        Positioned(
          bottom: 0, left: 0, right: 0,
          height: 200,
          child: Image.network(
            "https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&q=80",
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusContent(BuildContext context) {
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80, height: 80,
          decoration: BoxDecoration(
            color: isDark ? Colors.green.withOpacity(0.2) : Colors.green.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_circle, color: Colors.green, size: 40),
        ),
        const SizedBox(height: 20),
        Text("All Systems Operational", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor)),
        const SizedBox(height: 8),
        Text("Last check: 2m ago", style: TextStyle(color: bodyColor, fontSize: 14)),
      ],
    );
  }

  Widget _buildSmallFeature(BuildContext context, String title, IconData icon, Color color, int delay) {
    final textColor = Theme.of(context).textTheme.displayLarge?.color;

    return _HoverBentoCard(
      height: 160,
      delay: delay,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
        ],
      ),
    );
  }

  Widget _buildTaskListContent(BuildContext context) {
    final textColor = Theme.of(context).textTheme.displayLarge?.color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Optimization", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
        const SizedBox(height: 20),
        _checkItem(context, "Cache cleared", true),
        _checkItem(context, "Database optimized", true),
        _checkItem(context, "CDN synced", true),
        _checkItem(context, "Backups completed", false),
      ],
    );
  }

  Widget _checkItem(BuildContext context, String text, bool checked) {
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final disabledColor = Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            checked ? Icons.check_circle : Icons.circle_outlined, 
            color: checked ? AppColors.primary : disabledColor, 
            size: 20
          ),
          const SizedBox(width: 10),
          Text(text, style: TextStyle(
            color: checked ? textColor : disabledColor, 
            fontWeight: FontWeight.w500)
          ),
        ],
      ),
    );
  }

  Widget _buildInfrastructureContent() {
    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.8,
            child: Image.network(
              "https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&q=80",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.8), Colors.transparent],
              ),
            ),
          ),
        ),
        const Positioned(
          bottom: 24, left: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Global Infrastructure", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text("Servers in 24 regions", style: TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}

// --- NEW HOVER BENTO CARD ---
class _HoverBentoCard extends StatefulWidget {
  final Widget child;
  final double height;
  final EdgeInsetsGeometry? padding;
  final int delay;

  const _HoverBentoCard({
    required this.child, 
    required this.height, 
    this.padding, 
    this.delay = 0
  });

  @override
  State<_HoverBentoCard> createState() => _HoverBentoCardState();
}

class _HoverBentoCardState extends State<_HoverBentoCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    // 2. Capture Card Colors
    final cardColor = Theme.of(context).cardColor;
    final borderColor = Theme.of(context).dividerColor;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        height: widget.height,
        padding: widget.padding ?? const EdgeInsets.all(24),
        // LIFT ANIMATION
        transform: isHovered ? Matrix4.translationValues(0, -6, 0) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: cardColor, // Dynamic Background
          borderRadius: BorderRadius.circular(20),
          // BORDER HIGHLIGHT
          border: Border.all(
            color: isHovered ? AppColors.primary.withOpacity(0.3) : borderColor, 
            width: 1
          ),
          // GLOW
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
    ).animate() // ENTRANCE POP
     .scale(
        delay: Duration(milliseconds: widget.delay), 
        duration: 800.ms, 
        curve: Curves.easeOutBack,
        begin: const Offset(0.9, 0.9), 
        end: const Offset(1, 1)
     )
     .fade(delay: Duration(milliseconds: widget.delay), duration: 600.ms);
  }
}