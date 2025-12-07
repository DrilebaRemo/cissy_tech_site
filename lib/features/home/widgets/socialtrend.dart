import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SocialTrendSection extends StatelessWidget {
  const SocialTrendSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        children: [
          // 1. HEADLINE
          const Text(
            "Keep your socials on-trend.",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              letterSpacing: -1.5,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),

          // 2. SUBTITLE
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Consistency is key. With our intuitive calendar, you'll never\nmiss a chance to stay active and engaging.",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textBody,
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
              const Text(
                "Try calendar",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right, size: 18, color: Colors.black.withOpacity(0.7)),
            ],
          ),

          const SizedBox(height: 60),

          // 4. THE HORIZONTAL SCROLL AREA
          const SizedBox(
            height: 450, // Height of the card + shadows
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
  
  // Fake Data for the cards
  final List<Map<String, dynamic>> _posts = [
    {
      "name": "The Modern Gamer",
      "handle": "X.com",
      "avatar": "https://i.pravatar.cc/150?img=11",
      "icon": Icons.close, // Representing X
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
      // Scroll speed (1.0 is slow and smooth)
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
    return Stack(
      children: [
        // A. The List
        ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(), // Disable manual scroll
          itemCount: 1000, // Infinite illusion
          itemBuilder: (context, index) {
            final post = _posts[index % _posts.length];
            return _SocialCard(post: post);
          },
        ),

        // B. Left Gradient (The White Blur)
        Positioned(
          left: 0, top: 0, bottom: 0,
          width: 150,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.white, Colors.white.withOpacity(0.0)],
              ),
            ),
          ),
        ),

        // C. Right Gradient (The White Blur)
        Positioned(
          right: 0, top: 0, bottom: 0,
          width: 150,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [Colors.white, Colors.white.withOpacity(0.0)],
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
    return Container(
      width: 350,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
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
                  Text(post['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(post['handle'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(post['icon'], size: 20, color: post['iconColor']),
              )
            ],
          ),

          const SizedBox(height: 16),

          // Post Text
          Text(
            post['text'],
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.textBody, fontSize: 15, height: 1.5),
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