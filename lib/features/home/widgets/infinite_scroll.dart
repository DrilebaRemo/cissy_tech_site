import 'dart:async';
import 'package:flutter/material.dart';

class InfiniteScrollColumn extends StatefulWidget {
  // CHANGED: Now accepts a list of Widgets (Cards), not just image strings
  final List<Widget> children; 
  final double speed;
  final bool reverse;

  const InfiniteScrollColumn({
    super.key,
    required this.children,
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
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScrolling());
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
    // Made width flexible (null) so it fills the parent container
    return SizedBox(
      height: 600, 
      child: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 1000, // Infinite loop illusion
            itemBuilder: (context, index) {
              // Get the widget from the list based on index
              final child = widget.children[index % widget.children.length];
              return Padding(
                padding: const EdgeInsets.only(bottom: 24), // Gap between cards
                child: child,
              );
            },
          ),
          
          // Top Fog
          Positioned(
            top: 0, left: 0, right: 0, height: 100,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white.withOpacity(0.0)],
                ),
              ),
            ),
          ),
          
          // Bottom Fog
          Positioned(
            bottom: 0, left: 0, right: 0, height: 150,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.white, Colors.white.withOpacity(0.0)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}