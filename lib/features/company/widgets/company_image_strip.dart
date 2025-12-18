import 'dart:async';
import 'package:flutter/material.dart';
import '../../../shared/widgets/fade_in_scroll.dart';

class CompanyImageStrip extends StatefulWidget {
  const CompanyImageStrip({super.key});

  @override
  State<CompanyImageStrip> createState() => _CompanyImageStripState();
}

class _CompanyImageStripState extends State<CompanyImageStrip> {
  late ScrollController _scrollController;
  late Timer _timer;

  // Placeholder images (Technology, People, Innovation)
  final List<String> _images = [
    "https://images.unsplash.com/photo-1531482615713-2afd69097998?w=800&q=80",
    "https://images.unsplash.com/photo-1573164713988-8665fc963095?w=800&q=80",
    "https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=800&q=80",
    "https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=800&q=80",
    "https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=800&q=80",
    "https://images.unsplash.com/photo-1556761175-5973dc0f32e7?w=800&q=80",
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Start auto-scroll after build
    WidgetsBinding.instance.addPostFrameCallback((_) => _startAutoScroll());
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (!_scrollController.hasClients) return;
      
      // Infinite scroll logic
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent) {
        _scrollController.jumpTo(0);
      } else {
        _scrollController.jumpTo(_scrollController.offset + 1);
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
    return FadeInScroll(
      duration: const Duration(milliseconds: 800),
      child: Container(
        height: 280, // Google style height
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          // Render infinite items artificially
          itemCount: 1000, 
          itemBuilder: (context, index) {
            final image = _images[index % _images.length];
            return Container(
              width: 320,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32), // Extreme Google Roundness
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}