import 'package:flutter/material.dart';

/// Represents a main navigation item in the Oromia Communication Bureau app.
/// It includes the title, icon, and optional sub-items for nested navigation.
class NavItem {
  final String title;
  final IconData icon;
  final List<String>? subItems;
  final String? route;

  NavItem({
    required this.title,
    required this.icon,
    this.subItems,
    this.route,
  });

  /// Factory method to create a NavItem with sub-items.
  factory NavItem.withSubItems({
    required String title,
    required IconData icon,
    required List<String> subItems,
    String? route,
  }) {
    return NavItem(
      title: title,
      icon: icon,
      subItems: subItems,
      route: route,
    );
  }
}
