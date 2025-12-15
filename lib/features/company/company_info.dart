import 'package:flutter/material.dart';
import '../../shared/layout/navbar.dart';
import '../../shared/layout/footer.dart';
import 'widgets/about_hero.dart';
import 'widgets/vision_mission.dart';
import 'widgets/core_values.dart';
import 'widgets/faq_section.dart';

class CompanyInfoPage extends StatefulWidget {
  const CompanyInfoPage({super.key});

  @override
  State<CompanyInfoPage> createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends State<CompanyInfoPage> {
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
          // 1. SCROLLABLE CONTENT
          SingleChildScrollView(
            controller: _scrollController,
            child: const Column(
              children: [
                AboutHero(),
                VisionMissionSection(),
                CoreValuesSection(),
                FaqSection(),
                Footer(),
              ],
            ),
          ),

          // 2. NAVBAR (Floating)
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