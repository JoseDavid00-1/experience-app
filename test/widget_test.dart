import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:experience_app/app/app.dart';

void main() {
  testWidgets('intro displays its main content', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: ExperienceApp()));
    await tester.pumpAndSettle();

    expect(
      find.text('Create a prototype in just a few minutes'),
      findsOneWidget,
    );
    expect(
      find.text(
        'Enjoy these pre-made components and worry only about '
        'creating the best product ever.',
      ),
      findsOneWidget,
    );
    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('next opens the interests step', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: ExperienceApp()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Personalise your experience'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();
    expect(find.text('Design Systems'), findsOneWidget);
  });
}
