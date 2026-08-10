import 'package:flutter_test/flutter_test.dart';

import 'package:portfolio/main.dart';

void main() {
  testWidgets('Portfolio renders and contains core sections', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PortfolioApp());

    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump(const Duration(milliseconds: 800));

    expect(find.text('Hi, I\'m Ismail'), findsOneWidget);
    expect(find.text('Flutter Developer'), findsWidgets);

    expect(find.text('Featured Projects'), findsOneWidget);
    expect(
      find.text('Some of the applications I\'ve designed and developed.'),
      findsOneWidget,
    );

    expect(find.text('Tajhiz'), findsWidgets);
    expect(find.text('Foody'), findsWidgets);

    expect(find.text('View My Projects'), findsOneWidget);
  });
}
