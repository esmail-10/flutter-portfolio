import 'package:flutter_test/flutter_test.dart';

import 'package:portfolio/main.dart';

void main() {
  testWidgets('Portfolio renders and contains core sections', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PortfolioApp());

    // Let initial scroll-reveal animations finish. Fixed pump instead of
    // pumpAndSettle because the hero visual runs infinite floating/glow
    // animations that never settle.
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 800));

    // Core identity
    expect(find.text('Hi, I\'m Ismail'), findsOneWidget);
    expect(find.text('Flutter Developer'), findsWidgets);

    // Key section titles
    expect(find.text('Featured Projects'), findsOneWidget);
    expect(
      find.text('Some of the applications I\'ve designed and developed.'),
      findsOneWidget,
    );

    // Project names
    expect(find.text('Tajhiz'), findsWidgets);
    expect(find.text('Foody'), findsWidgets);

    // CTA buttons
    expect(find.text('View My Projects'), findsOneWidget);
  });
}
