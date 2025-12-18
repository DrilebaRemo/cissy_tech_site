import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/animated_counter.dart';
import '../../../shared/widgets/fade_in_scroll.dart';
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
              FadeInScroll(
                child: Text(
                  "Maximum Productivity",
                  textAlign: TextAlign.center,
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
                  "Everything you need to scale your operations without the headache.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: bodyColor),
                ),
              ),

              const SizedBox(height: 60),


              if (isMobile)
                Column(
                  children: const[
                    _HoverBentoCard(
                      height: 320,
                      padding: EdgeInsets.zero,
                      delay: 0,
                      child: _IntegrationsScrollingCard(),
                    ),
                    const SizedBox(height: 20),
                    _HoverBentoCard(
                      height: 320,
                      delay: 100,
                      child: _StatusCard(),
                    ),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const[
                    Expanded(
                      flex: 2,
                      child: _HoverBentoCard(
                        height: 320,
                        padding: EdgeInsets.zero,
                        delay: 0,
                        child: _IntegrationsScrollingCard(),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: _HoverBentoCard(
                        height: 320,
                        delay: 100,
                        child: _StatusCard(),
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 20),

               Row(
                children: [
                  Expanded(
                    child: _HoverBentoCard(
                      height: 160,
                      delay: 300,
                      // STAT 1: Scale
                      child: const AnimatedCounter(
                        targetValue: 5,
                        label: "Transactions Processed",
                        color: Colors.blue,
                        suffix: "M+",
                        isInt: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _HoverBentoCard(
                      height: 160,
                      delay: 400,
                      // STAT 2: Reliability
                      child: const AnimatedCounter(
                        targetValue: 99.9,
                        label: "System Uptime",
                        color: Colors.green,
                        suffix: "%",
                        isInt: false, // This allows decimals
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _HoverBentoCard(
                      height: 160,
                      delay: 500,
                      // STAT 3: Speed/Support
                      child: const AnimatedCounter(
                        targetValue: 15,
                        label: "Avg. Response Time",
                        color: Colors.orange,
                        prefix: "< ",
                        suffix: " min",
                        isInt: true,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // --- ROW 3 ---
              if (isMobile)
                Column(children: const [
                  _HoverBentoCard(height: 320, delay: 600, child: _TaskListCard()),
                  SizedBox(height: 20),
                  _HoverBentoCard(height: 320, padding: EdgeInsets.zero, delay: 750, child: _InfrastructureCard()),
                ])
              else
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                  Expanded(flex: 1, child: _HoverBentoCard(height: 320, delay: 600, child: _TaskListCard())),
                  SizedBox(width: 20),
                  Expanded(flex: 2, child: _HoverBentoCard(height: 320, padding: EdgeInsets.zero, delay: 750, child: _InfrastructureCard())),
                ]),
            ],
          ),
        ),
      ),
    );
  }

}

 
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

    return FadeInScroll(
      delay: Duration(milliseconds: widget.delay),
      child: MouseRegion(
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
      ),
    );
  }
}

// --- 1. INTEGRATIONS SCROLLING CARD ---
class _IntegrationsScrollingCard extends StatefulWidget {
  const _IntegrationsScrollingCard();

  @override
  State<_IntegrationsScrollingCard> createState() => _IntegrationsScrollingCardState();
}

class _IntegrationsScrollingCardState extends State<_IntegrationsScrollingCard> {
  late ScrollController _scrollController;
  late Timer _timer;
  
  // List of Social Icons from FontAwesome
  final List<IconData> _icons = [
    FontAwesomeIcons.xTwitter,
    FontAwesomeIcons.linkedinIn,
    FontAwesomeIcons.tiktok,
    FontAwesomeIcons.threads,
    FontAwesomeIcons.facebook,
    FontAwesomeIcons.telegram,
    FontAwesomeIcons.slack,
    FontAwesomeIcons.pinterest,
    FontAwesomeIcons.youtube,
    FontAwesomeIcons.google,
    FontAwesomeIcons.instagram,
    FontAwesomeIcons.discord,
    FontAwesomeIcons.whatsapp,
    FontAwesomeIcons.spotify,
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScrolling());
  }

  void _startScrolling() {
    // Smooth auto-scroll logic
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (!_scrollController.hasClients) return;
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.offset;
      double nextScroll = currentScroll + 1.0; 

      if (nextScroll >= maxScroll) {
        _scrollController.jumpTo(0);
      } else {
        _scrollController.jumpTo(nextScroll);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Social integrations", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
          const SizedBox(height: 8),
          Text(
            "Over 30+ integrations including social, design, ecommerce and even our API.", 
            style: TextStyle(color: bodyColor, fontSize: 15, height: 1.5)
          ),
          
          const Spacer(),

          // Scrolling Icons Row
          SizedBox(
            height: 80,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(), // User can't manually scroll effectively since timer overrides, but standard pattern is disabling physics or allowing handle
              itemCount: 1000, // Infinite illusion
              itemBuilder: (context, index) {
                final icon = _icons[index % _icons.length];
                return Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade100,
                    boxShadow: [
                       BoxShadow(
                         color: Colors.black.withOpacity(0.05),
                         blurRadius: 10,
                         offset: const Offset(0, 4),
                       )
                    ]
                  ),
                  alignment: Alignment.center,
                  child: FaIcon(icon, size: 24, color: isDark ? Colors.white : Colors.black87),
                );
              },
            ),
          ),
          
          const Spacer(),

          // Bottom Link
          Row(
            children: [
              Text("Check all integrations", style: TextStyle(fontWeight: FontWeight.w600, color: textColor)),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right, size: 16, color: textColor),
            ],
          )
        ],
      ),
    );
  }
}

// --- 2. STATUS CARD ---
class _StatusCard extends StatelessWidget {
  const _StatusCard();
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80, height: 80,
          decoration: BoxDecoration(color: isDark ? Colors.green.withOpacity(0.2) : Colors.green.withOpacity(0.1), shape: BoxShape.circle),
          child: const Icon(Icons.check_circle, color: Colors.green, size: 40),
        ),
        const SizedBox(height: 20),
        Text("All Systems Operational", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor)),
        const SizedBox(height: 8),
        Text("Last check: 2m ago", style: TextStyle(color: bodyColor, fontSize: 14)),
      ],
    );
  }
}

// --- 3. FEATURE ICON CARD ---
class _FeatureIconCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  const _FeatureIconCard({required this.title, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 12),
        Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
      ],
    );
  }
}

// --- 4. TASK LIST CARD ---
// --- 4. TASK LIST CARD (Security & Compliance) ---
class _TaskListCard extends StatelessWidget {
  const _TaskListCard();
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center, // Center vertically
      children: [
        Text("Enterprise Security", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
        const SizedBox(height: 20),
        const _CheckItem(text: "End-to-End Encryption", checked: true),
        const _CheckItem(text: "Automated Fraud Detection", checked: true),
        const _CheckItem(text: "Daily Cloud Backups", checked: true),
        const _CheckItem(text: "GDPR Compliant", checked: true),
      ],
    );
  }
}

// Sub-widget for Task List
class _CheckItem extends StatelessWidget {
  final String text;
  final bool checked;
  const _CheckItem({required this.text, required this.checked});
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final disabledColor = Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(checked ? Icons.check_circle : Icons.circle_outlined, color: checked ? AppColors.primary : disabledColor, size: 20),
          const SizedBox(width: 10),
          Text(text, style: TextStyle(color: checked ? textColor : disabledColor, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

// --- 5. INFRASTRUCTURE CARD ---
// --- 5. INFRASTRUCTURE CARD (Global Reach) ---
class _InfrastructureCard extends StatelessWidget {
  const _InfrastructureCard();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Opacity(
            opacity: 0.8,
            child: Image.network(
              "https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&q=80",
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Gradient
        Positioned.fill(
          child: Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.black.withOpacity(0.9), Colors.transparent]))),
        ),
        // Pulsing Dots (Fake Server Nodes)
        const Positioned(top: 100, left: 80, child: _PulseDot()),
        const Positioned(top: 150, right: 100, child: _PulseDot()),
        const Positioned(bottom: 120, left: 150, child: _PulseDot()),

        // Text
        const Positioned(
          bottom: 24, left: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Global Infrastructure", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text("Low-latency servers across East Africa", style: TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}

// Simple pulsing dot widget
class _PulseDot extends StatelessWidget {
  const _PulseDot();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12, height: 12,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: AppColors.primary.withOpacity(0.6), blurRadius: 10, spreadRadius: 5)
        ]
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true))
     .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2), duration: 1.seconds)
     .fade(begin: 0.5, end: 1.0);
  }
}