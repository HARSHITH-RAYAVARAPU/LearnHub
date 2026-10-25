import 'package:flutter_test/flutter_test.dart';
import 'package:learnhub/features/courses/screens/course_catalog_screen.dart';
import 'package:learnhub/main.dart';

void main() {
  testWidgets('LearnHub app launches and renders catalog screen with course cards', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const LearnHubApp());
    await tester.pumpAndSettle();

    // Verify header branding exists
    expect(find.text('FEATURED CATALOG 2026'), findsOneWidget);

    // Verify course catalog screen is present
    expect(find.byType(CourseCatalogScreen), findsOneWidget);
  });
}
