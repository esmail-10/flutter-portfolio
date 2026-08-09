import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../models/project_model.dart';

/// Static data for the portfolio projects.
class ProjectsData {
  ProjectsData._();

  static const List<Project> projects = [
    Project(
      id: 'tajhiz',
      name: 'Tajhiz',
      category: 'Home Services Marketplace',
      shortDescription:
          'Tajhiz is a home-services marketplace that connects customers '
          'with service providers such as plumbers, electricians, carpenters, '
          'and AC technicians.',
      overview:
          'Tajhiz is a full-stack home-services marketplace built with '
          'Flutter that connects customers directly with verified service '
          'providers. The app supports two distinct account types — customers '
          'and workers — each with their own dedicated flows for discovering '
          'services, booking appointments, and managing work. The project '
          'demonstrates a production-style architecture with a Node.js and '
          'MongoDB backend, real-time features, and a complete admin panel.',
      features: [
        'Customer & Worker accounts with dedicated experiences',
        'Secure authentication with JWT',
        'Service discovery across multiple categories',
        'Detailed worker profiles',
        'Complete booking system',
        'Booking status management for both sides',
        'Real-time chat between customers and workers',
        'In-chat image sharing',
        'Push notifications for bookings and messages',
        'Ratings & reviews after completed bookings',
        'Admin dashboard for platform management',
        'Worker approval workflow',
        'Complaint management system',
      ],
      technologies: [
        'Flutter',
        'Dart',
        'Bloc / Cubit',
        'Node.js',
        'Express.js',
        'MongoDB',
        'JWT',
        'Firebase',
        'REST APIs',
      ],
      architecture: [
        'Clean Architecture with a clear separation between UI, business logic, and data layers',
        'Feature-first folder structure to keep the codebase scalable and maintainable',
        'State management with Bloc and Cubit to keep flows predictable',
        'Repository pattern abstracting API communication from UI widgets',
        'Model classes with JSON serialization for a strongly-typed API layer',
      ],
      challenges: [
        'Designing a dual-role auth and UI flow for both customers and workers while keeping the codebase unified',
        'Implementing real-time chat with image sharing on top of a REST API',
        'Building a booking state machine that stays consistent across both users and admin',
        'Managing notification delivery so users only receive relevant events',
        'Keeping large feature modules decoupled so the app remains maintainable',
      ],
      logoAsset: 'assets/images/tajheez/applogo3.png',
      screenshotLabels: [
        'Splash',
        'Login & Signup',
        'Home',
        'Categories',
        'Search',
        'Services',
        'Notifications',
        'Chat',
        'Worker Dashboard',
        'Worker Profile',
        'Profile',
      ],
      screenshotAssets: [
        'assets/images/tajheez/splash_tajheez.png',
        'assets/images/tajheez/login_and_signup_tajheez.png',
        'assets/images/tajheez/home_tajheez.png',
        'assets/images/tajheez/categories_tajheez.png',
        'assets/images/tajheez/search_tajheez.png',
        'assets/images/tajheez/services_tajheez.png',
        'assets/images/tajheez/notifications_tajheez.png',
        'assets/images/tajheez/chats_tajheez.png',
        'assets/images/tajheez/worker_dashboard_tajheez.png',
        'assets/images/tajheez/worker_profile_tajheez.png',
        'assets/images/tajheez/profile_tajheez.png',
        'assets/images/tajheez/appsplashbanner_tajheez.jpg',
      ],
      screenshotColors: [
        Color(0xFF0E7490),
        Color(0xFF155E75),
        Color(0xFF164E63),
        Color(0xFF0369A1),
        Color(0xFF0E7490),
        Color(0xFF115E59),
        Color(0xFF1D4ED8),
        Color(0xFF0F766E),
        Color(0xFF7C3AED),
        Color(0xFF4338CA),
        Color(0xFF1E3A8A),
      ],
      screenshotIcons: [
        Icons.phone_iphone_rounded,
        Icons.login_rounded,
        Icons.home_rounded,
        Icons.grid_view_rounded,
        Icons.search_rounded,
        Icons.build_rounded,
        Icons.notifications_rounded,
        Icons.chat_bubble_rounded,
        Icons.dashboard_rounded,
        Icons.badge_rounded,
        Icons.person_rounded,
      ],
      githubUrl: AppConstants.tajhizGitHubUrl,
    ),
    Project(
      id: 'foody',
      name: 'Foody',
      category: 'Food Ordering Application',
      shortDescription:
          'Foody is a modern food ordering application that allows users to '
          'browse food categories, view products, manage their cart, and '
          'place orders.',
      overview:
          'Foody is a polished food ordering application built with Flutter '
          'and backed by Supabase. Users can explore food categories, search '
          'for products, view detailed product pages, manage a cart, and '
          'place orders with a full checkout flow. The project showcases a '
          'clean UI, smooth animations, and a well-structured integration '
          'with a PostgreSQL database through Supabase.',
      features: [
        'Smooth onboarding experience',
        'Authentication with Supabase Auth',
        'Home screen with curated food categories',
        'Food category browsing',
        'Detailed product view',
        'Product search',
        'Shopping cart management',
        'Full checkout flow',
        'Order placement and tracking',
        'Order history',
        'Favorites list',
        'Persistent user profile',
      ],
      technologies: [
        'Flutter',
        'Dart',
        'Supabase',
        'Supabase Authentication',
        'PostgreSQL',
        'REST/API Integration',
        'State Management',
      ],
      architecture: [
        'Clean separation between UI, state, and data layers',
        'Repository pattern to keep Supabase calls isolated from widgets',
        'Model-driven data flow with strongly-typed Dart models',
        'Reusable widget library for consistent screens and components',
        'Modular screens organized by feature',
      ],
      challenges: [
        'Structuring the cart state so it stays consistent across screens',
        'Handling optimistic UI updates during checkout',
        'Keeping authentication state synchronized across the app',
        'Designing a scalable database schema for orders and favorites',
        'Ensuring product search stays fast and predictable',
      ],
      logoAsset: 'assets/images/foody/foody_icon.png',
      screenshotLabels: [
        'Splash',
        'Onboarding',
        'Login',
        'Signup',
        'Home',
        'Categories',
        'Product Details',
        'Cart',
        'Cart Overview',
        'Checkout',
        'Checkout & Payment',
        'Order Summary',
        'Addresses',
        'Order History',
        'Favorites',
        'Profile',
      ],
      screenshotAssets: [
        'assets/images/foody/splash_foody.jpg',
        'assets/images/foody/onboarding_foody.jpg',
        'assets/images/foody/login_foody.jpg',
        'assets/images/foody/signup_foody.jpg',
        'assets/images/foody/home_1_foody.jpg',
        'assets/images/foody/home_2_foody.jpg',
        'assets/images/foody/product_details_foody.jpg',
        'assets/images/foody/cart_foody.jpg',
        'assets/images/foody/cart_2_foody.jpg',
        'assets/images/foody/checkout_foody.jpg',
        'assets/images/foody/checkkout_2_foody.jpg',
        'assets/images/foody/checkkout_3_foody.jpg',
        'assets/images/foody/payment_and_addresses_foody.jpg',
        'assets/images/foody/history_foody.jpg',
        'assets/images/foody/favorites_foody.jpg',
        'assets/images/foody/profile_foody.jpg',
        'assets/images/foody/splash_foody.jpg',
      ],
      screenshotColors: [
        Color(0xFFB45309),
        Color(0xFFC2410C),
        Color(0xFFEA580C),
        Color(0xFFD97706),
        Color(0xFFB45309),
        Color(0xFFC2410C),
        Color(0xFF9A3412),
        Color(0xFFEA580C),
        Color(0xFFC2410C),
        Color(0xFFD97706),
        Color(0xFFB45309),
        Color(0xFF9A3412),
        Color(0xFF92400E),
        Color(0xFFB91C1C),
        Color(0xFFDC2626),
        Color(0xFFEA580C),
      ],
      screenshotIcons: [
        Icons.phone_iphone_rounded,
        Icons.touch_app,
        Icons.login_rounded,
        Icons.person_add_rounded,
        Icons.home_rounded,
        Icons.storefront_rounded,
        Icons.fastfood_rounded,
        Icons.shopping_cart_rounded,
        Icons.add_shopping_cart_rounded,
        Icons.payment_rounded,
        Icons.credit_card_rounded,
        Icons.receipt_long_rounded,
        Icons.location_on_rounded,
        Icons.history_rounded,
        Icons.favorite_rounded,
        Icons.person_rounded,
      ],
      githubUrl: AppConstants.foodyGitHubUrl,
    ),
  ];

  static Project? getById(String id) {
    for (final project in projects) {
      if (project.id == id) return project;
    }
    return null;
  }
}

/// Skills data.
class SkillsData {
  SkillsData._();

  static const List<
    ({String title, List<({String name, IconData icon})> items})
  >
  categories = [
    (
      title: 'Frontend',
      items: [
        (name: 'Flutter', icon: Icons.phone_android_rounded),
        (name: 'Dart', icon: Icons.code_rounded),
        (name: 'Responsive UI', icon: Icons.screen_lock_landscape_rounded),
        (name: 'Custom Animations', icon: Icons.animation_rounded),
      ],
    ),
    (
      title: 'State Management',
      items: [
        (name: 'Bloc', icon: Icons.account_tree_rounded),
        (name: 'Cubit', icon: Icons.hub_rounded),
      ],
    ),
    (
      title: 'Backend & Database',
      items: [
        (name: 'Supabase', icon: Icons.cloud_rounded),
        (name: 'Firebase', icon: Icons.local_fire_department_rounded),
      ],
    ),
    (
      title: 'Tools',
      items: [
        (name: 'Git', icon: Icons.merge_type_rounded),
        (name: 'GitHub', icon: Icons.code_rounded),
        (name: 'Postman', icon: Icons.send_rounded),
        (name: 'Android Studio', icon: Icons.android_rounded),
        (name: 'VS Code', icon: Icons.edit_note_rounded),
      ],
    ),
  ];
}

/// Journey timeline data.
class JourneyData {
  JourneyData._();

  static const List<({String title, String description, IconData icon})> steps =
      [
        (
          title: 'Computer Science Graduate',
          description: 'Faculty of Computers and Information',
          icon: Icons.school_rounded,
        ),
        (
          title: 'Flutter Development',
          description: 'Built multiple applications using Flutter and Dart.',
          icon: Icons.phone_android_rounded,
        ),
        (
          title: 'Backend Integration',
          description: 'Worked with REST APIs, Firebase and Supabase.',
          icon: Icons.storage_rounded,
        ),
        (
          title: 'Portfolio',
          description:
              'Building professional applications and continuously improving '
              'Flutter development skills.',
          icon: Icons.rocket_launch_rounded,
        ),
      ];
}

/// Services data.
class ServicesData {
  ServicesData._();

  static const List<({String title, String description, IconData icon})>
  services = [
    (
      title: 'Mobile Applications',
      description:
          'End-to-end Flutter mobile apps for Android and iOS with clean, '
          'maintainable code.',
      icon: Icons.phone_android_rounded,
    ),
    (
      title: 'Flutter UI Development',
      description:
          'Pixel-perfect, responsive user interfaces with custom animations '
          'and smooth interactions.',
      icon: Icons.design_services_rounded,
    ),
    (
      title: 'REST API Integration',
      description:
          'Connecting mobile apps to backend services with clean repository '
          'patterns and typed models.',
      icon: Icons.api_rounded,
    ),
    (
      title: 'Firebase Integration',
      description:
          'Adding authentication, real-time features, push notifications, and '
          'storage powered by Firebase.',
      icon: Icons.local_fire_department_rounded,
    ),
    (
      title: 'Supabase Integration',
      description:
          'Building modern apps with Supabase Auth, PostgreSQL databases, and '
          'real-time capabilities.',
      icon: Icons.cloud_rounded,
    ),
    (
      title: 'Clean Architecture',
      description:
          'Structuring apps with a clear separation of concerns for scalable '
          'and maintainable codebases.',
      icon: Icons.account_tree_rounded,
    ),
  ];
}
