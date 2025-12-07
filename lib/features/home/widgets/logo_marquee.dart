import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class LogoMarquee extends StatefulWidget {
  const LogoMarquee({super.key});

  @override
  State<LogoMarquee> createState() => _LogoMarqueeState();
}

class _LogoMarqueeState extends State<LogoMarquee> {
  late ScrollController _scrollController;
  late Timer _timer;
  bool _isHoveringArea = false; // To pause scrolling when user interacts

 
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
      
      // Feature: Pause scrolling if the user is hovering over the area
      if (_isHoveringArea) return; 

      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.offset;
      double nextScroll = currentScroll + 1.0; // Slower speed for better visibility

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
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          // 1. Header Text
          Text(
            "Trusted by leading companies in Uganda",
            style: TextStyle(
              fontSize: 18,
              color: AppColors.textBody.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const SizedBox(height: 40),

          // 2. The Interactive Marquee
          MouseRegion(
            // When mouse enters the marquee area, we pause the scrolling
            onEnter: (_) => setState(() => _isHoveringArea = true),
            onExit: (_) => setState(() => _isHoveringArea = false),
            child: SizedBox(
              height: 80, // Increased height for the "Pop" effect clearance
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: 1000, 
                itemBuilder: (context, index) {
                  final logoPath = _partnerLogos[index % _partnerLogos.length];
                  
                  // Use the helper widget for the animation
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
              color: Colors.white,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Our Ecosystem",
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- NEW WIDGET: ANIMATED LOGO ITEM ---
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
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedScale(
        scale: isHovered ? 1.2 : 1.0, // Scale up to 120%
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutBack, // Bouncy pop effect
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          // We removed ColorFiltered, so images show original colors
          child: Image.asset(
            widget.imagePath,
            height: 50, // Base height
            fit: BoxFit.contain,
            // Fallback if image isn't found yet
            errorBuilder: (c, o, s) => const Icon(Icons.broken_image, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}