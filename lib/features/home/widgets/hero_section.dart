import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/layout/responsive.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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
                    padding: const EdgeInsets.only(top: 185),
                    child: _buildTextContent(context),
                  )
                ),
                
                const SizedBox(width: 40),
                
                // RIGHT SIDE (Scrolling Cards)
                // This column now sits nicely under the right side of the Navbar
                Expanded(
                  flex: 5, 
                  child: Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: SizedBox(
                      height: 700,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: 450, 
                          child: _buildScrollingCards(context),
                        ),
                      ),
                    ).animate()
                     .fade(duration: 800.ms)
                     .slideX(begin: 0.1, end: 0, curve: Curves.easeOut),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
      // --- MOBILE LAYOUT (Unchanged) ---
      mobile: Container(
        color: bgColor,
        padding: const EdgeInsets.fromLTRB(20, 180, 20, 60),
        child: Column(
          children: [
            _buildTextContent(context, isCentered: true),
            const SizedBox(height: 60),
            SizedBox(
              height: 300,
              width: 340, 
              child: _buildScrollingCards(context),
            ).animate()
             .fade(duration: 800.ms)
             .slideY(begin: 0.1, end: 0),
          ],
        ),
      ),
    );
  }

  // --- THE SCROLLING CARDS LIST (Unchanged) ---
  Widget _buildScrollingCards(BuildContext context) {
    return InfiniteScrollColumn(
      speed: 0.8, 
      items: [
        _buildImageCard1(context),
        _buildTestimonialCard1(context),
        _buildImageCard2(context),
        _buildTestimonialCard2(context),
        _buildStatusCard(context),
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
        DefaultTextStyle(
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
              TypewriterAnimatedText('Software that\nmeans business.', speed: const Duration(milliseconds: 100), cursor: '|'),
              TypewriterAnimatedText('Software that\nscales effortlessly.', speed: const Duration(milliseconds: 100), cursor: '|'),
              TypewriterAnimatedText('Software that\nis secure.', speed: const Duration(milliseconds: 100), cursor: '|'),
            ],
            onTap: () {},
          ),
        ).animate().fade(duration: 600.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOut),

        const SizedBox(height: 24),
        
        Text(
          "Don't hire an expensive agency. Automate your workflow with CissyTech.",
          textAlign: isCentered ? TextAlign.center : TextAlign.start,
          style: TextStyle(fontSize: 18, color: bodyColor, height: 1.5),
        ).animate().fade(delay: 200.ms, duration: 600.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOut),

        const SizedBox(height: 40),
        
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: isCentered ? WrapAlignment.center : WrapAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? AppColors.primary : AppColors.textMain,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 22),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Start Free Trial", style: TextStyle(color: Colors.white, fontSize: 16)),
            )
            .animate(onPlay: (c) => c.repeat())
            .shimmer(delay: 4000.ms, duration: 1800.ms, color: Colors.white.withOpacity(0.3))
            .animate().fade(delay: 400.ms, duration: 600.ms).slideY(begin: 0.2, end: 0),

            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.play_arrow_rounded, color: textColor),
              label: Text("Watch Demo", style: TextStyle(color: textColor, fontSize: 16)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                side: BorderSide(color: borderColor),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ).animate().fade(delay: 400.ms, duration: 600.ms).slideY(begin: 0.2, end: 0),
          ],
        ),

        const SizedBox(height: 60),
        
        Wrap(
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
               "Trusted by 500+\ncompanies",
               style: TextStyle(fontWeight: FontWeight.w600, color: bodyColor),
             ),
          ],
        ).animate().fade(delay: 600.ms, duration: 600.ms).slideY(begin: 0.2, end: 0),
      ],
    );
  }

  // --- CARD HELPERS (Unchanged) ---
  Widget _buildImageCard1(BuildContext context) {
    return Container(
      height: 340,
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: NetworkImage("https://images.unsplash.com/photo-1522071820081-009f0129c71c?q=80&w=2070&auto=format&fit=crop"), 
          fit: BoxFit.cover,
          opacity: 0.6,
        ),
      ),
      alignment: Alignment.bottomLeft,
      child: const Text(
        "Transform your company into a digital leader.",
        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTestimonialCard1(BuildContext context) {
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
          const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=11"),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Benjamin Austin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                Text("CTO, Stanbic Bank", style: TextStyle(color: bodyColor, fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.star, color: AppColors.accent, size: 20),
        ],
      ),
    );
  }

  Widget _buildImageCard2(BuildContext context) {
    return Container(
      height: 320,
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2D),
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: NetworkImage("https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800&q=80"),
          fit: BoxFit.cover,
          opacity: 0.4,
        ),
      ),
      alignment: Alignment.bottomLeft,
      child: const Text(
        "Data-driven decisions made easy.",
        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTestimonialCard2(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final borderColor = Theme.of(context).dividerColor;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=5"),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sarah Jenkins", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
                Text("Marketing Lead, Airtel", style: TextStyle(color: bodyColor, fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.star, color: AppColors.accent, size: 20),
        ],
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final cardBg = isDark ? Colors.green.withOpacity(0.1) : const Color(0xFFF0FDF4);
    final borderColor = isDark ? Colors.green.withOpacity(0.3) : Colors.green.shade100;
    final innerCircleColor = isDark ? const Color(0xFF1E1E2D) : Colors.white;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardBg, 
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: innerCircleColor, shape: BoxShape.circle),
            child: const Icon(Icons.check_circle, color: Colors.green, size: 24),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              "System Operational\n99.9% Uptime Verified",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.green),
            ),
          ),
        ],
      ),
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