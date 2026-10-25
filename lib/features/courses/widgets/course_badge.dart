import 'package:flutter/material.dart';

/// Reusable Badge Pill component designed for overlaying on media assets.
/// Used within Stack & Positioned widgets across course catalog items.
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

  /// Factory constructor for "FREE" course badge
  factory CourseBadge.free({Key? key}) {
    return CourseBadge(
      key: key,
      label: 'FREE',
      backgroundColor: const Color(0xFF059669), // Emerald 600
      textColor: Colors.white,
      icon: Icons.check_circle_outline_rounded,
      isGlowing: true,
    );
  }

  /// Factory constructor for "NEW" course badge
  factory CourseBadge.isNew({Key? key}) {
    return CourseBadge(
      key: key,
      label: 'NEW',
      backgroundColor: const Color(0xFF4F46E5), // Indigo 600
      textColor: Colors.white,
      icon: Icons.bolt_rounded,
      isGlowing: true,
    );
  }

  /// Factory constructor for "BESTSELLER" course badge
  factory CourseBadge.bestseller({Key? key}) {
    return CourseBadge(
      key: key,
      label: 'BESTSELLER',
      backgroundColor: const Color(0xFFD97706), // Amber 600
      textColor: Colors.white,
      icon: Icons.star_rounded,
      isGlowing: false,
    );
  }

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 13,
              color: textColor,
            ),
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
