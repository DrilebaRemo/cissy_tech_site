import 'dart:async';
import 'package:flutter/material.dart';
// We don't need app_colors.dart strictly anymore if we use Theme.of(context), 
// but keeping it for reference is fine.

class LogoMarquee extends StatefulWidget {
  const LogoMarquee({super.key});

  @override
  State<LogoMarquee> createState() => _LogoMarqueeState();
}

class _LogoMarqueeState extends State<LogoMarquee> {
  late ScrollController _scrollController;
  late Timer _timer;
  bool _isHoveringArea = false; 

  final List<String> _partnerLogos = [
    "assets/images/stanbic.png",
    "assets/images/flexi.png",
    "assets/images/airtel.png",
    "assets/images/partner1.png",
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startAutoScroll());
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (!_scrollController.hasClients) return;
      if (_isHoveringArea) return; 

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
    // 1. Capture Dynamic Theme Colors
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final cardColor = Theme.of(context).cardColor;
    final borderColor = Theme.of(context).dividerColor;

    return Container(
      color: bgColor, // <--- Dynamic Background
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          // 1. Header Text
          Text(
            "Trusted by leading companies in Uganda",
            style: TextStyle(
              fontSize: 18,
              color: bodyColor?.withOpacity(0.7), // <--- Dynamic Text
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const SizedBox(height: 40),

          // 2. The Interactive Marquee
          MouseRegion(
            onEnter: (_) => setState(() => _isHoveringArea = true),
            onExit: (_) => setState(() => _isHoveringArea = false),
            child: SizedBox(
              height: 80, 
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: 1000, 
                itemBuilder: (context, index) {
                  final logoPath = _partnerLogos[index % _partnerLogos.length];
                  return _MarqueeItem(imagePath: logoPath);
                },
              ),
            ),
          ),

          const SizedBox(height: 60),

          // 3. The Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: cardColor, // <--- Dynamic Card Background
              border: Border.all(color: borderColor), // <--- Dynamic Border
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Our Ecosystem",
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold,
                color: textColor, // <--- Dynamic Text (Black/White)
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- ANIMATED LOGO ITEM ---
class _MarqueeItem extends StatefulWidget {
  final String imagePath;
  const _MarqueeItem({required this.imagePath});

  @override
  State<_MarqueeItem> createState() => _MarqueeItemState();
}

class _MarqueeItemState extends State<_MarqueeItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Optional: If you want logos to be white in dark mode, you can check brightness here
    // final isDark = Theme.of(context).brightness == Brightness.dark;
    // final colorFilter = isDark ? ColorFilter.mode(Colors.white, BlendMode.srcIn) : null;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedScale(
        scale: isHovered ? 1.2 : 1.0, 
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutBack, 
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: Image.asset(
            widget.imagePath,
            height: 50, 
            fit: BoxFit.contain,
            // If you want to force white logos in dark mode, uncomment this:
            // color: isDark ? Colors.white : null, 
            errorBuilder: (c, o, s) => const Icon(Icons.broken_image, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}