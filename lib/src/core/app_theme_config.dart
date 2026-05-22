import 'package:flutter/material.dart';

class AppThemeConfig {
  const AppThemeConfig({
    this.seedColor = Colors.blue,
    this.useMaterial3 = true,
    this.borderRadius = 12.0,
    this.cardRadius,
    this.fontFamily,
    this.lightScaffoldColor,
    this.darkScaffoldColor,
    this.lightBackgroundColor,
    this.darkBackgroundColor,
    this.lightSurfaceColor,
    this.darkSurfaceColor,
    this.outlinedButtonSideWidth,
    this.outlinedButtonSideColor,
    this.elevatedButtonElevation,
    this.elevatedButtonTextStyle,
    this.outlinedButtonTextStyle,
    this.textButtonTextStyle,
    this.iconThemeColor,
  });

  // ── Core colours ──────────────────────────────────────────────────────────

  final Color seedColor;
  final bool useMaterial3;

  // ── Radii ─────────────────────────────────────────────────────────────────

  final double borderRadius;
  final double? cardRadius;

  // ── Typography ─────────────────────────────────────────────────────────────

  final String? fontFamily;

  // ── Background / Surface ──────────────────────────────────────────────────

  final Color? lightScaffoldColor;
  final Color? darkScaffoldColor;

  final Color? lightBackgroundColor;
  final Color? darkBackgroundColor;

  final Color? lightSurfaceColor;
  final Color? darkSurfaceColor;

  // ── Buttons ───────────────────────────────────────────────────────────────

  final double? elevatedButtonElevation;

  final double? outlinedButtonSideWidth;
  final Color? outlinedButtonSideColor;

  final TextStyle? elevatedButtonTextStyle;
  final TextStyle? outlinedButtonTextStyle;
  final TextStyle? textButtonTextStyle;

  // ── Misc ──────────────────────────────────────────────────────────────────

  final Color? iconThemeColor;

  // ── Convenience helpers ───────────────────────────────────────────────────

  double get effectiveCardRadius => cardRadius ?? borderRadius;
}
