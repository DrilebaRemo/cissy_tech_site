import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';

class SocialTrendSection extends StatelessWidget {
  const SocialTrendSection({super.key});

  static const List<Map<String, dynamic>> _posts = [
    {
      "name": "The Modern Gamer",
      "handle": "X.com",
      "avatar": "https://i.pravatar.cc/150?img=11",
      "icon": Icons.close, 
      "text": "Activision has taken its Call of Duty game down from the Microsoft Store, reportedly due to security concerns.",
      "image": "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=500&q=80",
      "iconColor": Colors.black, 
    },
    {
      "name": "AI News Daily",
      "handle": "Facebook",
      "avatar": "https://i.pravatar.cc/150?img=3",
      "icon": Icons.facebook,
      "text": "Elon Musk is back in the spotlight with Grok 4, promising a 'ludicrous rate of progress' in AI development.",
      "image": "https://images.unsplash.com/photo-1620712943543-bcc4688e7485?w=500&q=80",
      "iconColor": Colors.blue,
    },
    {
      "name": "Bioscience Genius",
      "handle": "Instagram",
      "avatar": "https://i.pravatar.cc/150?img=5",
      "icon": Icons.camera_alt,
      "text": "Amoebas are BACK in the spotlight - single-celled, shapeshifting, and still ruling the microbial world.",
      "image": "https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=500&q=80",
      "iconColor": Colors.pink,
    },
    {
      "name": "Tech Insider",
      "handle": "LinkedIn",
      "avatar": "https://i.pravatar.cc/150?img=8",
      "icon": Icons.business,
      "text": "Market trends show a massive shift towards automated content creation tools in 2025.",
      "image": "https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=500&q=80",
      "iconColor": Colors.blueAccent,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // 1. Capture Theme Colors
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final iconColor = Theme.of(context).iconTheme.color;

    return Container(
      color: bgColor, // <--- Dynamic Background
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        children: [
          // 1. HEADLINE
          Text(
            "Keep your socials on-trend.",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w800,
              color: textColor, // <--- Dynamic Text
              letterSpacing: -1.5,
            ),
            textAlign: TextAlign.center,
          ).animate()
           .fade(duration: 800.ms)
           .slideY(begin: 0.3, end: 0, curve: Curves.easeOut),
          
          const SizedBox(height: 16),

          // 2. SUBTITLE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Consistency is key. With our intuitive calendar, you'll never\nmiss a chance to stay active and engaging.",
              style: TextStyle(
                fontSize: 18,
                color: bodyColor, // <--- Dynamic Text
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ).animate()
           .fade(delay: 200.ms, duration: 800.ms)
           .slideY(begin: 0.3, end: 0, curve: Curves.easeOut),


          const SizedBox(height: 24),

          // 3. CTA LINK
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Try calendar",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: textColor, // <--- Dynamic Text
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right, size: 18, color: iconColor?.withOpacity(0.7)),
            ],
          ).animate()
           .fade(delay: 400.ms, duration: 800.ms)
           .slideY(begin: 0.3, end: 0, curve: Curves.easeOut),

          const SizedBox(height: 60),

          // 4. THE HORIZONTAL SCROLL AREA
          SizedBox(
            height: 450, 
            child: _InfiniteHorizontalList(posts: _posts),
          ).animate()
           .fade(delay: 400.ms, duration: 800.ms)
           .slideY(begin: 0.1, end: 0, curve: Curves.easeOut),
        ],
      ),
    );
  }
}

// --- PART 2: THE SCROLLING ENGINE ---
class _InfiniteHorizontalList extends StatefulWidget {
  final List<Map<String, dynamic>> posts;
  const _InfiniteHorizontalList({required this.posts});

  @override
  State<_InfiniteHorizontalList> createState() => _InfiniteHorizontalListState();
}

class _InfiniteHorizontalListState extends State<_InfiniteHorizontalList> {
  late ScrollController _scrollController;
  late Timer _timer;
  
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScrolling());
  }

  void _startScrolling() {
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
    // Capture the background color for the gradient fade
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Stack(
      children: [
        // A. The List
        ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 1000, 
          itemBuilder: (context, index) {
            final post = widget.posts[index % widget.posts.length];
            return _SocialCard(
              name: post['name'],
              handle: post['handle'],
              avatar: post['avatar'],
              icon: post['icon'],
              text: post['text'],
              image: post['image'],
              iconColor: post['iconColor'],
            );
          },
        ),

        // B. Left Gradient (Fade)
        Positioned(
          left: 0, top: 0, bottom: 0,
          width: 150,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  bgColor, // Solid color
                  bgColor.withOpacity(0.0) // Transparent
                ],
              ),
            ),
          ),
        ),

        // C. Right Gradient (Fade)
        Positioned(
          right: 0, top: 0, bottom: 0,
          width: 150,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  bgColor, // Solid color
                  bgColor.withOpacity(0.0) // Transparent
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// --- PART 3: THE INDIVIDUAL CARD DESIGN ---
class _SocialCard extends StatelessWidget {
  final String name;
  final String handle;
  final String avatar;
  final IconData icon;
  final String text;
  final String image;
  final Color iconColor;

  const _SocialCard({
    required this.name,
    required this.handle,
    required this.avatar,
    required this.icon,
    required this.text,
    required this.image,
    required this.iconColor,
  });
  @override
  Widget build(BuildContext context) {
    // 1. Capture Theme Colors for the Card
    final cardColor = Theme.of(context).cardColor;
    final borderColor = Theme.of(context).dividerColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Handle Icon Color: If it's the Black X icon, turn it White in Dark Mode
    Color finalIconColor = iconColor;
    if (iconColor == Colors.black && isDark) {
      finalIconColor = Colors.white;
    }

    return Container(
      width: 350,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor, // <--- Dynamic Card Background
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor), // <--- Dynamic Border
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar + Name + Icon
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(avatar),
                radius: 20,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textColor)),
                  Text(handle, style: TextStyle(color: bodyColor, fontSize: 12)),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  // Slightly lighter/darker circle for the icon
                  color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 20, color: iconColor),
              )
            ],
          ),

          const SizedBox(height: 16),

          // Post Text
          Text(
            text,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: bodyColor, fontSize: 15, height: 1.5), // <--- Dynamic Text
          ),

          const SizedBox(height: 20),

          // Post Image
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}