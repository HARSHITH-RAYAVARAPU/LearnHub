import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/course.dart';
import 'course_badge.dart';

/// Commercial-grade Course Card widget.
/// Prominently showcases Stack and Positioned for thumbnail badge overlays,
/// fulfilling Experiment 2b requirements with production-level craftsmanship.
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
              color: _isHovered ? AppColors.shadowElevated : AppColors.shadowSubtle,
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
              // ==============================================================
              // SECTION 1: THUMBNAIL WITH STACK & POSITIONED BADGES (CORE FOCUS)
              // ==============================================================
              _buildThumbnailWithBadges(course),

              // ==============================================================
              // SECTION 2: CARD BODY CONTENT
              // ==============================================================
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Tag & Level
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
                              const Icon(Icons.signal_cellular_alt_rounded, size: 14, color: AppColors.textMuted),
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

                      // Course Title
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

                      // Instructor
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

                      // Rating & Enrolled Stats
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
                          const SizedBox(width: 4),
                          Text(
                            '(${_formatCount(course.reviewCount)})',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textMuted,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${_formatCount(course.enrolledCount)} learners',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20, color: AppColors.borderLight),

                      // Price & Enroll CTA
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (course.isFree)
                                const Text(
                                  'FREE',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.badgeFreeBg,
                                  ),
                                )
                              else
                                Text(
                                  '\$${course.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
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
                          ElevatedButton(
                            onPressed: widget.onTap,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: course.isFree ? AppColors.badgeFreeBg : AppColors.primary,
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

  /// Builds the thumbnail image accompanied by Stack and Positioned badge overlays.
  Widget _buildThumbnailWithBadges(Course course) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. BASE LAYER: Thumbnail Image with graceful error fallback
            Image.network(
              course.thumbnailUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
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
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  color: AppColors.surfaceMuted,
                  child: const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                );
              },
            ),

            // 2. GRADIENT SCRIM: Soft vignette for enhanced badge legibility
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x55000000),
                      Colors.transparent,
                      Colors.transparent,
                      Color(0x66000000),
                    ],
                    stops: [0.0, 0.25, 0.7, 1.0],
                  ),
                ),
              ),
            ),

            // 3. POSITIONED: "FREE" Badge (Top-Left primary slot)
            if (course.isFree)
              Positioned(
                top: 10,
                left: 10,
                child: CourseBadge.free(),
              ),

            // 4. POSITIONED: "NEW" Badge (Dynamic horizontal offset if Free badge is present)
            if (course.isNew)
              Positioned(
                top: 10,
                left: course.isFree ? 88 : 10,
                child: CourseBadge.isNew(),
              ),

            // 5. POSITIONED: "BESTSELLER" Badge (Top-Left second row or fallback slot)
            if (course.isBestseller && (!course.isFree || !course.isNew))
              Positioned(
                top: 10,
                left: (course.isFree || course.isNew) ? 88 : 10,
                child: CourseBadge.bestseller(),
              ),

            // 6. POSITIONED: Bookmark Button (Top-Right slot)
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
                      course.isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                      color: course.isBookmarked ? AppColors.warning : Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),

            // 7. POSITIONED: Duration & Lecture Count Pill (Bottom-Right slot)
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
    );
  }

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}
