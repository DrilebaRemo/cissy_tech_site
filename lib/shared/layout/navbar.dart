import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_controller.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;
    
    // 1. Get Dynamic Colors
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final borderColor = Theme.of(context).dividerColor;
    final iconColor = Theme.of(context).iconTheme.color;

    return Center(
      child: Container(
        height: 70,
        margin: EdgeInsets.only(
          top: 20, 
          left: isMobile ? 16 : 24, 
          right: isMobile ? 16 : 24
        ),
        constraints: const BoxConstraints(maxWidth: 1200),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
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
              'assets/images/cissy_logo.png', // Ensure this matches your file name
              height: 28, 
            ),
            const SizedBox(width: 8),
            Text(
              "CissyTech", 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)
            ),

            // --- SPACER ---
            const Spacer(),

            // --- THEME TOGGLE (Visible on Desktop, moved to menu on Mobile) ---
            if (!isMobile) ...[
               IconButton(
                onPressed: () {
                  ThemeController.instance.toggleTheme();
                },
                icon: Icon(
                  isDark ? Icons.light_mode : Icons.dark_mode_outlined,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 10),
            ],

            // --- CENTER & RIGHT CONTENT ---
            if (isMobile) ...[
              // MOBILE LAYOUT
              IconButton(
                icon: Icon(Icons.menu, color: iconColor),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const _MobileMenuDialog(),
                  );
                },
              ),
            ] else ...[
              // DESKTOP LAYOUT
              _navLink("Features", textColor),
              _navLink("Products", textColor),
              _navLink("Pricing", textColor),
              _navLink("Contact", textColor),

              const SizedBox(width: 20),

              TextButton(
                onPressed: () {}, 
                child: Text("Login", style: TextStyle(color: textColor)),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? AppColors.primary : const Color(0xFF1F2937),
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

  Widget _navLink(String text, Color? color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(text, style: TextStyle(fontWeight: FontWeight.w500, color: color)),
    );
  }
}

class _MobileMenuDialog extends StatelessWidget {
  const _MobileMenuDialog();

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final iconColor = Theme.of(context).iconTheme.color;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Menu", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
                // FIX 1: Removed 'const' because textColor is dynamic
                IconButton(
                  onPressed: () => Navigator.pop(context), 
                  icon: Icon(Icons.close, color: textColor)
                ),
              ],
            ),
            const Divider(),
            // Pass the color to the helper function
            _mobileLink("Features", textColor),
            _mobileLink("Products", textColor),
            _mobileLink("Pricing", textColor),
            _mobileLink("Contact", textColor),
            
            const SizedBox(height: 20),
            
            ListTile(
              leading: Icon(Icons.brightness_6, color: iconColor),
              title: Text("Switch Theme", style: TextStyle(color: textColor)),
              onTap: () {
                ThemeController.instance.toggleTheme();
                Navigator.pop(context);
              },
            ),
            
            const SizedBox(height: 10),
            
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary, 
                foregroundColor: Colors.white
              ),
              child: const Text("Get Started"),
            ),
          ],
        ),
      ),
    );
  }

  // FIX 2: Added 'color' parameter here
  Widget _mobileLink(String text, Color? color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: color)),
    );
  }
}