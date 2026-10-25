import 'package:flutter/material.dart';
import '../../../core/constants/app_breakpoints.dart';
import '../../../core/constants/app_colors.dart';
import '../data/course_data.dart';
import '../models/course.dart';
import '../widgets/course_card.dart';
import '../widgets/course_filter_bar.dart';
import 'course_detail_screen.dart';

/// Main Responsive Course Catalog Screen.
/// Adapts dynamically across Mobile, Tablet, and Desktop viewport sizes.
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
    return _allCourses.where((course) {
      // 1. Search Query
      final query = _searchController.text.trim().toLowerCase();
      if (query.isNotEmpty) {
        final matchesTitle = course.title.toLowerCase().contains(query);
        final matchesInstructor = course.instructor.toLowerCase().contains(query);
        final matchesCategory = course.category.toLowerCase().contains(query);
        final matchesDesc = course.description.toLowerCase().contains(query);
        if (!matchesTitle && !matchesInstructor && !matchesCategory && !matchesDesc) {
          return false;
        }
      }

      // 2. Category Filter
      if (_selectedCategory != 'All Categories' && course.category != _selectedCategory) {
        return false;
      }

      // 3. Free Badge Filter
      if (_filterFreeOnly && !course.isFree) {
        return false;
      }

      // 4. New Badge Filter
      if (_filterNewOnly && !course.isNew) {
        return false;
      }

      return true;
    }).toList();
  }

  void _toggleBookmark(Course course) {
    setState(() {
      course.isBookmarked = !course.isBookmarked;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          course.isBookmarked
              ? 'Saved "${course.title}" to your bookmarks'
              : 'Removed from bookmarks',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'DISMISS',
          textColor: Colors.amber,
          onPressed: () {},
        ),
      ),
    );
  }

  void _navigateToDetail(Course course) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CourseDetailScreen(
          course: course,
          onBookmarkToggle: () => _toggleBookmark(course),
        ),
      ),
    );
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _selectedCategory = 'All Categories';
      _filterFreeOnly = false;
      _filterNewOnly = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = AppBreakpoints.getHorizontalPadding(context);
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
                // Top App Banner / Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(horizontalPadding, 24, horizontalPadding, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeroHeader(isDesktop),
                        const SizedBox(height: 24),
                        CourseFilterBar(
                          searchController: _searchController,
                          selectedCategory: _selectedCategory,
                          filterFreeOnly: _filterFreeOnly,
                          filterNewOnly: _filterNewOnly,
                          resultCount: _filteredCourses.length,
                          onSearchChanged: (_) => setState(() {}),
                          onCategorySelected: (cat) => setState(() => _selectedCategory = cat),
                          onToggleFreeOnly: (val) => setState(() => _filterFreeOnly = val),
                          onToggleNewOnly: (val) => setState(() => _filterNewOnly = val),
                          onClearAllFilters: _clearFilters,
                        ),
                      ],
                    ),
                  ),
                ),

                // Course Grid or Empty State
                if (_filteredCourses.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _buildEmptyState(),
                  )
                else
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(horizontalPadding, 12, horizontalPadding, 40),
                    sliver: _buildResponsiveGrid(context),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroHeader(bool isDesktop) {
    return Container(
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
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.workspace_premium_rounded, size: 14, color: Colors.amberAccent),
                    SizedBox(width: 6),
                    Text(
                      'FEATURED CATALOG 2026',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Master in-demand skills with industry-leading courses',
            style: TextStyle(
              color: Colors.white,
              fontSize: isDesktop ? 28 : 20,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Explore certified curricula featuring Free introductory tracks & brand-New interactive labs.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: isDesktop ? 15 : 13,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponsiveGrid(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount;
    double childAspectRatio;

    if (width < 650) {
      // Mobile View: Single column comfortable card
      crossAxisCount = 1;
      childAspectRatio = 1.05;
    } else if (width < 950) {
      // Small Tablet: 2 columns
      crossAxisCount = 2;
      childAspectRatio = 0.78;
    } else if (width < 1250) {
      // Large Tablet / Laptop: 3 columns
      crossAxisCount = 3;
      childAspectRatio = 0.75;
    } else {
      // Desktop: 4 columns
      crossAxisCount = 4;
      childAspectRatio = 0.73;
    }

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: childAspectRatio,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final course = _filteredCourses[index];
          return CourseCard(
            course: course,
            onTap: () => _navigateToDetail(course),
            onBookmarkToggle: () => _toggleBookmark(course),
          );
        },
        childCount: _filteredCourses.length,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 48,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'No courses match your criteria',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try adjusting your search terms or clearing the active filters.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _clearFilters,
              icon: const Icon(Icons.refresh_rounded, size: 16),
              label: const Text('Reset All Filters'),
            ),
          ],
        ),
      ),
    );
  }
}
