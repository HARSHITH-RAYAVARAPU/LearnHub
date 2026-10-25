/// Model representing a course item in the catalog.
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

  Course copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? category,
    String? instructor,
    String? instructorRole,
    double? rating,
    int? reviewCount,
    int? enrolledCount,
    String? duration,
    int? lectureCount,
    String? level,
    String? thumbnailUrl,
    double? price,
    double? originalPrice,
    bool? isFree,
    bool? isNew,
    bool? isBestseller,
    List<String>? syllabus,
    String? description,
    bool? isBookmarked,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      category: category ?? this.category,
      instructor: instructor ?? this.instructor,
      instructorRole: instructorRole ?? this.instructorRole,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      enrolledCount: enrolledCount ?? this.enrolledCount,
      duration: duration ?? this.duration,
      lectureCount: lectureCount ?? this.lectureCount,
      level: level ?? this.level,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      isFree: isFree ?? this.isFree,
      isNew: isNew ?? this.isNew,
      isBestseller: isBestseller ?? this.isBestseller,
      syllabus: syllabus ?? this.syllabus,
      description: description ?? this.description,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}
