import 'package:flutter/material.dart';

// ============================================================================
// LEARNHUB — CONSOLIDATED DARTPAD RUNNER
// Zero-dependency, single-file runnable version for https://dartpad.dev/flutter
// Core Experiment 2b Focus: Course Catalog with "New/Free" badges using Stack & Positioned
// ============================================================================

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LearnHubApp());
}

/// Root Application Widget
class LearnHubApp extends StatelessWidget {
  const LearnHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LearnHub - Digital Course Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          surface: AppColors.surfaceLight,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AppColors.backgroundLight,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surfaceLight,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const MainNavigationShell(),
    );
  }
}

// ============================================================================
// 1. DESIGN SYSTEM & CONSTANTS
// ============================================================================

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF4F46E5); // Indigo 600
  static const Color primaryLight = Color(0xFFEEF2FF); // Indigo 50
  static const Color accent = Color(0xFF06B6D4); // Cyan 500

  // Badge Specific Colors
  static const Color badgeFreeBg = Color(0xFF059669); // Emerald 600
  static const Color badgeNewBg = Color(0xFF4F46E5); // Indigo 600
  static const Color badgeHotBg = Color(0xFFD97706); // Amber 600

  // Neutrals
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF1F5F9);
  static const Color borderLight = Color(0xFFE2E8F0);

  // Typography Tokens
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textMuted = Color(0xFF94A3B8);

  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
}

class AppBreakpoints {
  AppBreakpoints._();

  static const double mobileMax = 650.0;
  static const double tabletMax = 1080.0;
  static const double maxContentWidth = 1320.0;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMax;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileMax && width < tabletMax;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMax;

  static double getHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobileMax) return 16.0;
    if (width < tabletMax) return 24.0;
    return 36.0;
  }
}

// ============================================================================
// 2. DATA MODEL & MOCK REPOSITORY
// ============================================================================

class Course {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final String instructor;
  final String instructorRole;
  final double rating;
  final int reviewCount;
  final int enrolledCount;
  final String duration;
  final int lectureCount;
  final String level;
  final String thumbnailUrl;
  final double price;
  final double? originalPrice;
  final bool isFree;
  final bool isNew;
  final bool isBestseller;
  final List<String> syllabus;
  final String description;
  bool isBookmarked;

  Course({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.instructor,
    required this.instructorRole,
    required this.rating,
    required this.reviewCount,
    required this.enrolledCount,
    required this.duration,
    required this.lectureCount,
    required this.level,
    required this.thumbnailUrl,
    required this.price,
    this.originalPrice,
    required this.isFree,
    required this.isNew,
    this.isBestseller = false,
    required this.syllabus,
    required this.description,
    this.isBookmarked = false,
  });
}

class CourseData {
  CourseData._();

  static List<Course> get initialCourses => [
        Course(
          id: 'c-01',
          title: 'Advanced Flutter & Dart Design Patterns',
          subtitle: 'Master Clean Architecture, BLoC, and multi-platform responsive UI.',
          category: 'Mobile Dev',
          instructor: 'Alex Rivera',
          instructorRole: 'Staff Mobile Engineer',
          rating: 4.9,
          reviewCount: 1420,
          enrolledCount: 8950,
          duration: '22h 30m',
          lectureCount: 84,
          level: 'Advanced',
          thumbnailUrl:
              'https://images.unsplash.com/photo-1551650975-87deedd944c3?w=800&auto=format&fit=crop&q=80',
          price: 0.0,
          originalPrice: 89.99,
          isFree: true,
          isNew: true,
          isBestseller: true,
          syllabus: [
            'Clean Architecture in Modern Flutter Apps',
            'State Management: Deep Dive into BLoC & Riverpod',
            'Custom Layouts: Advanced Stack & Positioned Compositing',
            'Multi-Platform Deployment & CI/CD Pipelines',
          ],
          description:
              'Elevate your Flutter skills to an enterprise level. Learn architectural blueprints used by top Silicon Valley teams to ship scalable, testable applications.',
        ),
        Course(
          id: 'c-02',
          title: 'Cloud-Native DevOps with Kubernetes & Terraform',
          subtitle: 'Automate infrastructure as code, build scalable microservices, and deploy securely.',
          category: 'Cloud & DevOps',
          instructor: 'Elena Rostova',
          instructorRole: 'Principal Cloud Architect',
          rating: 4.8,
          reviewCount: 980,
          enrolledCount: 6200,
          duration: '18h 45m',
          lectureCount: 62,
          level: 'Intermediate',
          thumbnailUrl:
              'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&auto=format&fit=crop&q=80',
          price: 74.99,
          originalPrice: 129.99,
          isFree: false,
          isNew: true,
          isBestseller: false,
          syllabus: [
            'Containerization Fundamentals with Docker',
            'Kubernetes Cluster Orchestration from Scratch',
            'Infrastructure Provisioning using Terraform',
          ],
          description:
              'A hands-on, production-first deep dive into modern cloud architecture with automated CI/CD and zero-downtime rollouts.',
        ),
        Course(
          id: 'c-03',
          title: 'Modern UI/UX Design Systems in Figma',
          subtitle: 'Create accessible, scalable token-based component libraries for product teams.',
          category: 'Design',
          instructor: 'Marcus Chen',
          instructorRole: 'Design Director',
          rating: 4.95,
          reviewCount: 2310,
          enrolledCount: 14200,
          duration: '14h 10m',
          lectureCount: 48,
          level: 'All Levels',
          thumbnailUrl:
              'https://images.unsplash.com/photo-1581291518655-9523c932deb6?w=800&auto=format&fit=crop&q=80',
          price: 0.0,
          originalPrice: 59.99,
          isFree: true,
          isNew: false,
          isBestseller: true,
          syllabus: [
            'Design Tokens and Typography Scales',
            'Auto-Layout 5.0 and Component Variables',
            'Accessibility (WCAG 2.2) Compliance in UI',
          ],
          description:
              'Bridge the gap between product design and frontend engineering with reusable tokenized components.',
        ),
        Course(
          id: 'c-04',
          title: 'Applied Generative AI & Autonomous Agent Architecture',
          subtitle: 'Build intelligent RAG pipelines, fine-tune models, and deploy production agents.',
          category: 'AI & Data',
          instructor: 'Dr. Sophia Bennett',
          instructorRole: 'AI Research Scientist',
          rating: 4.88,
          reviewCount: 1850,
          enrolledCount: 11400,
          duration: '26h 15m',
          lectureCount: 96,
          level: 'Intermediate',
          thumbnailUrl:
              'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&auto=format&fit=crop&q=80',
          price: 89.99,
          originalPrice: 149.99,
          isFree: false,
          isNew: true,
          isBestseller: true,
          syllabus: [
            'Vector Embeddings & Semantic Search Indexing',
            'Retrieval-Augmented Generation (RAG) Architecture',
            'Agentic Workflows with Function Calling & Tool Use',
          ],
          description:
              'Move beyond basic API calls. Engineer robust, context-aware GenAI applications with vector stores and intelligent tool calling.',
        ),
        Course(
          id: 'c-05',
          title: 'Full-Stack Web Engineering with TypeScript & Go',
          subtitle: 'High-performance REST & gRPC backend APIs paired with modern reactive frontends.',
          category: 'Web Dev',
          instructor: 'Vikram Joshi',
          instructorRole: 'Lead Systems Architect',
          rating: 4.75,
          reviewCount: 840,
          enrolledCount: 5300,
          duration: '20h 00m',
          lectureCount: 70,
          level: 'Intermediate',
          thumbnailUrl:
              'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=800&auto=format&fit=crop&q=80',
          price: 0.0,
          originalPrice: 79.99,
          isFree: true,
          isNew: true,
          isBestseller: false,
          syllabus: [
            'Go Concurrency: Goroutines, Channels, & Mutexes',
            'High-Throughput gRPC Services & Protocol Buffers',
            'TypeScript Strict Typing & State Synchronization',
          ],
          description:
              'Learn how to write blazing fast backends in Go and match them with strictly typed TypeScript frontends.',
        ),
        Course(
          id: 'c-06',
          title: 'Zero to Mastery in Product Management',
          subtitle: 'From user discovery and wireframing to go-to-market strategies and telemetry.',
          category: 'Product',
          instructor: 'David Sterling',
          instructorRole: 'Former VP of Product',
          rating: 4.91,
          reviewCount: 3100,
          enrolledCount: 19800,
          duration: '19h 40m',
          lectureCount: 75,
          level: 'All Levels',
          thumbnailUrl:
              'https://images.unsplash.com/photo-1531403009284-440f080d1e12?w=800&auto=format&fit=crop&q=80',
          price: 0.0,
          originalPrice: 99.99,
          isFree: true,
          isNew: false,
          isBestseller: true,
          syllabus: [
            'Customer Discovery & Problem Statement Framing',
            'PRD (Product Requirements Document) Mastery',
            'Metrics That Matter: North Star, Retention, & Funnels',
          ],
          description:
              'A comprehensive curriculum taught through practical real-world case studies to lead high-performing tech squads.',
        ),
      ];
}

// ============================================================================
// 3. CORE WIDGET: BADGE PILL COMPONENT
// ============================================================================

class CourseBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final bool isGlowing;

  const CourseBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
    this.textColor = Colors.white,
    this.icon,
    this.isGlowing = false,
  });

  factory CourseBadge.free() => const CourseBadge(
        label: 'FREE',
        backgroundColor: AppColors.badgeFreeBg,
        icon: Icons.check_circle_outline_rounded,
        isGlowing: true,
      );

  factory CourseBadge.isNew() => const CourseBadge(
        label: 'NEW',
        backgroundColor: AppColors.badgeNewBg,
        icon: Icons.bolt_rounded,
        isGlowing: true,
      );

  factory CourseBadge.bestseller() => const CourseBadge(
        label: 'BESTSELLER',
        backgroundColor: AppColors.badgeHotBg,
        icon: Icons.star_rounded,
        isGlowing: false,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4.5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(isGlowing ? 0.45 : 0.25),
            blurRadius: isGlowing ? 8 : 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 4. CORE WIDGET: COURSE CARD (STACK & POSITIONED SHOWCASE)
// ============================================================================

class CourseCard extends StatefulWidget {
  final Course course;
  final VoidCallback onTap;
  final VoidCallback onBookmarkToggle;

  const CourseCard({
    super.key,
    required this.course,
    required this.onTap,
    required this.onBookmarkToggle,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final course = widget.course;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? AppColors.primary.withOpacity(0.4) : AppColors.borderLight,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.12 : 0.05),
              blurRadius: _isHovered ? 16 : 8,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ========================================================
              // STACK & POSITIONED THUMBNAIL IMPLEMENTATION
              // ========================================================
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // 1. BASE IMAGE LAYER
                      Image.network(
                        course.thumbnailUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF1E293B), Color(0xFF334155)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Center(
                            child: Icon(Icons.school_rounded, color: Colors.white54, size: 40),
                          ),
                        ),
                      ),

                      // 2. VIGNETTE SCRIM
                      const Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0x55000000),
                                Colors.transparent,
                                Color(0x66000000),
                              ],
                              stops: [0.0, 0.4, 1.0],
                            ),
                          ),
                        ),
                      ),

                      // 3. POSITIONED: "FREE" BADGE (Top-Left)
                      if (course.isFree)
                        Positioned(
                          top: 10,
                          left: 10,
                          child: CourseBadge.free(),
                        ),

                      // 4. POSITIONED: "NEW" BADGE (Dynamic horizontal offset)
                      if (course.isNew)
                        Positioned(
                          top: 10,
                          left: course.isFree ? 88 : 10,
                          child: CourseBadge.isNew(),
                        ),

                      // 5. POSITIONED: "BESTSELLER" BADGE (Fallback offset)
                      if (course.isBestseller && (!course.isFree || !course.isNew))
                        Positioned(
                          top: 10,
                          left: (course.isFree || course.isNew) ? 88 : 10,
                          child: CourseBadge.bestseller(),
                        ),

                      // 6. POSITIONED: BOOKMARK BUTTON (Top-Right)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Material(
                          color: Colors.black.withOpacity(0.4),
                          shape: const CircleBorder(),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: widget.onBookmarkToggle,
                            child: Padding(
                              padding: const EdgeInsets.all(7),
                              child: Icon(
                                course.isBookmarked
                                    ? Icons.bookmark_rounded
                                    : Icons.bookmark_outline_rounded,
                                color: course.isBookmarked ? AppColors.warning : Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // 7. POSITIONED: DURATION & STATS PILL (Bottom-Right)
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.65),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.schedule_rounded, size: 12, color: Colors.white),
                              const SizedBox(width: 4),
                              Text(
                                course.duration,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // CARD BODY
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              course.category.toUpperCase(),
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.signal_cellular_alt_rounded,
                                  size: 14, color: AppColors.textMuted),
                              const SizedBox(width: 4),
                              Text(
                                course.level,
                                style: const TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        course.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        course.instructor,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 16, color: Colors.amber),
                          const SizedBox(width: 3),
                          Text(
                            course.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${(course.enrolledCount / 1000).toStringAsFixed(1)}k learners',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20, color: AppColors.borderLight),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            course.isFree ? 'FREE' : '\$${course.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: course.isFree ? AppColors.badgeFreeBg : AppColors.textPrimary,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: widget.onTap,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  course.isFree ? AppColors.badgeFreeBg : AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              minimumSize: const Size(0, 36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              course.isFree ? 'Start Free' : 'Enroll',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ],
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

// ============================================================================
// 5. MAIN CATALOG SCREEN (RESPONSIVE GRID & INTERACTIVE FILTERS)
// ============================================================================

class CourseCatalogScreen extends StatefulWidget {
  const CourseCatalogScreen({super.key});

  @override
  State<CourseCatalogScreen> createState() => _CourseCatalogScreenState();
}

class _CourseCatalogScreenState extends State<CourseCatalogScreen> {
  late List<Course> _allCourses;
  late TextEditingController _searchController;
  String _selectedCategory = 'All Categories';
  bool _filterFreeOnly = false;
  bool _filterNewOnly = false;

  final List<String> _categories = [
    'All Categories',
    'Mobile Dev',
    'AI & Data',
    'Cloud & DevOps',
    'Design',
    'Web Dev',
    'Product',
  ];

  @override
  void initState() {
    super.initState();
    _allCourses = CourseData.initialCourses;
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Course> get _filteredCourses {
    return _allCourses.where((c) {
      final q = _searchController.text.trim().toLowerCase();
      if (q.isNotEmpty) {
        if (!c.title.toLowerCase().contains(q) &&
            !c.instructor.toLowerCase().contains(q) &&
            !c.category.toLowerCase().contains(q)) {
          return false;
        }
      }
      if (_selectedCategory != 'All Categories' && c.category != _selectedCategory) {
        return false;
      }
      if (_filterFreeOnly && !c.isFree) return false;
      if (_filterNewOnly && !c.isNew) return false;
      return true;
    }).toList();
  }

  void _toggleBookmark(Course course) {
    setState(() => course.isBookmarked = !course.isBookmarked);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(course.isBookmarked ? 'Bookmarked "${course.title}"' : 'Bookmark removed'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _openDetail(Course course) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CourseDetailScreen(
          course: course,
          onBookmarkToggle: () => _toggleBookmark(course),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = AppBreakpoints.getHorizontalPadding(context);
    final isDesktop = AppBreakpoints.isDesktop(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppBreakpoints.maxContentWidth),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // HERO HEADER & FILTER BAR
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(padding, 20, padding, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hero Container
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(isDesktop ? 32 : 20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1E1B4B), Color(0xFF312E81), Color(0xFF4338CA)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF312E81).withOpacity(0.3),
                                blurRadius: 18,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'FEATURED CATALOG 2026',
                                style: TextStyle(
                                  color: Colors.amberAccent,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Master in-demand skills with industry-leading courses',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isDesktop ? 26 : 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Explore certified curricula featuring Free introductory tracks & brand-New interactive labs.',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: isDesktop ? 14 : 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Search Input
                        TextField(
                          controller: _searchController,
                          onChanged: (_) => setState(() {}),
                          decoration: InputDecoration(
                            hintText: 'Search courses by title, topic, or instructor...',
                            prefixIcon: const Icon(Icons.search_rounded),
                            filled: true,
                            fillColor: AppColors.surfaceLight,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: AppColors.borderLight),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: AppColors.borderLight),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Filter Pills (Free & New Badges + Categories)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              FilterChip(
                                selected: _filterFreeOnly,
                                onSelected: (v) => setState(() => _filterFreeOnly = v),
                                label: const Text('Free Courses Only'),
                                selectedColor: AppColors.badgeFreeBg,
                                labelStyle: TextStyle(
                                  color: _filterFreeOnly ? Colors.white : AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              FilterChip(
                                selected: _filterNewOnly,
                                onSelected: (v) => setState(() => _filterNewOnly = v),
                                label: const Text('New Releases'),
                                selectedColor: AppColors.primary,
                                labelStyle: TextStyle(
                                  color: _filterNewOnly ? Colors.white : AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 12),
                              ..._categories.map((cat) {
                                final isSelected = _selectedCategory == cat;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ChoiceChip(
                                    label: Text(cat),
                                    selected: isSelected,
                                    onSelected: (v) {
                                      if (v) setState(() => _selectedCategory = cat);
                                    },
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // RESPONSIVE GRID
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(padding, 8, padding, 32),
                  sliver: _buildResponsiveGrid(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveGrid(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 1;
    double childAspectRatio = 1.05;

    if (width >= 1250) {
      crossAxisCount = 4;
      childAspectRatio = 0.73;
    } else if (width >= 950) {
      crossAxisCount = 3;
      childAspectRatio = 0.75;
    } else if (width >= 650) {
      crossAxisCount = 2;
      childAspectRatio = 0.78;
    }

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
        childAspectRatio: childAspectRatio,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final course = _filteredCourses[index];
          return CourseCard(
            course: course,
            onTap: () => _openDetail(course),
            onBookmarkToggle: () => _toggleBookmark(course),
          );
        },
        childCount: _filteredCourses.length,
      ),
    );
  }
}

// ============================================================================
// 6. COURSE DETAIL SCREEN
// ============================================================================

class CourseDetailScreen extends StatelessWidget {
  final Course course;
  final VoidCallback onBookmarkToggle;

  const CourseDetailScreen({
    super.key,
    required this.course,
    required this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(course.title, style: const TextStyle(fontSize: 16)),
        actions: [
          IconButton(
            icon: Icon(
              course.isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
              color: course.isBookmarked ? AppColors.warning : AppColors.textPrimary,
            ),
            onPressed: onBookmarkToggle,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HERO THUMBNAIL WITH STACK & POSITIONED
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(course.thumbnailUrl, fit: BoxFit.cover),
                  if (course.isFree)
                    Positioned(top: 14, left: 14, child: CourseBadge.free()),
                  if (course.isNew)
                    Positioned(top: 14, left: course.isFree ? 96 : 14, child: CourseBadge.isNew()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.title,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text(course.subtitle,
                      style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                  const SizedBox(height: 18),
                  Text('Instructor: ${course.instructor} (${course.instructorRole})',
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 20),
                  const Text('Curriculum Topics:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  ...course.syllabus.map((topic) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_rounded,
                                color: AppColors.success, size: 18),
                            const SizedBox(width: 8),
                            Expanded(child: Text(topic, style: const TextStyle(fontSize: 13))),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: AppColors.surfaceLight,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Enrollment Confirmed!'),
                content: Text('You are now registered for "${course.title}".'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK'))
                ],
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: course.isFree ? AppColors.badgeFreeBg : AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: Text(course.isFree ? 'Start Course Free' : 'Enroll for \$${course.price.toStringAsFixed(2)}'),
        ),
      ),
    );
  }
}

// ============================================================================
// 7. RESPONSIVE NAVIGATION SHELL (DRAWER / RAIL / BOTTOM BAR)
// ============================================================================

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _idx = 0;

  @override
  Widget build(BuildContext context) {
    final isDesktop = AppBreakpoints.isDesktop(context);
    final isTablet = AppBreakpoints.isTablet(context);

    if (isDesktop || isTablet) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _idx,
              onDestinationSelected: (i) => setState(() => _idx = i),
              labelType: NavigationRailLabelType.all,
              leading: Container(
                margin: const EdgeInsets.only(bottom: 20, top: 12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.auto_stories_rounded, color: Colors.white),
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.explore_outlined),
                  selectedIcon: Icon(Icons.explore_rounded),
                  label: Text('Catalog'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.play_lesson_outlined),
                  selectedIcon: Icon(Icons.play_lesson_rounded),
                  label: Text('Courses'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bookmark_outline),
                  selectedIcon: Icon(Icons.bookmark),
                  label: Text('Saved'),
                ),
              ],
            ),
            const VerticalDivider(width: 1, thickness: 1, color: AppColors.borderLight),
            const Expanded(child: CourseCatalogScreen()),
          ],
        ),
      );
    }

    return Scaffold(
      body: const CourseCatalogScreen(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _idx,
        onDestinationSelected: (i) => setState(() => _idx = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.explore_rounded), label: 'Catalog'),
          NavigationDestination(icon: Icon(Icons.play_lesson_rounded), label: 'My Learning'),
          NavigationDestination(icon: Icon(Icons.bookmark_rounded), label: 'Saved'),
        ],
      ),
    );
  }
}
