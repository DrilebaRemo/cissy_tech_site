import 'package:flutter/material.dart';
import 'dart:ui';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_controller.dart';

class Navbar extends StatefulWidget {
  final ScrollController? scrollController;

  const Navbar({super.key, this.scrollController});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
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

    if (currentOffset < 0 || currentOffset > maxScroll) return;

    if (currentOffset < 50) {
      if (_isShrunk) {
        setState(() => _isShrunk = false);
      }
      _lastOffset = currentOffset;
      return;
    }

    if ((currentOffset - _lastOffset).abs() > 10) {
      if (currentOffset > _lastOffset) {
        if (!_isShrunk) {
          setState(() => _isShrunk = true);
        }
      } else {
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

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).cardColor.withOpacity(0.85);
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    final borderColor = Theme.of(context).dividerColor;
    final iconColor = Theme.of(context).iconTheme.color;

    final double targetWidth = isMobile 
        ? screenWidth - 32 
        : (_isShrunk ? 850 : 1200); 
    final Widget themeToggleButton = IconButton(
      onPressed: () {
        ThemeController.instance.toggleTheme();
      },
      icon: Icon(
        isDark ? Icons.light_mode : Icons.dark_mode_outlined,
        color: iconColor,
      ),
    );

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut, 
        height: 70,
        width: targetWidth, 
        margin: EdgeInsets.only(
          top: 20, 
          left: isMobile ? 0 : 0, 
          right: isMobile ? 0 : 0
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
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

                  // --- SPACER ---
                  const Spacer(),

                  // --- MOBILE LAYOUT ---
                  if (isMobile) ...[
                    // 1. Theme Icon (Left of Menu)
                    themeToggleButton,
                    
                    const SizedBox(width: 4),

                    // 2. Menu Icon
                    IconButton(
                      icon: Icon(Icons.menu, color: iconColor),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const _MobileMenuDialog(),
                        );
                      },
                    ),
                  ] 
                  
                  // --- DESKTOP LAYOUT ---
                  else ...[
                      _HoverNavLink(text: "Products", color: textColor),
                      _HoverNavLink(text: "Services", color: textColor),
                      _HoverNavLink(text: "Company info", color: textColor),
                      _HoverNavLink(text: "Contacts", color: textColor),

                    const SizedBox(width: 20),

                    // 1. Theme Icon (Left of Button)
                    themeToggleButton,

                    const SizedBox(width: 10),

                    // 2. Get Started Button
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? AppColors.primary : const Color(0xFF1F2937),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text("Login"),
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
}
class _HoverNavLink extends StatefulWidget {
  final String text;
  final Color? color;

  const _HoverNavLink({required this.text, required this.color});

  @override
  State<_HoverNavLink> createState() => _HoverNavLinkState();
}

class _HoverNavLinkState extends State<_HoverNavLink> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          // Slight vertical lift (-2px) on hover to match the dynamic feel
          transform: isHovered ? Matrix4.translationValues(0, -2, 0) : Matrix4.identity(),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16, // Ensure font size matches original
              // Change to Primary Blue on hover
              color: isHovered ? AppColors.primary : widget.color,
            ),
            child: Text(widget.text),
          ),
        ),
      ),
    );
  }
}

// Mobile Menu Dialog
class _MobileMenuDialog extends StatelessWidget {
  const _MobileMenuDialog();

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.displayLarge?.color;
    // final iconColor = Theme.of(context).iconTheme.color; // Removed as theme toggle is now on navbar

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
            
            // Removed "Switch Theme" ListTile from here since it's on the Navbar now
            
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
