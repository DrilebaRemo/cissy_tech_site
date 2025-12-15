import 'package:flutter/material.dart';
import '../../../shared/widgets/video_thumbnail.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fade_in_scroll.dart';

class BentoGridSection extends StatelessWidget {
  const BentoGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      color: bgColor, 
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
               // 1. HEADLINE
              FadeInScroll(
                child: Text(
                  "Manage your business with ease.",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).textTheme.displayLarge?.color,
                    letterSpacing: -1.5,
                    fontFamily: 'Inter',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              const SizedBox(height: 16),

              // 2. SUBTITLE
              FadeInScroll(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  "Take a peek at some of our tools and how they can help you manage your business.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 60),

              LayoutBuilder(
                builder: (context, constraints) {
                  bool isMobile = constraints.maxWidth < 900;
                  
                  // PUT YOUR YOUTUBE LINKS HERE
                  // Make sure these are Unlisted or Public on YouTube
                  const String mainVideoUrl = 'https://youtu.be/HwGSG1fKa-w'; 
                  
                  if (isMobile) {
                    return Column(
                      children: [
                        _HoverBentoCard(
                          height: 380, 
                          delay: 200,
                          padding: EdgeInsets.zero,
                          child: const VideoThumbnail(
                            videoUrl: mainVideoUrl,
                            title: 'Watch Demo',
                          ),
                        ),
                        const SizedBox(height: 20),
                        const _HoverBentoCard(
                          height: 420, 
                          delay: 300,
                          child: _BentoImageCard(
                            title: "Track payments in real-time", 
                            imagePath: "assets/images/collecto_ad.png",
                          ),
                        ),
                        const SizedBox(height: 20),
                        const _HoverBentoCard(
                          height: 480, 
                          delay: 400,
                          child: _BentoImageCard(
                             title: "Fast and seamless biometric tracking",
                             imagePath: "assets/images/bulk_ad.png",
                             height: 380,
                          ),
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
                            children: [
                               _HoverBentoCard(
                                height: 380, 
                                delay: 100,
                                padding: EdgeInsets.zero,
                                child: const VideoThumbnail(
                                  videoUrl: mainVideoUrl,
                                  title: 'Watch Demo',
                                ),
                              ),
                              const SizedBox(height: 20),
                              const _HoverBentoCard(
                                height: 420, 
                                delay: 200, 
                                child: _BentoImageCard(
                                   title: "Track payments in real-time",
                                   imagePath: "assets/images/collect_ad3.png",
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        // COLUMN 2
                        Expanded(
                          child: Column(
                            children: [
                              const _HoverBentoCard(
                                height: 430, 
                                delay: 300, 
                                child: _BentoImageCard(
                                  title: "Fast and seamless biometric tracking", 
                                  imagePath: "assets/images/bulk_ad3.png",
                                  height: 290,
                                ),
                              ),
                              const SizedBox(height: 20),
                              _HoverBentoCard(
                                height: 400, 
                                delay: 400, 
                                padding: EdgeInsets.zero, 
                                child: _BentoImageCard(
                                  title: "Fast and seamless biometric tracking", 
                                  imagePath: "assets/images/collecto_ad2.png",
                                  height: 290,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- NEW ANIMATED BENTO CARD ---
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
          width: double.infinity,
          padding: widget.padding ?? const EdgeInsets.all(24),
          transform: isHovered ? Matrix4.translationValues(0, -6, 0) : Matrix4.identity(),
          decoration: BoxDecoration(
            color: cardColor, 
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isHovered ? AppColors.primary.withOpacity(0.3) : borderColor,
              width: 1
            ),
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

// --- DYNAMIC IMAGE CARD ITEM ---
class _BentoImageCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final double height; 

  const _BentoImageCard({
    required this.title,
    required this.imagePath,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover, // Fill the card completely
          // No overlay - images show in full color
        ),
      ),
      padding: const EdgeInsets.all(24),
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}