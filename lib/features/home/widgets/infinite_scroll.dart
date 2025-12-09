import 'dart:async';
import 'package:flutter/material.dart';

class InfiniteScrollColumn extends StatefulWidget {
  final List<Widget> items; 
  final double speed;
  final bool reverse;

  const InfiniteScrollColumn({
    super.key,
    required this.items, 
    this.speed = 1.0,
    this.reverse = false,
  });

  @override
  State<InfiniteScrollColumn> createState() => _InfiniteScrollColumnState();
}

class _InfiniteScrollColumnState extends State<InfiniteScrollColumn> {
  late ScrollController _scrollController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  void _startScrolling() {
    _timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (!_scrollController.hasClients) return;
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.offset;
      double nextScroll = currentScroll + (widget.reverse ? -widget.speed : widget.speed);

      if (nextScroll >= maxScroll) {
        _scrollController.jumpTo(0);
      } else if (nextScroll <= 0) {
        _scrollController.jumpTo(maxScroll);
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
    // Capture dynamic background color for the bottom fade
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return SizedBox(
      width: double.infinity, 
      child: Stack(
        children: [
          // 1. The Scrolling List
          ListView.builder(
            controller: _scrollController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 1000, 
            itemBuilder: (context, index) {
              final item = widget.items[index % widget.items.length];
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: item,
              );
            },
          ),
          
          // 2. Bottom Fog (Modified to be dynamic and only at bottom)
          // We removed the Top Fog so items appear to scroll "into" the navbar area.
          Positioned(
            bottom: 0, left: 0, right: 0, height: 80,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    bgColor, // Solid Theme Color at bottom
                    bgColor.withOpacity(0.0), // Transparent going up
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}