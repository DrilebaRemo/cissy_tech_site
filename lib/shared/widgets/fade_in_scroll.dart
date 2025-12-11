import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FadeInScroll extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset slideOffset;

  const FadeInScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 300), // Much faster default
    this.slideOffset = const Offset(0, 0.1), // Smaller slide for faster feel 
  });

  @override
  State<FadeInScroll> createState() => _FadeInScrollState();
}

class _FadeInScrollState extends State<FadeInScroll> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isVisible = false;
  final Key _key = UniqueKey(); // Unique key for visibility detector

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: (info) {
        if (!_isVisible && info.visibleFraction > 0.1) {
          setState(() => _isVisible = true);
          // Play current animation
          // Note: We don't need to manually forward the controller if we use Animate(controller: ...) 
          // or just rely on the 'target' param or rebuilding.
          // Ideally, we want to start the animation ONCE.
        }
      },
      child: _isVisible
          ? Animate(
              delay: widget.delay,
              effects: [
                FadeEffect(duration: widget.duration, curve: Curves.easeOut),
                SlideEffect(
                  duration: widget.duration,
                  begin: widget.slideOffset,
                  end: Offset.zero,
                  curve: Curves.easeOut,
                ),
              ],
              child: widget.child,
            )
          : Opacity(
              // Keep it invisible and in layout until it animates
              opacity: 0, 
              child: widget.child
            ),
    );
  }
}
