import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    // We wrap the navbar in a Center + ConstrainedBox to stop it from stretching too wide on huge screens
    return Center(
      child: Container(
        height: 70,
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20), // "Floating" margin
        constraints: const BoxConstraints(maxWidth: 1200), // Max width like the screenshot
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16), // Rounded corners
          border: Border.all(color: AppColors.border), // Subtle border
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            // 1. LOGO
            Image.asset(
                'assets/images/cissy_logo.png', 
                height: 32, // Adjust height to fit the navbar (usually 30-40px is good)
                fit: BoxFit.contain, // Ensures the logo doesn't get stretched/distorted
            ), // Ocoya style icon
            const SizedBox(width: 8),
            const Text(
              "CissyTech",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),

            const Spacer(),

            // 2. NAV LINKS (Hidden on Mobile)
            // Use a LayoutBuilder or simple check in real apps, for now we assume desktop
            if (MediaQuery.of(context).size.width > 800)
              Row(
                children: [
                  _navLink("Features", showArrow: true),
                  _navLink("Integrations", isNew: true),
                  _navLink("Pricing"),
                  _navLink("Company"),
                ],
              ),

            const Spacer(),

            // 3. ACTION BUTTONS
            TextButton(
              onPressed: () {},
              child: const Text("Login", style: TextStyle(color: Colors.black)),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1F2937), // Dark grey/black
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              child: const Text("Try free"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navLink(String text, {bool showArrow = false, bool isNew = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
          if (showArrow) const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
          if (isNew) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "New",
                style: TextStyle(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ),
          ]
        ],
      ),
    );
  }
}