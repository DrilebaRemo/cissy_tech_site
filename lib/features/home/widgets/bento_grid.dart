import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Import Animate
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
                  children: [
                    _HoverBentoCard(
                      height: 380, 
                      delay: 0,
                      child: _buildVideoContent(context)
                    ),
                    const SizedBox(height: 20),
                    _HoverBentoCard(
                      height: 220, 
                      delay: 100,
                      child: _buildIntegrationContent(context)
                    ),
                    const SizedBox(height: 20),
                    _HoverBentoCard(
                      height: 380, 
                      delay: 200,
                      child: _buildApprovalContent(context)
                    ),
                    const SizedBox(height: 20),
                    _HoverBentoCard(
                      height: 220, 
                      delay: 300,
                      child: _buildFeatureContent(context, "Powerful Plugins", "Design assets instantly with our built-in tools.", Icons.brush_outlined)
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
                            delay: 0,
                            child: _buildVideoContent(context)
                          ),
                          const SizedBox(height: 20),
                          _HoverBentoCard(
                            height: 220, 
                            delay: 200, // Staggered
                            child: _buildFeatureContent(context, "Powerful Plugins", "Design assets instantly with our built-in tools.", Icons.brush_outlined)
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    // COLUMN 2
                    Expanded(
                      child: Column(
                        children: [
                          _HoverBentoCard(
                            height: 290, // Increased from 220 to fix overflow
                            delay: 100, // Staggered
                            child: _buildIntegrationContent(context)
                          ),
                          const SizedBox(height: 20),
                          _HoverBentoCard(
                            height: 310, // Decreased from 380 to balance column
                            delay: 300, // Staggered
                            child: _buildApprovalContent(context)
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

  // --- CONTENT BUILDERS (Kept exactly identical to your code) ---

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
    final iconColor = Theme.of(context).iconTheme.color;

    // List of Logo URLs (using high-quality PNGs/SVGs from reliable sources)
    final row1 = [
      "https://upload.wikimedia.org/wikipedia/en/thumb/a/a9/TikTok_logo.svg/2560px-TikTok_logo.svg.png", // TikTok
      "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/LinkedIn_logo_initials.png/600px-LinkedIn_logo_initials.png", // LinkedIn
      "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/2021_Facebook_icon.svg/2048px-2021_Facebook_icon.svg.png", // Facebook
      "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/2048px-Instagram_logo_2016.svg.png", // Instagram
    ];

    final row2 = [
      "https://assets-global.website-files.com/6257adef93867e56f84d3092/636e0a6a49cf127bf92de1e2_icon_cmyk_200.png", // Discord
      "https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Telegram_logo.svg/2048px-Telegram_logo.svg.png", // Telegram
      "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/Slack_icon_2019.svg/2048px-Slack_icon_2019.svg.png", // Slack
      "https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Pinterest-logo.png/600px-Pinterest-logo.png", // Pinterest
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Social integrations", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
          const SizedBox(height: 8),
          Text(
            "Over 30+ integrations including social, design, ecommerce and even our API.",
            style: TextStyle(color: bodyColor, fontSize: 13, height: 1.4),
          ),
          
          const SizedBox(height: 24),
          
          // Row 1 - Scrolling RighttoLeft
          SizedBox(
            height: 40,
            child: _SocialMarquee(icons: row1, reverse: false),
          ),
          
          const SizedBox(height: 16),
          
          // Row 2 - Scrolling LeftToRight (or same direction for consistency, user image shows grid)
          // The image shows a grid, but "slide" implies movement. Marquee is good. 
          SizedBox(
             height: 40,
             child: _SocialMarquee(icons: row2, reverse: true),
          ),

          const Spacer(),
          
          Row(
            children: [
              Text("Check all integrations", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textColor)),
              const SizedBox(width: 5),
              Icon(Icons.chevron_right, size: 16, color: iconColor?.withOpacity(0.7)),
            ],
          )
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pillBg = isDark ? const Color(0xFF2D303E) : Colors.white;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final borderColor = Theme.of(context).dividerColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: pillBg,
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

class _SocialMarquee extends StatefulWidget {
  final List<String> icons;
  final bool reverse;
  const _SocialMarquee({required this.icons, this.reverse = false});

  @override
  State<_SocialMarquee> createState() => _SocialMarqueeState();
}

class _SocialMarqueeState extends State<_SocialMarquee> with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this, 
      duration: const Duration(seconds: 10)
    )..addListener(() {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final offset = _animationController.value * maxScroll;
        // _scrollController.jumpTo(offset); // Manual control if needed, but simple ListView loop is better
      }
    }); // ..repeat(); 
    
    // Simple Auto-Scroll
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScrolling());
  }

  void _startScrolling() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Initial delay
    
    while (mounted) {
       if (!_scrollController.hasClients) {
         await Future.delayed(const Duration(milliseconds: 100));
         continue;
       }
       
       final maxScroll = _scrollController.position.maxScrollExtent;
       final current = _scrollController.offset;
       
       if (current >= maxScroll) {
         _scrollController.jumpTo(0);
       } else {
         // Calculate duration to maintain constant speed
         // Target speed: ~50 pixels per second
         final distance = maxScroll - current;
         final durationInSeconds = distance / 30.0; // 30 pixels per second is a good slow speed
         
         await _scrollController.animateTo(
           maxScroll, 
           duration: Duration(seconds: durationInSeconds.round()), 
           curve: Curves.linear,
         );
       }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1000, 
      itemBuilder: (context, index) {
        final iconUrl = widget.icons[index % widget.icons.length];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 2))
              ]
            ),
            padding: const EdgeInsets.all(8),
            child: Image.network(iconUrl, fit: BoxFit.contain),
          ),
        );
      },
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
     .fade(delay: Duration(milliseconds: widget.delay), duration: 400.ms);
  }
}