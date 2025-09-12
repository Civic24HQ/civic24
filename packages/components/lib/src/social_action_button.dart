import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:styles/styles.dart';

/// An action button with an icon plus optional count that
/// supports different variants through the named constructors.
class SocialActionButton extends StatelessWidget {
  const SocialActionButton._({
    required this.iconActive,
    required this.iconInActive,
    required this.onTap,
    this.isActive = false,
    this.count,
    this.scaleStrength = ScaleStrength.sm,
    this.activeColor,
    this.inactiveColor,
    this.size,
    this.spacing,
    this.tooltip,
    super.key,
  });

  /// Thumbs Up (Like)
  factory SocialActionButton.thumbsUp({
    required bool isActive,
    required VoidCallback? onTap,
    int? count,
    ScaleStrength scaleStrength = ScaleStrength.sm,
    Color? activeColor,
    Color? inactiveColor,
    double? size,
    double? spacing,
    String? tooltip,
    Key? key,
  }) {
    return SocialActionButton._(
      key: key,
      iconInActive: SolarIconsOutline.like,
      iconActive: SolarIconsOutline.like,
      isActive: isActive,
      onTap: onTap,
      count: count,
      scaleStrength: scaleStrength,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      size: size,
      spacing: spacing,
      tooltip: tooltip ?? 'Like',
    );
  }

  /// Thumbs Down (Dislike)
  factory SocialActionButton.thumbsDown({
    required bool isActive,
    required VoidCallback? onTap,
    int? count,
    ScaleStrength scaleStrength = ScaleStrength.sm,
    Color? activeColor,
    Color? inactiveColor,
    double? size,
    double? spacing,
    String? tooltip,
    Key? key,
  }) {
    return SocialActionButton._(
      key: key,
      iconInActive: SolarIconsOutline.dislike,
      iconActive: SolarIconsOutline.dislike,
      isActive: isActive,
      onTap: onTap,
      count: count,
      scaleStrength: scaleStrength,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      size: size,
      spacing: spacing,
      tooltip: tooltip ?? 'Dislike',
    );
  }

  /// Comment
  factory SocialActionButton.comment({
    required VoidCallback? onTap,
    int? count,
    ScaleStrength scaleStrength = ScaleStrength.sm,
    Color? color,
    double? size,
    double? spacing,
    String? tooltip,
    Key? key,
  }) {
    return SocialActionButton._(
      key: key,
      iconInActive: SolarIconsOutline.chatRound,
      iconActive: SolarIconsBold.chatRound,
      onTap: onTap,
      count: count,
      scaleStrength: scaleStrength,
      activeColor: color,
      inactiveColor: color,
      size: size,
      spacing: spacing,
      tooltip: tooltip ?? 'Comments',
    );
  }

  /// Bookmark
  factory SocialActionButton.bookmark({
    required bool isActive,
    required VoidCallback? onTap,
    int? count,
    ScaleStrength scaleStrength = ScaleStrength.sm,
    Color? activeColor,
    Color? inactiveColor,
    double? size,
    double? spacing,
    String? tooltip,
    Key? key,
  }) {
    return SocialActionButton._(
      key: key,
      iconInActive: SolarIconsOutline.bookmark,
      iconActive: SolarIconsOutline.bookmark,
      isActive: isActive,
      onTap: onTap,
      count: count,
      scaleStrength: scaleStrength,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      size: size,
      spacing: spacing,
      tooltip: tooltip ?? 'Bookmark',
    );
  }

  /// Base config
  final IconData iconActive;
  final IconData iconInActive;
  final VoidCallback? onTap;
  final bool isActive;
  final int? count;

  final ScaleStrength scaleStrength;
  final Color? activeColor;
  final Color? inactiveColor;
  final double? size;
  final double? spacing;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final resolvedActive = activeColor ?? context.primary;
    final resolvedInactive = inactiveColor ?? context.onSurfaceVariant;
    final resolvedSize = size ?? AppDimensions.size20;
    final gap = spacing ?? AppDimensions.size8;

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isActive ? iconActive : iconInActive,
          size: resolvedSize,
          color: isActive ? resolvedActive : resolvedInactive,
        ),
        if (count != null) SizedBox(width: gap),
        if (count != null)
          Text(
            count!.toString(),
            style: context.bodyMedium?.copyWith(color: isActive ? resolvedActive : resolvedInactive),
          ),
      ],
    );

    final tappable = Tappable.scaled(
      backgroundColor: Colors.transparent,
      scaleStrength: scaleStrength,
      onTap: onTap,
      child: content,
    );

    if (tooltip == null || tooltip!.isEmpty) return tappable;

    return Tooltip(message: tooltip, child: tappable);
  }
}
