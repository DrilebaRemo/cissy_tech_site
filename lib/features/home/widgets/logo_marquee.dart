import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fade_in_scroll.dart';


class LogoMarquee extends StatefulWidget {
  const LogoMarquee({super.key});

  @override
  State<LogoMarquee> createState() => _LogoMarqueeState();
}

class _LogoMarqueeState extends State<LogoMarquee> {
  late ScrollController _scrollController;
  late Timer _timer; 

  final List<String> _partnerLogos = [
    "assets/images/stanbic.png",
    "assets/images/flexi.png",
    "assets/images/airtel.png",
    "assets/images/partner1.png",
    "assets/images/hepsia.png",
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
          FadeInScroll(
            child: Text(
              "Trusted by leading companies in Uganda",
              style: TextStyle(
                fontSize: 18,
                color: bodyColor?.withOpacity(0.7), // <--- Dynamic Text
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          const SizedBox(height: 40),

          // 2. The Interactive Marquee
          FadeInScroll(
            delay: const Duration(milliseconds: 100),
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
        ],
      ),
    );
  }
}

// --- ANIMATED LOGO ITEM ---
class _MarqueeItem extends StatelessWidget {
  final String imagePath;
  const _MarqueeItem({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final isPriority = imagePath.contains("airtel") || imagePath.contains("stanbic");
    final double height = isPriority ? 60.0 : 20.0;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: isDark ? const EdgeInsets.all(8.0) : EdgeInsets.zero,
      decoration: isDark
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      child: Image.asset(
        imagePath,
        height: height,
        fit: BoxFit.contain,
        errorBuilder: (c, o, s) => const Icon(Icons.broken_image, color: Colors.grey),
      ),
    );
  }
}