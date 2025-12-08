import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Check if we are on mobile
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Center(
      child: Container(
        height: 70,
        // Responsive margins: Smaller on mobile so it looks wider
        margin: EdgeInsets.only(
          top: 20, 
          left: isMobile ? 16 : 24, 
          right: isMobile ? 16 : 24
        ),
        constraints: const BoxConstraints(maxWidth: 1200), // Max width constraint
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
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
            // --- LEFT: LOGO ---
            Image.asset(
              'assets/images/cissy_logo.png', 
              height: 28, 
              errorBuilder: (c,o,s) => const Icon(Icons.layers)
            ),
            const SizedBox(width: 8),
            const Text(
              "CissyTech", 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),

            // --- SPACER 1 ---
            // This pushes everything after the logo to the right
            const Spacer(),

            // --- CENTER & RIGHT CONTENT ---
            
            if (isMobile) ...[
              // MOBILE LAYOUT: Logo - Spacer - Icon
              // Because there is only 1 spacer, this icon gets pushed to the far right
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const _MobileMenuDialog(),
                  );
                },
              ),
            ] else ...[
              // DESKTOP LAYOUT: Logo - Spacer - Links - Spacer - Buttons
              
              // 1. Navigation Links
              _navLink("Features"),
              _navLink("Products"),
              _navLink("Pricing"),
              _navLink("Contact"),

              // 2. Second Spacer to push buttons to the end
              const Spacer(),

              // 3. Action Buttons
              TextButton(
                onPressed: () {}, 
                child: const Text("Login", style: TextStyle(color: Colors.black))
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F2937),
                  foregroundColor: Colors.white,
                ),
                child: const Text("Get Started"),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _navLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}

// (Keep your _MobileMenuDialog class exactly as it was before)
class _MobileMenuDialog extends StatelessWidget {
  const _MobileMenuDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Menu", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              ],
            ),
            const Divider(),
            _mobileLink("Features"),
            _mobileLink("Products"),
            _mobileLink("Pricing"),
            _mobileLink("Contact"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
              child: const Text("Get Started"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mobileLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
    );
  }
}