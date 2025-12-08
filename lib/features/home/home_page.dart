import 'package:flutter/material.dart';
import '../../shared/layout/navbar.dart';
import 'widgets/hero_section.dart';
import 'widgets/logo_marquee.dart';
import 'widgets/agents_sec.dart';
import 'widgets/bento_grid.dart';
import 'widgets/target.dart';
import 'widgets/socialtrend.dart';
import 'widgets/product.dart';
import 'widgets/packages.dart';
import '../../shared/layout/footer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. The Scrolling Content (Behind the Navbar)
          const SingleChildScrollView(
            child: Column(
              children: [
                const HeroSection(), // Includes the scrolling images
                const LogoMarquee(),
                const AgentsSection(),
                const BentoGridSection(),
                const TargetAudienceSection(),
                const SocialTrendSection(),
                const ProductivitySection(),
                const PricingSection(),
                const Footer(), // Temp spacer to prove scrolling works
              ],
            ),
          ),

          // 2. The Sticky/Floating Navbar (On Top)
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(),
          ),
        ],
      ),
    );
  }
}