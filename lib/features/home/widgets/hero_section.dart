import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/layout/responsive.dart';
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
        color: bgColor, // Dynamic Background
        padding: const EdgeInsets.fromLTRB(60, 185, 60, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT SIDE
            Expanded(flex: 7, child: _buildTextContent(context)),
            
            const SizedBox(width: 40),
            
            // RIGHT SIDE
            Expanded(
              flex: 5, 
              child: SizedBox(
                height: 700,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: 450, 
                    child: _buildScrollingCards(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      
      // --- MOBILE LAYOUT ---
      mobile: Container(
        color: bgColor, // Dynamic Background
        padding: const EdgeInsets.fromLTRB(20, 180, 20, 60),
        child: Column(
          children: [
            _buildTextContent(context, isCentered: true),
            const SizedBox(height: 60),
            SizedBox(
              height: 300,
              width: 340, 
              child: _buildScrollingCards(context),
            ),
          ],
        ),
      ),
    );
  }

  // --- THE SCROLLING CARDS LIST ---
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

  // --- CARD 1: Digital Leader ---
  Widget _buildImageCard1(BuildContext context) {
    return Container(
      height: 340,
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.black, // Keep this dark for contrast with white text, or use cardColor
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

  // --- CARD 2: Benjamin Testimonial ---
  Widget _buildTestimonialCard1(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final borderColor = Theme.of(context).dividerColor;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor, // Dynamic
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: borderColor), // Dynamic
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

  // --- CARD 3: Data/Analytics ---
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

  // --- CARD 4: Sarah Testimonial ---
  Widget _buildTestimonialCard2(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final borderColor = Theme.of(context).dividerColor;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: cardColor, // Dynamic
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor), // Dynamic
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

  // --- CARD 5: Status Card ---
  Widget _buildStatusCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // In Dark Mode, make the green background darker/transparent so it's not blinding
    final cardBg = isDark ? Colors.green.withOpacity(0.1) : const Color(0xFFF0FDF4);
    final borderColor = isDark ? Colors.green.withOpacity(0.3) : Colors.green.shade100;
    // In Dark Mode, the inner circle needs to be dark grey/black
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



  // --- TEXT CONTENT ---
  Widget _buildTextContent(BuildContext context, {bool isCentered = false}) {
    // Capture colors
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final bodyColor = Theme.of(context).textTheme.bodyLarge?.color;
    final borderColor = Theme.of(context).dividerColor;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: isCentered ? TextAlign.center : TextAlign.start,
          text: TextSpan(
            style: TextStyle(
              fontSize: 48,
              height: 1.1,
              fontWeight: FontWeight.w800,
              color: textColor, // Dynamic Headline
              letterSpacing: -1.5,
              fontFamily: 'Inter',
            ),
            children: const [
              TextSpan(text: "Software that\n"),
              TextSpan(
                text: "means business.",
                style: TextStyle(color: AppColors.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Don't hire an expensive agency. Automate your workflow with CissyTech.",
          textAlign: isCentered ? TextAlign.center : TextAlign.start,
          style: TextStyle(fontSize: 18, color: bodyColor, height: 1.5), // Dynamic Body
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: isCentered ? WrapAlignment.center : WrapAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                // Dark Mode: Primary Color, Light Mode: Dark Grey
                backgroundColor: isDark ? AppColors.primary : AppColors.textMain,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 22),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Start Free Trial", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.play_arrow_rounded, color: textColor), // Dynamic
              label: Text("Watch Demo", style: TextStyle(color: textColor, fontSize: 16)), // Dynamic
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                side: BorderSide(color: borderColor), // Dynamic
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
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
                _HoverAvatar(imagePath: "assets/images/collecto.png"),
                _HoverAvatar(imagePath: "assets/images/eworker.png"),
               ],
             ),
             Text(
               "Trusted by 500+\ncompanies",
               style: TextStyle(fontWeight: FontWeight.w600, color: bodyColor), // Dynamic
             ),
          ],
        )
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
    // The border color must match the background color to create the "cutout" effect
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
              color: Colors.white, // Keep inner white or match cardColor depending on logo transparency
              shape: BoxShape.circle,
              border: Border.all(color: borderColor, width: 3), // Dynamic Border Match
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