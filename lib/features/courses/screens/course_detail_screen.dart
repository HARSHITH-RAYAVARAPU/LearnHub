import 'package:flutter/material.dart';
import '../../../core/constants/app_breakpoints.dart';
import '../../../core/constants/app_colors.dart';
import '../models/course.dart';
import '../widgets/course_badge.dart';

/// Detailed course overview screen.
/// Features high-impact hero banner, syllabus checklist, and seamless enrollment flow.
class CourseDetailScreen extends StatefulWidget {
  final Course course;
  final VoidCallback onBookmarkToggle;

  const CourseDetailScreen({
    super.key,
    required this.course,
    required this.onBookmarkToggle,
  });

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  late bool _isBookmarked;
  bool _isEnrolled = false;

  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.course.isBookmarked;
  }

  void _handleEnrollment() {
    setState(() => _isEnrolled = true);
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: const [
            Icon(Icons.check_circle_rounded, color: AppColors.success, size: 28),
            SizedBox(width: 10),
            Text('Enrollment Confirmed!', style: TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
        content: Text(
          'You have successfully enrolled in "${widget.course.title}". Start with Module 1 anytime from your dashboard.',
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.4),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text('Go to Courseware'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    final isDesktop = AppBreakpoints.isDesktop(context);
    final horizontalPadding = AppBreakpoints.getHorizontalPadding(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          course.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
              color: _isBookmarked ? AppColors.warning : AppColors.textPrimary,
            ),
            onPressed: () {
              setState(() => _isBookmarked = !_isBookmarked);
              widget.onBookmarkToggle();
            },
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Course link copied to clipboard!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1080),
          child: isDesktop ? _buildDesktopLayout(course) : _buildMobileLayout(course, horizontalPadding),
        ),
      ),
      bottomNavigationBar: isDesktop ? null : _buildBottomActionBar(course),
    );
  }

  Widget _buildMobileLayout(Course course, double horizontalPadding) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroThumbnail(course),
          Padding(
            padding: EdgeInsets.all(horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCourseHeader(course),
                const SizedBox(height: 20),
                _buildMetricsRow(course),
                const SizedBox(height: 24),
                _buildInstructorCard(course),
                const SizedBox(height: 24),
                _buildDescriptionSection(course),
                const SizedBox(height: 24),
                _buildSyllabusSection(course),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(Course course) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Main details, instructor, curriculum
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCourseHeader(course),
                const SizedBox(height: 20),
                _buildMetricsRow(course),
                const SizedBox(height: 24),
                _buildInstructorCard(course),
                const SizedBox(height: 24),
                _buildDescriptionSection(course),
                const SizedBox(height: 24),
                _buildSyllabusSection(course),
              ],
            ),
          ),
          const SizedBox(width: 32),

          // Right: Sticky checkout card featuring the hero thumbnail & badges
          Expanded(
            flex: 4,
            child: Card(
              elevation: 4,
              shadowColor: AppColors.shadowElevated,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroThumbnail(course),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              course.isFree ? 'FREE' : '\$${course.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                color: course.isFree ? AppColors.badgeFreeBg : AppColors.textPrimary,
                              ),
                            ),
                            if (course.originalPrice != null) ...[
                              const SizedBox(width: 10),
                              Text(
                                '\$${course.originalPrice!.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isEnrolled ? null : _handleEnrollment,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: course.isFree ? AppColors.badgeFreeBg : AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              _isEnrolled
                                  ? 'Enrolled'
                                  : (course.isFree ? 'Enroll for Free' : 'Buy Now'),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Includes:',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        _buildFeatureBullet(Icons.all_inclusive_rounded, 'Full lifetime access'),
                        _buildFeatureBullet(Icons.devices_rounded, 'Access on mobile, tablet & desktop'),
                        _buildFeatureBullet(Icons.verified_rounded, 'Certificate of completion'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Showcase of Stack and Positioned in the Course Detail Hero view
  Widget _buildHeroThumbnail(Course course) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            course.thumbnailUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: const Color(0xFF1E293B),
              child: const Icon(Icons.school_rounded, color: Colors.white, size: 48),
            ),
          ),
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black26, Colors.transparent, Colors.black54],
                ),
              ),
            ),
          ),
          if (course.isFree)
            Positioned(
              top: 14,
              left: 14,
              child: CourseBadge.free(),
            ),
          if (course.isNew)
            Positioned(
              top: 14,
              left: course.isFree ? 96 : 14,
              child: CourseBadge.isNew(),
            ),
          Positioned(
            bottom: 12,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  const Icon(Icons.video_collection_outlined, size: 13, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(
                    '${course.lectureCount} Lectures (${course.duration})',
                    style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseHeader(Course course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            course.category.toUpperCase(),
            style: const TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          course.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Text(
          course.subtitle,
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.4),
        ),
      ],
    );
  }

  Widget _buildMetricsRow(Course course) {
    return Row(
      children: [
        const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
        const SizedBox(width: 4),
        Text(
          course.rating.toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        const SizedBox(width: 4),
        Text(
          '(${course.reviewCount} reviews)',
          style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
        ),
        const SizedBox(width: 16),
        const Icon(Icons.people_outline_rounded, size: 18, color: AppColors.textMuted),
        const SizedBox(width: 4),
        Text(
          '${course.enrolledCount} learners',
          style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildInstructorCard(Course course) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.primaryLight,
            child: Text(
              course.instructor.substring(0, 1),
              style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.instructor,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                Text(
                  course.instructorRole,
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(Course course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About this course',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Text(
          course.description,
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildSyllabusSection(Course course) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Curriculum & Syllabus',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        ...course.syllabus.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final topic = entry.value;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.primaryLight,
                  child: Text(
                    '$index',
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    topic,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
                const Icon(Icons.check_circle_outline_rounded, size: 16, color: AppColors.textMuted),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildFeatureBullet(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar(Course course) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: const BoxDecoration(
        color: AppColors.surfaceLight,
        border: Border(top: BorderSide(color: AppColors.borderLight)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.isFree ? 'FREE' : '\$${course.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: course.isFree ? AppColors.badgeFreeBg : AppColors.textPrimary,
                  ),
                ),
                if (course.originalPrice != null)
                  Text(
                    '\$${course.originalPrice!.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 11,
                      decoration: TextDecoration.lineThrough,
                      color: AppColors.textMuted,
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                onPressed: _isEnrolled ? null : _handleEnrollment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: course.isFree ? AppColors.badgeFreeBg : AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  _isEnrolled ? 'Enrolled' : (course.isFree ? 'Enroll for Free' : 'Enroll Now'),
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
