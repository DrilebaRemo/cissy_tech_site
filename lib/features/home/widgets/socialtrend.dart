import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SocialTrendSection extends StatelessWidget {
  const SocialTrendSection({super.key});

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
          ),
          
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
          ),

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
          ),

          const SizedBox(height: 60),

          // 4. THE HORIZONTAL SCROLL AREA
          const SizedBox(
            height: 450, 
            child: _InfiniteHorizontalList(),
          ),
        ],
      ),
    );
  }
}

// --- PART 2: THE SCROLLING ENGINE ---
class _InfiniteHorizontalList extends StatefulWidget {
  const _InfiniteHorizontalList();

  @override
  State<_InfiniteHorizontalList> createState() => _InfiniteHorizontalListState();
}

class _InfiniteHorizontalListState extends State<_InfiniteHorizontalList> {
  late ScrollController _scrollController;
  late Timer _timer;
  
  final List<Map<String, dynamic>> _posts = [
    {
      "name": "The Modern Gamer",
      "handle": "X.com",
      "avatar": "https://i.pravatar.cc/150?img=11",
      "icon": Icons.close, 
      "text": "Activision has taken its Call of Duty game down from the Microsoft Store, reportedly due to security concerns.",
      "image": "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=500&q=80",
      "iconColor": Colors.black, // Will handle dynamic check later
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
            final post = _posts[index % _posts.length];
            return _SocialCard(post: post);
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
  final Map<String, dynamic> post;
  const _SocialCard({required this.post});

  @override
  Widget build(BuildContext context) {
    // 1. Capture Theme Colors for the Card
    final cardColor = Theme.of(context).cardColor;
    final borderColor = Theme.of(context).dividerColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Handle Icon Color: If it's the Black X icon, turn it White in Dark Mode
    Color iconColor = post['iconColor'];
    if (iconColor == Colors.black && isDark) {
      iconColor = Colors.white;
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
                backgroundImage: NetworkImage(post['avatar']),
                radius: 20,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textColor)),
                  Text(post['handle'], style: TextStyle(color: bodyColor, fontSize: 12)),
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
                child: Icon(post['icon'], size: 20, color: iconColor),
              )
            ],
          ),

          const SizedBox(height: 16),

          // Post Text
          Text(
            post['text'],
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
                post['image'],
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