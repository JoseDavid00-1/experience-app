import 'package:flutter/material.dart';

class OnboardingPageLayout extends StatelessWidget {
  const OnboardingPageLayout({
    required this.content,
    required this.bottomAction,
    this.header,
    super.key,
  });

  final Widget content;
  final Widget bottomAction;
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  ?header,
                  Expanded(child: content),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 12),
                    child: bottomAction,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
