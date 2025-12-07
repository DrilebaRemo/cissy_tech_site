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

  // List of Logo URLs (Placeholders for now)
  // In production, replace these with your actual partner logo assets
  final List<String> _logos = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/2560px-Google_2015_logo.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/2560px-Amazon_logo.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Netflix_2015_logo.svg/2560px-Netflix_2015_logo.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Samsung_Logo.svg/2560px-Samsung_Logo.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/IBM_logo.svg/2560px-IBM_logo.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Tata_Consultancy_Services_Logo.svg/2560px-Tata_Consultancy_Services_Logo.svg.png",
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    
    // Wait for build to finish, then start scrolling
    WidgetsBinding.instance.addPostFrameCallback((_) => _startAutoScroll());
  }

  void _startAutoScroll() {
    // 30ms timer for smooth 60fps animation
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (!_scrollController.hasClients) return;

      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.offset;
      
      // Speed: 1.5 pixels per tick
      double nextScroll = currentScroll + 1.5; 

      if (nextScroll >= maxScroll) {
        // If we hit the end, jump back to 0 instantly (Infinite loop illusion)
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
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          // 1. Section Header
          Text(
            "Trusted by leading companies in Uganda",
            style: TextStyle(
              fontSize: 18,
              color: AppColors.textBody.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const SizedBox(height: 40),

          // 2. The Scrolling List
          SizedBox(
            height: 60, // Height of the logo strip
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              // We simulate infinite items by returning a huge number
              // The logic in _startAutoScroll handles the looping
              itemCount: 1000, 
              itemBuilder: (context, index) {
                // Use modulo to cycle through the logo list repeatedly
                final logoUrl = _logos[index % _logos.length];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Opacity(
                    opacity: 0.6, // Make logos slightly faded like the screenshot
                    child: ColorFiltered(
                      // Turn logos to Grayscale (Black & White)
                      colorFilter: const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.srcIn, 
                      ),
                      child: Image.network(
                        logoUrl,
                        height: 40,
                        fit: BoxFit.contain,
                        // Loading handler to prevent crashes
                        errorBuilder: (c, o, s) => const Icon(Icons.business, color: Colors.grey, size: 40),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 80),

          // 3. The "Tag" (The little pill at the bottom of your screenshot)
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