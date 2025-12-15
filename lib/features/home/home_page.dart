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
import 'widgets/cta_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 1. Create a ScrollController
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 2. Attach the controller to the SingleChildScrollView
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const HeroSection(),
                const AgentsSection(),
                const BentoGridSection(),
                const TargetAudienceSection(),
                const SocialTrendSection(),
                const ProductivitySection(),
                const CallToActionSection(),
                const LogoMarquee(),
                const Footer(),
            ],
          ),
          ),

          // 3. Pass the controller to the Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(scrollController: _scrollController),
          ),
        ],
      ),
    );
  }
}