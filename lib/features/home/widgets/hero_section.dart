import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/layout/responsive.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../../shared/widgets/fade_in_scroll.dart';
import 'infinite_scroll.dart'; 

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. CAPTURE THEME COLORS
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    
    return Responsive(
      // --- DESKTOP LAYOUT ---
      desktop: Container(
        color: bgColor,
        // CHANGED: Use alignment to center the constrained content
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          // CHANGED: Constrain max width to 1200 to match Navbar
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            // CHANGED: Match Navbar's internal horizontal padding (24) so alignment is perfect
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LEFT SIDE (Text Content)
                Expanded(
                  flex: 7, 
                  child: Padding(
                    padding: const EdgeInsets.only(top: 180),
                    child: _buildTextContent(context),
                  )
                ),
                
                const SizedBox(width: 40),
                
                // RIGHT SIDE (Scrolling Cards)
                Expanded(
                  flex: 5, 
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: SizedBox(
                      height: 550,
                      child: FadeInScroll(
                        duration: const Duration(milliseconds: 800),
                        slideOffset: const Offset(0.1, 0), // slideX equivalent
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            width: 450, 
                            child: _buildScrollingCards(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
      // MOBILE LAYOUT
      mobile: Container(
        color: bgColor,
        padding: const EdgeInsets.fromLTRB(20, 120, 20, 60),
        child: Column(
          children: [
            _buildTextContent(context, isCentered: true),
            const SizedBox(height: 60),
            FadeInScroll(
              duration: const Duration(milliseconds: 2000),
              child: SizedBox(
                height: 300,
                width: 340, 
                child: _buildScrollingCards(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SCROLLING CARDS LIST
  Widget _buildScrollingCards(BuildContext context) {
    return InfiniteScrollColumn(
      speed: 0.8, 
      items: const [
        // 1. Image Card (Dark)
        _HeroImageCard(
          text: "Transform your company into a digital leader.",
          imageUrl: "assets/images/business2.png",
          opacity: 0.6,
        ),
        
        // 2. Testimonial Card
        _HeroTestimonialCard(
          name: "Benjamin Austin",
          role: "CTO, Stanbic Bank",
          avatarUrl: "https://i.pravatar.cc/150?img=11",
        ),

        // 3. Image Card (Blue-ish)
        _HeroImageCard(
          text: "Get an all in one solution for your business with our bundle.",
          imageUrl: "assets/images/bundle1.png",
          opacity: 0.4,
          overlayColor: Color(0xFF1E1E2D),
        ),

        // 4. Testimonial Card
        _HeroTestimonialCard(
          name: "Sarah Jenkins",
          role: "Marketing Lead, Airtel",
          avatarUrl: "https://i.pravatar.cc/150?img=5",
        ),
      ],
    );
  }

  // --- TEXT CONTENT (Unchanged) ---
  Widget _buildTextContent(BuildContext context, {bool isCentered = false}) {
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final borderColor = Theme.of(context).dividerColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [

        FadeInScroll(
          duration: const Duration(milliseconds: 400),
          child: SizedBox(
            height: 160,
            child: DefaultTextStyle(
              textAlign: isCentered ? TextAlign.center : TextAlign.start,
              style: TextStyle(
                fontSize: 48,
                height: 1.1,
                fontWeight: FontWeight.w800,
                color: textColor,
                letterSpacing: -1.5,
                fontFamily: 'Inter',
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                pause: const Duration(seconds: 3),
                animatedTexts: [
                  TypewriterAnimatedText('We build software\nthat meets your business needs.', speed: const Duration(milliseconds: 100), cursor: '|'),
                  TypewriterAnimatedText('We build software\n that enhances efficiency and growth.', speed: const Duration(milliseconds: 100), cursor: '|'),
                ],
                onTap: () {},
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),
        
        FadeInScroll(
          delay: const Duration(milliseconds: 100),
          duration: const Duration(milliseconds: 400),
          child: Text(
            "Be part of the CissyTech ecosystem and drive your business forward.",
            textAlign: isCentered ? TextAlign.center : TextAlign.start,
            style: TextStyle(fontSize: 18, color: bodyColor, height: 1.5),
          ),
        ),

        const SizedBox(height: 40),
        
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: isCentered ? WrapAlignment.center : WrapAlignment.start,
          children: [
            FadeInScroll(
              delay: const Duration(milliseconds: 200),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 22),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Start Free Trial", style: TextStyle(fontSize: 16)),
              )
              .animate(onPlay: (c) => c.repeat())
              .shimmer(delay: 4000.ms, duration: 1800.ms, color: Colors.white.withOpacity(0.3)),
            ),

            FadeInScroll(
              delay: const Duration(milliseconds: 400),
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.play_arrow_rounded, color: textColor),
                label: Text("Watch Demo", style: TextStyle(color: isDark ? Colors.white : AppColors.brandGray, fontSize: 16)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                  side: BorderSide(color: isDark ? Colors.white.withOpacity(0.3) : AppColors.brandGray.withOpacity(0.5)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 40),
        
        FadeInScroll(
          delay: const Duration(milliseconds: 600),
          child: Wrap(
            alignment: isCentered ? WrapAlignment.center : WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 20,
            children: [
               Row(
                 mainAxisSize: MainAxisSize.min,
                 children: const [
                  _HoverAvatar(imagePath: "assets/images/bulk_sms.png"),
                  _HoverAvatar(imagePath: "assets/images/cissy_cloud.png"),
                  _HoverAvatar(imagePath: "assets/images/collecto_logo.png"),
                  _HoverAvatar(imagePath: "assets/images/eworker.png"),
                 ],
               ),
               Text(
                 "Trusted by 20+\ncompanies",
                 style: TextStyle(fontWeight: FontWeight.w600, color: bodyColor),
               ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HoverAvatar extends StatefulWidget {
  final String imagePath;
  const _HoverAvatar({required this.imagePath});

  @override
  State<_HoverAvatar> createState() => _HoverAvatarState();
}

class _HoverAvatarState extends State<_HoverAvatar> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).scaffoldBackgroundColor;

    return Align(
      widthFactor: 0.7,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedScale(
          scale: isHovered ? 1.2 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutBack,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: borderColor, width: 3), 
              boxShadow: [
                if (isHovered)
                  BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5))
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (c, o, s) => Container(color: Colors.grey.shade300),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- 1. DYNAMIC IMAGE CARD ---
class _HeroImageCard extends StatelessWidget {
  final String text;
  final String imageUrl;
  final double opacity;
  final Color overlayColor;

  const _HeroImageCard({
    required this.text,
    required this.imageUrl,
    this.opacity = 0.6,
    this.overlayColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: overlayColor,
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          opacity: opacity,
        ),
      ),
      alignment: Alignment.bottomLeft,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// --- 2. DYNAMIC TESTIMONIAL CARD ---
class _HeroTestimonialCard extends StatelessWidget {
  final String name;
  final String role;
  final String avatarUrl;

  const _HeroTestimonialCard({
    required this.name,
    required this.role,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final borderColor = Theme.of(context).dividerColor;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(avatarUrl),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                Text(role, style: TextStyle(color: bodyColor, fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.star, color: AppColors.accent, size: 20),
        ],
      ),
    );
  }
}

