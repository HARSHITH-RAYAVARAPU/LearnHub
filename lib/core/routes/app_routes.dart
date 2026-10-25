import 'package:flutter/material.dart';
import '../../features/courses/models/course.dart';
import '../../features/courses/screens/course_catalog_screen.dart';
import '../../features/courses/screens/course_detail_screen.dart';
import '../../features/navigation/screens/main_navigation_shell.dart';

/// Centralized route manager for LearnHub.
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String catalog = '/catalog';
  static const String courseDetail = '/course-detail';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const MainNavigationShell(),
          settings: settings,
        );

      case catalog:
        return MaterialPageRoute(
          builder: (_) => const CourseCatalogScreen(),
          settings: settings,
        );

      case courseDetail:
        final course = settings.arguments as Course;
        return MaterialPageRoute(
          builder: (_) => CourseDetailScreen(
            course: course,
            onBookmarkToggle: () {},
          ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const MainNavigationShell(),
          settings: settings,
        );
    }
  }
}
