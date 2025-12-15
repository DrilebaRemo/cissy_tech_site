import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fade_in_scroll.dart';

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  static const List<Map<String, String>> _faqs = [
    {
      "question": "How do you approach a new project?",
      "answer": "We start with a comprehensive discovery phase to understand your business goals, target audience, and technical requirements. This allows us to create a tailored roadmap."
    },
    {
      "question": "What technologies do you specialize in?",
      "answer": "Our team is proficient in modern stacks including Flutter for cross-platform apps, React for web, Node.js for backend, and secure cloud infrastructure on AWS."
    },
    {
      "question": "Do you provide post-launch support?",
      "answer": "Absolutely. We offer ongoing maintenance and support packages to ensure your software remains secure, up-to-date, and continues to perform optimally."
    },
    {
      "question": "Can you integrate with Mobile Money?",
      "answer": "Yes. We specialize in Fintech integrations, specifically Airtel Money, MTN Mobile Money, and major banking APIs for seamless payments."
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: bgColor,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInScroll(
                child: const Text(
                  "Frequently Asked Questions",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 50),
              Column(
                children: _faqs.map((faq) => _FaqCard(
                  question: faq['question']!,
                  answer: faq['answer']!,
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FaqCard extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqCard({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;
    final borderColor = Theme.of(context).dividerColor;

    return FadeInScroll(
      delay: const Duration(milliseconds: 100),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            childrenPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            iconColor: AppColors.primary,
            collapsedIconColor: Colors.grey,
            title: Text(
              question,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            children: [
              Text(
                answer,
                style: TextStyle(height: 1.5, color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}