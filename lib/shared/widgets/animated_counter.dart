import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedCounter extends StatefulWidget {
  final num targetValue;
  final String suffix;
  final String prefix;
  final String label;
  final Color color;
  final bool isInt; // true for 100, false for 99.9

  const AnimatedCounter({
    super.key,
    required this.targetValue,
    required this.label,
    required this.color,
    this.suffix = "",
    this.prefix = "",
    this.isInt = true,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasPlayed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Takes 2 seconds to count up
    );
    
    // Animate from 0 to target
    _animation = Tween<double>(begin: 0, end: widget.targetValue.toDouble())
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.displayLarge?.color;

    return VisibilityDetector(
      key: Key("counter-${widget.label}"),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5 && !_hasPlayed) {
          _controller.forward();
          _hasPlayed = true; // Only play once
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              String valueDisplay;
              if (widget.isInt) {
                valueDisplay = _animation.value.toInt().toString();
              } else {
                valueDisplay = _animation.value.toStringAsFixed(1);
              }

              return Text(
                "${widget.prefix}$valueDisplay${widget.suffix}",
                style: TextStyle(
                  fontSize: 32, // Big numbers
                  fontWeight: FontWeight.w800,
                  color: widget.color,
                  letterSpacing: -1.0,
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}