import 'package:flutter/material.dart';

class PageConfig {
  const PageConfig({
    required this.icon,
    required this.name,
    Widget? child,
  }) : child = child ?? const Placeholder();

  final IconData icon;
  final String name;
  final Widget child;
}
