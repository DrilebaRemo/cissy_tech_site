import 'package:flutter/material.dart';
import 'dart:ui'; // Needed for the blur effect
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_controller.dart';

class Navbar extends StatefulWidget {
  final ScrollController? scrollController;

  const Navbar({super.key, this.scrollController});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  // _isShrunk = true means "Pill Mode", false means "Original Expanded Mode"
  bool _isShrunk = false;
  double _lastOffset = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController?.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (widget.scrollController == null) return;
    
    final currentOffset = widget.scrollController!.offset;
    final maxScroll = widget.scrollController!.position.maxScrollExtent;

    // 1. IGNORE BOUNCE (iOS overscroll at top or bottom)
    if (currentOffset < 0 || currentOffset > maxScroll) return;

    // 2. LOGIC: 
    // If at the very top (< 50px), ALWAYS expand.
    if (currentOffset < 50) {
      if (_isShrunk) {
        setState(() => _isShrunk = false);
      }
      _lastOffset = currentOffset;
      return;
    }

    // 3. DIRECTION CHECK:
    // We add a small "diff" threshold (e.g., 10px) to prevent jitter on tiny movements.
    if ((currentOffset - _lastOffset).abs() > 10) {
      if (currentOffset > _lastOffset) {
        // SCROLLING DOWN -> Shrink
        if (!_isShrunk) {
          setState(() => _isShrunk = true);
        }
      } else {
        // SCROLLING UP -> Expand (Go back to original state)
        if (_isShrunk) {
          setState(() => _isShrunk = false);
        }
      }
      _lastOffset = currentOffset;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;
    final double screenWidth = MediaQuery.of(context).size.width;

    // Theme Colors
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Background: 
    // When expanded (scrolling up), we usually want it slightly more solid so it doesn't clash with content behind it,
    // or keep the blur. Here I keep the blur but adjust opacity.
    final backgroundColor = Theme.of(context).cardColor.withOpacity(0.85);
    
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final borderColor = Theme.of(context).dividerColor;
    final iconColor = Theme.of(context).iconTheme.color;

    // --- WIDTH LOGIC ---
    // If _isShrunk (Scrolling Down): Width is 850 (Pill).
    // If !_isShrunk (Scrolling Up or Top): Width is 1200 (Original).
    // Mobile stays full width minus padding.
    final double targetWidth = isMobile 
        ? screenWidth - 32 
        : (_isShrunk ? 850 : 1200); 

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut, 
        
        height: 70,
        width: targetWidth, 
        
        // Margin: 20 when shrunk, 20 when expanded (Your original code had 20 top margin).
        // If you want it to stick to the very top when expanded, change 20 to 0 in the else case.
        // Assuming original design has floating 20px margin:
        margin: EdgeInsets.only(
          top: 20, 
          left: isMobile ? 0 : 0, 
          right: isMobile ? 0 : 0
        ),
        
        decoration: BoxDecoration(
          color: backgroundColor,
          // Round corners: 50 for Pill (Shrunk), 16 for Original (Expanded)
          borderRadius: BorderRadius.circular(_isShrunk ? 50 : 16),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_isShrunk ? 50 : 16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  // --- LEFT: LOGO ---
                  Image.asset(
                    'assets/images/cissy_logo.png',
                    height: 28, 
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "CissyTech", 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)
                  ),

                  const Spacer(),

                  // --- THEME TOGGLE ---
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
                        // Animate button radius slightly too if you want, or keep it consistent
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text("Get Started"),
                    ),
                  ],
                ],
              ),
            ),
          ),
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

// Mobile Menu Dialog (Unchanged)
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
                IconButton(
                  onPressed: () => Navigator.pop(context), 
                  icon: Icon(Icons.close, color: textColor)
                ),
              ],
            ),
            const Divider(),
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

  Widget _mobileLink(String text, Color? color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: color)),
    );
  }
}