import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Button type enum
// ---------------------------------------------------------------------------

/// Pre‑defined button variants.
enum AppButtonType {
  elevated,
  filled,
  outlined,
  text,
  tonal,
  icon,
  floatingAction,
  extendedFloatingAction,
  custom,
}

// ---------------------------------------------------------------------------
// AppButtons widget
// ---------------------------------------------------------------------------

/// A reusable, extensible button widget that maps [AppButtonType] to the
/// corresponding Flutter button.
///
/// **Extensibility** – for the `custom` type you provide a [customBuilder]
/// that receives the parent [BuildContext] and returns any [Widget].
/// Alternatively you can subclass or compose this widget and override
/// how any type is rendered.
class AppButtons extends StatelessWidget {
  const AppButtons({
    super.key,
    required this.type,
    required this.label,
    this.icon,
    this.onPressed,
    this.onLongPress,
    this.isSelected,
    this.onSelectionChanged,
    this.isEnabled = true,
    this.style,
    this.customBuilder,
    this.size,
  });

  // ── Required ─────────────────────────────────────────────────────────────

  /// Which button variant to render.
  final AppButtonType type;

  /// Text shown on the button.
  final String label;

  // ── Optional callbacks ───────────────────────────────────────────────────

  /// Primary tap handler (ignored for `segmented` / `toggle`).
  final VoidCallback? onPressed;

  /// Long‑press handler (ignored for `segmented` / `toggle`).
  final VoidCallback? onLongPress;

  /// Used for `icon` / `floatingAction` / `extendedFloatingAction`.
  final Widget? icon;

  // ── Segmented / toggle support ──────────────────────────────────────────

  /// Currently‑selected segments (for `segmented`).
  final Set<int>? isSelected;

  /// Selection callback (for `segmented`).
  final ValueChanged<Set<int>>? onSelectionChanged;

  // ── Misc ─────────────────────────────────────────────────────────────────

  /// Whether the button is interactive (default `true`).
  final bool isEnabled;

  /// Override the look for buttons that support [ButtonStyle].
  final ButtonStyle? style;

  /// **Extensibility hook.**  When [type] is `custom` this builder is used.
  final Widget Function(BuildContext context)? customBuilder;

  /// Icon size hint, used for `icon` and `floatingAction` variants.
  final double? size;

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }

  /// Override this method in a subclass to customise individual variants.
  @protected
  Widget _build(BuildContext context) {
    // The custom case bypasses all internal logic.
    if (type == AppButtonType.custom) {
      if (customBuilder != null) return customBuilder!(context);
      throw ArgumentError(
        'When AppButtonType.custom is used you must provide a [customBuilder].',
      );
    }

    // Build the correct button based on the enum value.
    return _byType(context);
  }

  Widget _byType(BuildContext context) {
    switch (type) {
      case AppButtonType.elevated:
        return _elevated();
      case AppButtonType.filled:
        return _filled();
      case AppButtonType.outlined:
        return _outlined();
      case AppButtonType.text:
        return _text();
      case AppButtonType.tonal:
        return _tonal();
      case AppButtonType.icon:
        return _iconButton();
      case AppButtonType.floatingAction:
        return _fab();
      case AppButtonType.extendedFloatingAction:
        return _extendedFab();
      case AppButtonType.custom:
        return const SizedBox.shrink(); // handled above
    }
  }

  // ── Concrete builders (public so subclasses can override individually) ───

  @protected
  Widget _elevated() {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      onLongPress: isEnabled ? onLongPress : null,
      style: style,
      child: Text(label),
    );
  }

  @protected
  Widget _filled() {
    return FilledButton(
      onPressed: isEnabled ? onPressed : null,
      onLongPress: isEnabled ? onLongPress : null,
      style: style,
      child: Text(label),
    );
  }

  @protected
  Widget _outlined() {
    return OutlinedButton(
      onPressed: isEnabled ? onPressed : null,
      onLongPress: isEnabled ? onLongPress : null,
      style: style,
      child: Text(label),
    );
  }

  @protected
  Widget _text() {
    return TextButton(
      onPressed: isEnabled ? onPressed : null,
      onLongPress: isEnabled ? onLongPress : null,
      style: style,
      child: Text(label),
    );
  }

  @protected
  Widget _tonal() {
    return FilledButton.tonal(
      onPressed: isEnabled ? onPressed : null,
      onLongPress: isEnabled ? onLongPress : null,
      style: style,
      child: Text(label),
    );
  }

  @protected
  Widget _iconButton() {
    return IconButton(
      onPressed: isEnabled ? onPressed : null,
      onLongPress: isEnabled ? onLongPress : null,
      icon: icon ?? const Icon(Icons.more_horiz),
      style: style,
    );
  }

  @protected
  Widget _fab() {
    return FloatingActionButton(
      onPressed: isEnabled ? onPressed : null,
      heroTag: label,
      child: icon ?? const Icon(Icons.add),
    );
  }

  @protected
  Widget _extendedFab() {
    return FloatingActionButton.extended(
      onPressed: isEnabled ? onPressed : null,
      heroTag: label,
      icon: icon,
      label: Text(label),
    );
  }

  // ── Variants with icon.label sugar ───────────────────────────────────────

  /// Shortcut: same as [AppButtons] with [icon] and [type] = `.elevated`.
  factory AppButtons.elevated({
    required String label,
    Widget? icon,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    bool isEnabled = true,
    ButtonStyle? style,
  }) => AppButtons(
    type: AppButtonType.elevated,
    label: label,
    icon: icon,
    onPressed: onPressed,
    onLongPress: onLongPress,
    isEnabled: isEnabled,
    style: style,
  );

  /// Shortcut: `.filled` with optional icon.
  factory AppButtons.filled({
    required String label,
    Widget? icon,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    bool isEnabled = true,
    ButtonStyle? style,
  }) => AppButtons(
    type: AppButtonType.filled,
    label: label,
    icon: icon,
    onPressed: onPressed,
    onLongPress: onLongPress,
    isEnabled: isEnabled,
    style: style,
  );

  /// Shortcut: `.outlined` with optional icon.
  factory AppButtons.outlined({
    required String label,
    Widget? icon,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    bool isEnabled = true,
    ButtonStyle? style,
  }) => AppButtons(
    type: AppButtonType.outlined,
    label: label,
    icon: icon,
    onPressed: onPressed,
    onLongPress: onLongPress,
    isEnabled: isEnabled,
    style: style,
  );

  /// Shortcut: `.text` with optional icon.
  factory AppButtons.text({
    required String label,
    Widget? icon,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    bool isEnabled = true,
    ButtonStyle? style,
  }) => AppButtons(
    type: AppButtonType.text,
    label: label,
    icon: icon,
    onPressed: onPressed,
    onLongPress: onLongPress,
    isEnabled: isEnabled,
    style: style,
  );

  /// Shortcut: `.tonal` with optional icon.
  factory AppButtons.tonal({
    required String label,
    Widget? icon,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    bool isEnabled = true,
    ButtonStyle? style,
  }) => AppButtons(
    type: AppButtonType.tonal,
    label: label,
    icon: icon,
    onPressed: onPressed,
    onLongPress: onLongPress,
    isEnabled: isEnabled,
    style: style,
  );

  /// Shortcut: `.icon` button.
  factory AppButtons.iconOnly({
    required Widget icon,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    bool isEnabled = true,
    ThemeData? theme,
  }) => AppButtons(
    type: AppButtonType.icon,
    label: '',
    icon: icon,
    onPressed: onPressed,
    onLongPress: onLongPress,
    isEnabled: isEnabled,
  );

  /// Shortcut: `.floatingAction`.
  factory AppButtons.fab({
    required Widget icon,
    VoidCallback? onPressed,
    bool isEnabled = true,
  }) => AppButtons(
    type: AppButtonType.floatingAction,
    label: '',
    icon: icon,
    onPressed: onPressed,
    isEnabled: isEnabled,
  );

  /// Shortcut: `.extendedFloatingAction`.
  factory AppButtons.extendedFab({
    required String label,
    Widget? icon,
    VoidCallback? onPressed,
    bool isEnabled = true,
  }) => AppButtons(
    type: AppButtonType.extendedFloatingAction,
    label: label,
    icon: icon,
    onPressed: onPressed,
    isEnabled: isEnabled,
  );
}
