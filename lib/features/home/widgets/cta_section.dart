import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';

class CallToActionSection extends StatelessWidget {
  const CallToActionSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme logic
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Background: Dark in both modes for contrast, or dynamic. 
    // Usually CTAs pop best when they are dark with bright text.
    final containerColor = isDark ? Colors.black : const Color(0xFF0F1016);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor, // Matches page bg
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              // 1. ANIMATED AURORA BACKGROUND
              // We layer multiple containers with gradients and animate their opacity/position
              Positioned.fill(
                child: Container(color: containerColor),
              ),
              
              // Gradient Blob 1 (Blue) - Moving Top Left to Bottom Right
              Positioned(
                top: -100, left: -100,
                child: Container(
                  width: 400, height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withOpacity(0.4),
                    backgroundBlendMode: BlendMode.screen, // Cool blending effect
                  ),
                ).animate(onPlay: (c) => c.repeat(reverse: true))
                 .scale(begin: const Offset(1,1), end: const Offset(1.5, 1.5), duration: 4.seconds)
                 .move(begin: const Offset(0,0), end: const Offset(50, 50), duration: 4.seconds),
              ),

              // Gradient Blob 2 (Orange) - Moving Bottom Right to Top Left
              Positioned(
                bottom: -100, right: -100,
                child: Container(
                  width: 300, height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent.withOpacity(0.3),
                    backgroundBlendMode: BlendMode.screen,
                  ),
                ).animate(onPlay: (c) => c.repeat(reverse: true))
                 .scale(begin: const Offset(1,1), end: const Offset(1.2, 1.2), duration: 3.seconds)
                 .move(begin: const Offset(0,0), end: const Offset(-30, -30), duration: 5.seconds),
              ),

              // Gradient Blob 3 (Purple) - Breathing in center
              Positioned.fill(
                child: Center(
                  child: Container(
                    width: 600, height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.purple.withOpacity(0.2),
                      backgroundBlendMode: BlendMode.screen,
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ).animate(onPlay: (c) => c.repeat(reverse: true))
                   .fade(begin: 0.2, end: 0.5, duration: 2.seconds),
                ),
              ),
              
              // Glassmorphism Overlay (Blur) to smooth out the blobs
              Positioned.fill(
                child: Container( // Using a container with backdrop filter
                   decoration: BoxDecoration(
                     color: Colors.black.withOpacity(0.1), // Slight tint
                   ),
                ),
              ),

              // 2. CONTENT
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Ready to scale your business?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w800,
                        color: Colors.white, // Always white on this dark background
                        letterSpacing: -1.0,
                      ),
                    ).animate().fade().slideY(begin: 0.3, end: 0),
                    
                    const SizedBox(height: 16),
                    
                    const Text(
                      "Join 500+ companies using CissyTech to \nautomate and grow their operations.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ).animate().fade(delay: 200.ms).slideY(begin: 0.3, end: 0),

                    const SizedBox(height: 40),

                    // 3. PULSING BUTTON
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                          elevation: 10,
                          shadowColor: Colors.white.withOpacity(0.3),
                        ),
                        child: const Text(
                          "Get Started for free",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                    .animate(onPlay: (c) => c.repeat(reverse: true)) // Heartbeat loop
                    .scale(begin: const Offset(1,1), end: const Offset(1.05, 1.05), duration: 1.seconds) // Pulse
                    .animate() // Entrance
                    .fade(delay: 400.ms)
                    .slideY(begin: 0.3, end: 0),
                    
                    const SizedBox(height: 20),
                    
                    const Text(
                      "No credit card required. Cancel anytime.",
                      style: TextStyle(color: Colors.white30, fontSize: 13),
                    ).animate().fade(delay: 600.ms),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}