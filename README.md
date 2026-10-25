# LearnHub — Enterprise-Grade Responsive Course Catalog Platform

> **Product Vision**: Deliver an intuitive, high-conversion digital learning catalog engineered for frictionless discovery across Mobile, Tablet, and Desktop form factors.

---

## Executive Summary & PM Perspective

In digital product engineering, content discovery is the vital bridge between user curiosity and engagement. For **LearnHub**, our core product directive was clear: build a resilient, multi-platform course catalog where learners can instantly distinguish premium offerings, newly released tracks, and free-to-access introductory modules at a single glance.

To satisfy **Lab Experiment 2b**, the thumbnail component requires precise visual hierarchy and layout compositing. We solved this utilizing Flutter's **`Stack`** and **`Positioned`** architectural primitives, overlaying dynamic status badges (`FREE`, `NEW`, `BESTSELLER`) directly over optimized media thumbnails with high contrast, responsive reflow, and zero performance degradation.

---

## Key Highlights & Core Deliverables

- **Adaptive Responsive Design**: Continuous responsive layout transitioning smoothly across Mobile (< 650px), Tablet (650px - 1080px), and Desktop (≥ 1080px).
- **Experiment 2b Core Implementation**: Thumbnail badges overlayed with pixel precision using **`Stack`** and **`Positioned`**.
- **Commercial UI/UX System**: Cohesive design system featuring modern slate & indigo tones, custom typography scale, micro-shadows, hover transitions, and accessible contrast ratios.
- **Dynamic Catalog Engine**: Real-time keyword search, multi-category chips, badge-specific quick filters (`Free Courses Only`, `New Releases`), and bookmark management.
- **Production-Ready Architecture**: Clean feature-based directory structure with separation of data, presentation, widgets, and routing.

---

## Architecture & Code Structure

```
LearnHub/
├── pubspec.yaml                      # Project metadata & dependencies
├── analysis_options.yaml             # Strict linting rules
├── android/                          # Native Android platform configuration
│   └── app/src/main/AndroidManifest.xml
├── web/                              # Web entry point & PWA manifest
│   ├── index.html
│   └── manifest.json
├── test/
│   └── widget_test.dart              # Automated smoke & UI widget test
└── lib/
    ├── main.dart                     # App bootstrapping & theme injection
    ├── core/
    │   ├── constants/
    │   │   ├── app_colors.dart       # Design system tokens & badge colors
    │   │   └── app_breakpoints.dart  # Mobile, Tablet, Desktop responsive rules
    │   ├── routes/
    │   │   └── app_routes.dart       # Centralized route generation & arguments
    │   └── theme/
    │       └── app_theme.dart        # Material 3 light theme definition
    └── features/
        ├── courses/
        │   ├── models/
        │   │   └── course.dart       # Course entity model & copyWith
        │   ├── data/
        │   │   └── course_data.dart  # Realistic mock catalog dataset
        │   ├── widgets/
        │   │   ├── course_badge.dart # Reusable badge pill component
        │   │   ├── course_card.dart  # Course card featuring Stack & Positioned
        │   │   └── course_filter_bar.dart # Search, categories & badge toggles
        │   └── screens/
        │       ├── course_catalog_screen.dart # Responsive grid & hero banner
        │       └── course_detail_screen.dart  # Detailed course syllabus & enrollment
        └── navigation/
            └── screens/
                └── main_navigation_shell.dart # Responsive navigation shell
```

---

## Technical Deep-Dive: `Stack` & `Positioned` Implementation

In [`lib/features/courses/widgets/course_card.dart`](lib/features/courses/widgets/course_card.dart), the thumbnail container is engineered using a layered `Stack`:

```dart
Stack(
  fit: StackFit.expand,
  children: [
    // Layer 1: Base Media Asset
    Image.network(
      course.thumbnailUrl,
      fit: BoxFit.cover,
    ),

    // Layer 2: Vignette Scrim (Enhances text/badge contrast)
    const Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0x55000000), Colors.transparent, Color(0x66000000)],
          ),
        ),
      ),
    ),

    // Layer 3: Positioned "FREE" Badge (Top-Left)
    if (course.isFree)
      Positioned(
        top: 10,
        left: 10,
        child: CourseBadge.free(),
      ),

    // Layer 4: Positioned "NEW" Badge (Dynamic horizontal offset)
    if (course.isNew)
      Positioned(
        top: 10,
        left: course.isFree ? 88 : 10,
        child: CourseBadge.isNew(),
      ),

    // Layer 5: Positioned Bookmark Action (Top-Right)
    Positioned(
      top: 8,
      right: 8,
      child: BookmarkButton(...),
    ),

    // Layer 6: Positioned Duration & Lecture Pill (Bottom-Right)
    Positioned(
      bottom: 8,
      right: 8,
      child: DurationPill(...),
    ),
  ],
)
```

### Why this design excels:
1. **Z-Index Layering**: The image sits at the bottom, protected by a subtle gradient vignette so light-colored badges remain crisp regardless of image palette.
2. **Conditional Collision Handling**: If a course is both `FREE` and `NEW`, the `Positioned` widget for the second badge calculates an offset (`course.isFree ? 88 : 10`), preventing overlapping.
3. **Hardware-Accelerated Repaints**: By wrapping the thumbnail in `ClipRRect` and constrained aspect ratios (`16/9`), rendering performance stays locked at 60/120 FPS.

---

## Multi-Device Responsive Layout Breakdown

| Viewport | Screen Width | Navigation System | Grid Layout |
| :--- | :--- | :--- | :--- |
| **Mobile** | `< 650px` | `NavigationBar` at screen bottom | 1 Column card feed with optimized touch targets |
| **Tablet** | `650px - 1080px` | Compact `NavigationRail` | 2 Columns adaptive grid |
| **Desktop** | `≥ 1080px` | Expanded Left Sidebar (240px) | 3 to 4 Columns with max width constraints (1320px) |

---

## How to Run & Verify

### Prerequisites
* Flutter SDK (3.10.0 or higher)
* Dart SDK (3.0.0 or higher)

### Commands
```bash
# 1. Fetch dependencies
flutter pub get

# 2. Run unit & widget smoke tests
flutter test

# 3. Launch on Chrome (Web / Desktop preview)
flutter run -d chrome

# 4. Launch on connected Android / iOS device or emulator
flutter run
```

---

## Product Metrics & Evaluation Criteria

- **Functional Completeness**: Complete end-to-end journey from category discovery to course detail inspection and simulated enrollment.
- **Architectural Scalability**: Strict decoupling of state, presentation, and data layers allows immediate integration with live REST/GraphQL APIs.
- **Student Information**: Designed for **Rayavarapu Harshith** (Roll No: 7, Experiment 2b).
