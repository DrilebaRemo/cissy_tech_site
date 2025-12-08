import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/layout/responsive.dart';
import 'infinite_scroll.dart'; 

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      // --- DESKTOP LAYOUT ---
      desktop: Container(
        color: AppColors.background,
        padding: const EdgeInsets.fromLTRB(60, 185, 60, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT SIDE (Text): Give it more space (Flex 7)
            Expanded(flex: 7, child: _buildTextContent(context)),
            
            const SizedBox(width: 40),
            
            // RIGHT SIDE (Cards): Make it smaller (Flex 5)
            Expanded(
              flex: 5, 
              child: SizedBox(
                height: 700,
                // Alignment TopCenter ensures it aligns with the text top
                child: Align(
                  alignment: Alignment.topCenter,
                  // CONSTRAINT: Lock width to 360px so cards look like phone widgets
                  child: SizedBox(
                    width: 450, 
                    child: _buildScrollingCards(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      
      // --- MOBILE LAYOUT ---
      mobile: Container(
        color: AppColors.background,
        padding: const EdgeInsets.fromLTRB(20, 180, 20, 60),
        child: Column(
          children: [
            _buildTextContent(context, isCentered: true),
            const SizedBox(height: 60),
            // Mobile: Shorter scroll area
            SizedBox(
              height: 300,
              width: 340, // Slightly smaller for mobile screens
              child: _buildScrollingCards(),
            ),
          ],
        ),
      ),
    );
  }

  // --- THE SCROLLING CARDS LIST ---
  Widget _buildScrollingCards() {
    return InfiniteScrollColumn(
      speed: 0.8, 
      items: [
        _buildImageCard1(),
        _buildTestimonialCard1(),
        _buildImageCard2(),
        _buildTestimonialCard2(),
        _buildStatusCard(),
      ],
    );
  }

  // --- CARD 1: Digital Leader (Smaller Height) ---
  Widget _buildImageCard1() {
    return Container(
      height: 340, // Reduced from 300
      width: double.infinity,
      padding: const EdgeInsets.all(40), // Reduced from 40
      decoration: BoxDecoration(
        color: AppColors.textMain, 
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
        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), // Font 24 -> 20
      ),
    );
  }

  // --- CARD 2: Benjamin Testimonial (Tighter Padding) ---
  Widget _buildTestimonialCard1() {
    return Container(
      padding: const EdgeInsets.all(24), // Reduced from 30
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24, // Smaller Avatar
            backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=11"),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Benjamin Austin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("CTO, Stanbic Bank", style: TextStyle(color: AppColors.textBody, fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.star, color: AppColors.accent, size: 20),
        ],
      ),
    );
  }

  // --- CARD 3: Data/Analytics (Smaller Height) ---
  Widget _buildImageCard2() {
    return Container(
      height: 320, // Reduced from 280
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
  Widget _buildTestimonialCard2() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
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
              children: const [
                Text("Sarah Jenkins", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("Marketing Lead, Airtel", style: TextStyle(color: AppColors.textBody, fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.star, color: AppColors.accent, size: 20),
        ],
      ),
    );
  }

  // --- CARD 5: Status Card ---
  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
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



  // --- TEXT CONTENT (Same as before) ---
  Widget _buildTextContent(BuildContext context, {bool isCentered = false}) {
    return Column(
      crossAxisAlignment: isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: isCentered ? TextAlign.center : TextAlign.start,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 48,
              height: 1.1,
              fontWeight: FontWeight.w800,
              color: AppColors.textMain,
              letterSpacing: -1.5,
              fontFamily: 'Inter',
            ),
            children: [
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
          style: const TextStyle(fontSize: 18, color: AppColors.textBody, height: 1.5),
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
                backgroundColor: AppColors.textMain,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 22),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Start Free Trial", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow_rounded, color: AppColors.textMain),
              label: const Text("Watch Demo", style: TextStyle(color: AppColors.textMain, fontSize: 16)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                side: const BorderSide(color: AppColors.border),
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
             const Text(
               "Trusted by 500+\ncompanies",
               style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textBody),
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
              border: Border.all(color: Colors.white, width: 3),
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