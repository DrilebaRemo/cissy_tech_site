import 'package:flutter/material.dart';
import '../../shared/layout/navbar.dart';
import '../../shared/layout/footer.dart';
import 'widgets/company_image_strip.dart';
import 'widgets/mission_headline.dart';
import 'widgets/info_card_grid.dart';
import 'widgets/innovation_section.dart';
import 'widgets/ceo_section.dart';
import 'widgets/purpose_section.dart';
import 'widgets/grow_section.dart';


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
                SizedBox(height: 140),
                CompanyImageStrip(),
                MissionHeadline(),
                InfoCardGrid(),
                InnovationSection(),
                CeoSection(),
                PurposeSection(),
                GrowSection(),
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