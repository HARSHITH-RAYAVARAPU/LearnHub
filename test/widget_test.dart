import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learnhub/features/courses/data/course_data.dart';
import 'package:learnhub/features/courses/widgets/course_badge.dart';

void main() {
  group('LearnHub - Experiment 2b Automated Suite', () {
    test('Catalog data initializes with Free and New courses', () {
      final courses = CourseData.initialCourses;
      expect(courses.isNotEmpty, true);

      final freeCourses = courses.where((c) => c.isFree).toList();
      final newCourses = courses.where((c) => c.isNew).toList();

      expect(freeCourses.isNotEmpty, true);
      expect(newCourses.isNotEmpty, true);
    });

    testWidgets('CourseBadge.free renders FREE label and check icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: CourseBadge.free(),
            ),
          ),
        ),
      );

      expect(find.text('FREE'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_outline_rounded), findsOneWidget);
    });

    testWidgets('CourseBadge.isNew renders NEW label and bolt icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: CourseBadge.isNew(),
            ),
          ),
        ),
      );

      expect(find.text('NEW'), findsOneWidget);
      expect(find.byIcon(Icons.bolt_rounded), findsOneWidget);
    });
  });
}
