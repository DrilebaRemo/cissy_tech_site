import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';
import 'dart:async';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_controller.dart';

// Data class for dropdown menu items
class DropdownItem {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;

  const DropdownItem({
    required this.label,
    this.onTap,
    this.icon,
  });
}

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

              // Use brandGray for shadow to integrate brand color into depth
              color: isDark 
                  ? Colors.black.withOpacity(0.2) 
                  : AppColors.brandGray.withOpacity(0.1), 
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
                  Image.asset(
                    'assets/images/cissy_logo.png',
                    height: 28, 
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "CissyTech", 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppColors.brandGray)
                  ),

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
                      _HoverNavLink(
                        text: "Home", 
                        color: isDark ? Colors.white : AppColors.brandGray,
                        onTap: () => context.go('/'),
                      ),
                      _HoverNavLink(
                        text: "Products", 
                        color: isDark ? Colors.white : AppColors.brandGray,
                        dropdownItems: [
                          DropdownItem(
                            label: "Collecto",
                            onTap: () => context.go('/'),
                          ),
                          DropdownItem(
                            label: "Bulk",
                            onTap: () => context.go('/'),
                          ),
                          DropdownItem(
                            label: "EWorker",
                            onTap: () => context.go('/'),
                          ),
                          DropdownItem(
                            label: "Cissy AI",
                            onTap: () => context.go('/'),
                          ),
                          DropdownItem(
                            label: "GnG",
                            onTap: () => context.go('/'),
                          ),
                          DropdownItem(
                            label: "Rent Pay",
                            onTap: () => context.go('/'),
                          ),
                        ],
                      ),
                      _HoverNavLink(
                        text: "Services", 
                        color: isDark ? Colors.white : AppColors.brandGray,
                        dropdownItems: [
                          DropdownItem(
                            label: "Custom Web and App Development",
                          ),
                          DropdownItem(
                            label: "ICT Infrastructure & Managed Services",
                          ),
                          DropdownItem(
                            label: "Brand Strategy & Corporate Communications",
                          ),
                          DropdownItem(
                            label: "ICT Consultancy & Capacity Building",
                          ),
                        ],
                      ),
                      _HoverNavLink(
                        text: "Company", 
                        color: isDark ? Colors.white : AppColors.brandGray,
                        dropdownItems: [
                          DropdownItem(
                            label: "About Us",
                            onTap: () => context.go('/company'),
                          ),
                          DropdownItem(
                            label: "Contact Us",
                            onTap: () => context.go('/'),
                          ),
                          DropdownItem(
                            label: "Our Partnerships",
                            onTap: () => context.go('/'),
                          ),
                          DropdownItem(
                            label: "Blog",
                            onTap: () => context.go('/'),
                          ),
                        ],
                      ),
                    const SizedBox(width: 20),

                    // 1. Theme Icon (Left of Button)
                    themeToggleButton,
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
  final VoidCallback? onTap;
  final List<DropdownItem>? dropdownItems;

  const _HoverNavLink({
    required this.text,
    required this.color,
    this.onTap,
    this.dropdownItems,
  });

  @override
  State<_HoverNavLink> createState() => _HoverNavLinkState();
}

class _HoverNavLinkState extends State<_HoverNavLink> {
  bool isHovered = false;
  bool showDropdown = false;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  Timer? _hoverTimer;

  @override
  void dispose() {
    _hoverTimer?.cancel();
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    showDropdown = false;
  }

  void _showDropdown() {
    if (widget.dropdownItems == null || widget.dropdownItems!.isEmpty) return;
    if (_overlayEntry != null) return; // Already showing

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => showDropdown = true);
  }

  void _hideDropdown() {
    _removeOverlay();
    if (mounted) {
      setState(() => showDropdown = false);
    }
  }

  OverlayEntry _createOverlayEntry() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).cardColor.withOpacity(0.85);
    final borderColor = Theme.of(context).dividerColor;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: 220,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 35), // Reduced gap from 40 to 35
          child: Material(
            color: Colors.transparent,
            child: MouseRegion(
              onEnter: (_) {
                // Cancel any pending hide operation
                _hoverTimer?.cancel();
                setState(() => isHovered = true);
              },
              onExit: (_) {
                // Start hide timer when leaving dropdown
                setState(() => isHovered = false);
                _hoverTimer?.cancel();
                _hoverTimer = Timer(const Duration(milliseconds: 150), () {
                  if (!isHovered && mounted) {
                    _hideDropdown();
                  }
                });
              },
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 200),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: 0.95 + (0.05 * value),
                    alignment: Alignment.topCenter,
                    child: Opacity(
                      opacity: value,
                      child: child,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 4), // Reduced from 8 to 4
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? Colors.black.withOpacity(0.3)
                            : AppColors.brandGray.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.dropdownItems!.map((item) {
                          return _DropdownMenuItem(
                            item: item,
                            onTap: () {
                              _hideDropdown();
                              item.onTap?.call();
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasDropdown = widget.dropdownItems != null && widget.dropdownItems!.isNotEmpty;

    return CompositedTransformTarget(
      link: _layerLink,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) {
            setState(() => isHovered = true);
            if (hasDropdown) {
              // Cancel any pending hide operation
              _hoverTimer?.cancel();
              // Show dropdown with a small delay
              _hoverTimer = Timer(const Duration(milliseconds: 150), () {
                if (isHovered && mounted) {
                  _showDropdown();
                }
              });
            }
          },
          onExit: (_) {
            setState(() => isHovered = false);
            if (hasDropdown) {
              // Cancel show timer and start hide timer
              _hoverTimer?.cancel();
              _hoverTimer = Timer(const Duration(milliseconds: 150), () {
                if (!isHovered && mounted) {
                  _hideDropdown();
                }
              });
            }
          },
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: isHovered ? Matrix4.translationValues(0, -2, 0) : Matrix4.identity(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: isHovered ? AppColors.primary : widget.color,
                    ),
                    child: Text(widget.text),
                  ),
                  if (hasDropdown) ...[
                    const SizedBox(width: 4),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 200),
                      turns: showDropdown ? 0.5 : 0,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 18,
                        color: isHovered ? AppColors.primary : widget.color,
                      ),
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

// Dropdown menu item widget
class _DropdownMenuItem extends StatefulWidget {
  final DropdownItem item;
  final VoidCallback onTap;

  const _DropdownMenuItem({
    required this.item,
    required this.onTap,
  });

  @override
  State<_DropdownMenuItem> createState() => _DropdownMenuItemState();
}

class _DropdownMenuItemState extends State<_DropdownMenuItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.displayLarge?.color;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: isHovered
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
          child: Row(
            children: [
              if (widget.item.icon != null) ...[
                Icon(
                  widget.item.icon,
                  size: 18,
                  color: isHovered ? AppColors.primary : textColor?.withOpacity(0.7),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  widget.item.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isHovered ? AppColors.primary : textColor,
                  ),
                ),
              ),
            ],
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
            
            // Products Section
            _MobileExpandableSection(
              title: "Products",
              textColor: textColor,
              items: [
                DropdownItem(label: "Collecto", onTap: () => context.go('https://collecto.cissytech.com/')),
                DropdownItem(label: "Bulk", onTap: () => context.go('/')),
                DropdownItem(label: "EWorker", onTap: () => context.go('/')),
                DropdownItem(label: "Cissy Cloud", onTap: () => context.go('/')),
                DropdownItem(label: "Cissy Drive", onTap: () => context.go('/')),
              ],
            ),
            
            // Services Section
            _MobileExpandableSection(
              title: "Services",
              textColor: textColor,
              items: [
                DropdownItem(label: "Web Development"),
                DropdownItem(label: "Domain Name Registration"),
                DropdownItem(label: "Cloud and Email Hosting"),
                DropdownItem(label: "Consulting"),
              ],
            ),
            
            // Company Section
            _MobileExpandableSection(
              title: "Company",
              textColor: textColor,
              items: [
                DropdownItem(
                  label: "About Us",
                  onTap: () => context.go('/company'),
                ),
                DropdownItem(
                  label: "Blog",
                  onTap: () => context.go('/'),
                ),
              ],
            ),
            
            // Contact Section
            _MobileExpandableSection(
              title: "Contact",
              textColor: textColor,
              items: [
                DropdownItem(label: "Get in Touch"),
                DropdownItem(label: "Support"),
                DropdownItem(label: "Locations"),
              ],
            ),
            
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary, 
                foregroundColor: Colors.white
              ),
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

// Expandable section for mobile menu
class _MobileExpandableSection extends StatelessWidget {
  final String title;
  final Color? textColor;
  final List<DropdownItem> items;

  const _MobileExpandableSection({
    required this.title,
    required this.textColor,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        iconColor: textColor,
        collapsedIconColor: textColor,
        children: items.map((item) {
          return InkWell(
            onTap: () {
              Navigator.pop(context);
              item.onTap?.call();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor?.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
