import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Filtering and Search Bar component for the Course Catalog.
/// Provides category chips, badge-specific toggle filters (Free / New), and search.
class CourseFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final String selectedCategory;
  final bool filterFreeOnly;
  final bool filterNewOnly;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onCategorySelected;
  final ValueChanged<bool> onToggleFreeOnly;
  final ValueChanged<bool> onToggleNewOnly;
  final VoidCallback onClearAllFilters;
  final int resultCount;

  static const List<String> categories = [
    'All Categories',
    'Mobile Dev',
    'AI & Data',
    'Cloud & DevOps',
    'Design',
    'Web Dev',
    'Product',
    'Security',
  ];

  const CourseFilterBar({
    super.key,
    required this.searchController,
    required this.selectedCategory,
    required this.filterFreeOnly,
    required this.filterNewOnly,
    required this.onSearchChanged,
    required this.onCategorySelected,
    required this.onToggleFreeOnly,
    required this.onToggleNewOnly,
    required this.onClearAllFilters,
    required this.resultCount,
  });

  @override
  Widget build(BuildContext context) {
    final hasActiveFilter = selectedCategory != 'All Categories' ||
        filterFreeOnly ||
        filterNewOnly ||
        searchController.text.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Search Field
        TextField(
          controller: searchController,
          onChanged: onSearchChanged,
          decoration: InputDecoration(
            hintText: 'Search courses by title, topic, or instructor...',
            prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
            suffixIcon: searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close_rounded, size: 20),
                    onPressed: () {
                      searchController.clear();
                      onSearchChanged('');
                    },
                  )
                : null,
          ),
        ),
        const SizedBox(height: 14),

        // 2. Filter Pills Row (Badges, Category, Status)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              // FREE COURSES QUICK TOGGLE (Directly ties to Badge Requirement)
              FilterChip(
                selected: filterFreeOnly,
                onSelected: onToggleFreeOnly,
                label: const Text('Free Courses Only'),
                avatar: Icon(
                  Icons.card_giftcard_rounded,
                  size: 16,
                  color: filterFreeOnly ? Colors.white : AppColors.badgeFreeBg,
                ),
                selectedColor: AppColors.badgeFreeBg,
                backgroundColor: AppColors.surfaceLight,
                labelStyle: TextStyle(
                  color: filterFreeOnly ? Colors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: filterFreeOnly ? AppColors.badgeFreeBg : AppColors.borderLight,
                  ),
                ),
                showCheckmark: false,
              ),
              const SizedBox(width: 8),

              // NEW COURSES QUICK TOGGLE (Directly ties to Badge Requirement)
              FilterChip(
                selected: filterNewOnly,
                onSelected: onToggleNewOnly,
                label: const Text('New Releases'),
                avatar: Icon(
                  Icons.auto_awesome_rounded,
                  size: 16,
                  color: filterNewOnly ? Colors.white : AppColors.primary,
                ),
                selectedColor: AppColors.primary,
                backgroundColor: AppColors.surfaceLight,
                labelStyle: TextStyle(
                  color: filterNewOnly ? Colors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: filterNewOnly ? AppColors.primary : AppColors.borderLight,
                  ),
                ),
                showCheckmark: false,
              ),
              const SizedBox(width: 12),
              Container(width: 1, height: 24, color: AppColors.borderLight),
              const SizedBox(width: 12),

              // Category Chips
              ...categories.map((category) {
                final isSelected = selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) onCategorySelected(category);
                    },
                    selectedColor: AppColors.primaryLight,
                    backgroundColor: AppColors.surfaceLight,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.primary : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 13,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? AppColors.primary : AppColors.borderLight,
                      ),
                    ),
                    showCheckmark: false,
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // 3. Status Bar: Result Count & Clear Filters
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Showing $resultCount ${resultCount == 1 ? "course" : "courses"}',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (hasActiveFilter)
              TextButton.icon(
                onPressed: onClearAllFilters,
                icon: const Icon(Icons.refresh_rounded, size: 16),
                label: const Text('Reset Filters'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
