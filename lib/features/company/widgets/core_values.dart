import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fade_in_scroll.dart';

class CoreValuesSection extends StatelessWidget {
  const CoreValuesSection({super.key});

  static const List<Map<String, dynamic>> _values = [
    {"title": "Innovation", "desc": "Constantly pushing boundaries to find better solutions.", "icon": Icons.lightbulb_outline},
    {"title": "Integrity", "desc": "Building trust through transparency and honest communication.", "icon": Icons.verified_user_outlined},
    {"title": "Collaboration", "desc": "We achieve more when we work together as a unified team.", "icon": Icons.groups_outlined},
    {"title": "Excellence", "desc": "Delivering the highest quality in everything we do.", "icon": Icons.rocket_launch_outlined},
    {"title": "Customer Centricity", "desc": "Creating solutions specific to the needs of our clients.", "icon": Icons.person_2_outlined},
    {"title": "Accountability", "desc": "Ensuring responsibility and commitment to our work.", "icon": Icons.verified_user_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    // Subtle background change to separate sections
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      color: bgColor,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              FadeInScroll(
                child: const Text(
                  "Our Core Values",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              FadeInScroll(
                delay: const Duration(milliseconds: 100),
                child: Text(
                  "The principles that define who we are and how we work.",
                  style: TextStyle(fontSize: 18, color: Theme.of(context).textTheme.bodyLarge?.color),
                ),
              ),
              const SizedBox(height: 60),
              
              Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: _values.asMap().entries.map((entry) {
                  return _ValueCard(
                    title: entry.value['title'],
                    desc: entry.value['desc'],
                    icon: entry.value['icon'],
                    index: entry.key,
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ValueCard extends StatefulWidget {
  final String title;
  final String desc;
  final IconData icon;
  final int index;

  const _ValueCard({required this.title, required this.desc, required this.icon, required this.index});

  @override
  State<_ValueCard> createState() => _ValueCardState();
}

class _ValueCardState extends State<_ValueCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;
    final borderColor = Theme.of(context).dividerColor;
    
    
    return FadeInScroll(
      delay: Duration(milliseconds: 100 * widget.index),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 270,
          padding: const EdgeInsets.all(32),
          transform: isHovered ? Matrix4.translationValues(0, -5, 0) : Matrix4.identity(),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: isHovered ? AppColors.primary.withOpacity(0.1) : Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0,10)
              )
            ],
           border: Border.all(
              color: isHovered 
                  ? AppColors.primary.withOpacity(0.5) // Blue when hovered
                  : borderColor,                       // Gray when idle (Visible Boundary)
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isHovered ? AppColors.primary : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary),
                ),
                child: Icon(
                  widget.icon, 
                  color: isHovered ? Colors.white : AppColors.primary, 
                  size: 32
                ),
              ),
              const SizedBox(height: 20),
              Text(widget.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(
                widget.desc, 
                textAlign: TextAlign.center, 
                style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, height: 1.5)
              ),
            ],
          ),
        ),
      ),
    );
  }
}