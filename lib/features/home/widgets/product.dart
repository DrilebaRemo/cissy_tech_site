import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
// 1. IMPORT RESPONSIVE
import '../../../shared/layout/responsive.dart';

class ProductivitySection extends StatelessWidget {
  const ProductivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. DEFINE THE VARIABLE
    bool isMobile = Responsive.isMobile(context);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              // HEADER
              const Text(
                "Maximum Productivity",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Everything you need to scale your operations without the headache.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: AppColors.textBody),
              ),
              const SizedBox(height: 60),

              // --- ROW 1: Analytics + Status ---
              if (isMobile)
                Column(
                  children: [
                    _BentoCard(
                      height: 320,
                      padding: EdgeInsets.zero,
                      child: _buildAnalyticsContent(),
                    ),
                    const SizedBox(height: 20),
                    _BentoCard(
                      height: 320,
                      child: _buildStatusContent(),
                    ),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _BentoCard(
                        height: 320,
                        padding: EdgeInsets.zero,
                        child: _buildAnalyticsContent(),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: _BentoCard(
                        height: 320,
                        child: _buildStatusContent(),
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 20),

              // --- ROW 2: Three Small Features ---
              if (isMobile)
                Column(
                  children: [
                    _buildSmallFeature("99.9% Uptime", Icons.cloud_done, Colors.green),
                    const SizedBox(height: 20),
                    _buildSmallFeature("24/7 Support", Icons.headset_mic, Colors.blue),
                    const SizedBox(height: 20),
                    _buildSmallFeature("Open API", Icons.code, Colors.orange),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(child: _buildSmallFeature("99.9% Uptime", Icons.cloud_done, Colors.green)),
                    const SizedBox(width: 20),
                    Expanded(child: _buildSmallFeature("24/7 Support", Icons.headset_mic, Colors.blue)),
                    const SizedBox(width: 20),
                    Expanded(child: _buildSmallFeature("Open API", Icons.code, Colors.orange)),
                  ],
                ),

              const SizedBox(height: 20),

              // --- ROW 3: Task List + Infrastructure ---
              if (isMobile)
                Column(
                  children: [
                    _BentoCard(
                      height: 320,
                      child: _buildTaskListContent(),
                    ),
                    const SizedBox(height: 20),
                    _BentoCard(
                      height: 320,
                      padding: EdgeInsets.zero,
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
                      child: _BentoCard(
                        height: 320,
                        child: _buildTaskListContent(),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: _BentoCard(
                        height: 320,
                        padding: EdgeInsets.zero,
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

  // --- CONTENT BUILDERS (Same as before) ---

  Widget _buildAnalyticsContent() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Real-time Analytics", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("Track performance across all nodes.", style: TextStyle(color: AppColors.textBody)),
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

  Widget _buildStatusContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80, height: 80,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_circle, color: Colors.green, size: 40),
        ),
        const SizedBox(height: 20),
        const Text("All Systems Operational", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        const Text("Last check: 2m ago", style: TextStyle(color: AppColors.textBody, fontSize: 14)),
      ],
    );
  }

  Widget _buildSmallFeature(String title, IconData icon, Color color) {
    return _BentoCard(
      height: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildTaskListContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Optimization", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        _checkItem("Cache cleared", true),
        _checkItem("Database optimized", true),
        _checkItem("CDN synced", true),
        _checkItem("Backups completed", false),
      ],
    );
  }

  Widget _checkItem(String text, bool checked) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            checked ? Icons.check_circle : Icons.circle_outlined, 
            color: checked ? AppColors.primary : Colors.grey, 
            size: 20
          ),
          const SizedBox(width: 10),
          Text(text, style: TextStyle(color: checked ? Colors.black : Colors.grey, fontWeight: FontWeight.w500)),
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

// --- HELPER CARD ---
class _BentoCard extends StatelessWidget {
  final Widget child;
  final double height;
  final EdgeInsetsGeometry? padding;

  const _BentoCard({required this.child, required this.height, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding ?? const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: child,
      ),
    );
  }
}