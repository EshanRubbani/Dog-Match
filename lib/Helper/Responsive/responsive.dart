import 'package:flutter/material.dart';

class ResponsiveNess extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const ResponsiveNess({
    super.key,
    required this.mobile,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768;

  @override
  Widget build(BuildContext context) {
    if (isDesktop(context)) {
      return desktop;
    } else {
      return mobile;
    }
  }
}
