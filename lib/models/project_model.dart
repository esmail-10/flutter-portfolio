import 'package:flutter/material.dart';

class Project {
  final String id;
  final String name;
  final String category;
  final String shortDescription;
  final String overview;
  final List<String> features;
  final List<String> technologies;
  final List<String> architecture;
  final List<String> challenges;
  final List<String> screenshotLabels;
  final List<Color> screenshotColors;
  final List<IconData> screenshotIcons;
  final String? logoAsset;
  final List<String> screenshotAssets;
  final String? githubUrl;

  const Project({
    required this.id,
    required this.name,
    required this.category,
    required this.shortDescription,
    required this.overview,
    required this.features,
    required this.technologies,
    required this.architecture,
    required this.challenges,
    required this.screenshotLabels,
    required this.screenshotColors,
    required this.screenshotIcons,
    this.logoAsset,
    this.screenshotAssets = const [],
    this.githubUrl,
  });
}
