import 'package:flutter/material.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

const double _kAvatarSize = 0.6; // Adjust avatar size
const double _kBadgeSize = 0.6; // Adjust badge size
const double _kFontSize = 0.5; // Adjust font size
const double _kBorderWidth = 0.02; // Adjust border width

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    this.url,
    this.initials,
    this.uniqueKey,
    this.radius = 48,
    this.badgeIcon,
    this.badgeColor,
    this.borderColor,
    this.onTap,
    this.onTapIcon,
    super.key,
  }) : assert(url != null || initials != null, 'Either imageUrl or initials must be provided');

  /// The URL of the image to display.
  final String? url;

  /// The initials to display if the image is not available.
  final String? initials;

  /// A unique key to identify the avatar image
  final String? uniqueKey;

  /// The radius of the avatar with the default value of 48.
  final double radius;

  /// The color of the badge.
  final Color? badgeColor;

  /// The Icon of the badge.
  final IconData? badgeIcon;

  /// The color of the border.
  final Color? borderColor;

  /// The callback function to call when the avatar is tapped.
  final VoidCallback? onTap;

  /// The callback function to call when the avatar is tapped for editing.
  final VoidCallback? onTapIcon;

  @override
  Widget build(BuildContext context) {
    final size = radius * _kAvatarSize;

    final avatar = CircleAvatar(
      backgroundColor: context.inversePrimary,
      radius: size,
      backgroundImage: isTest ? null : (url != null ? NetworkImage(url!) : null),
      child: (url == null && initials != null
          ? Text(initials!, style: context.bodyLarge?.copyWith(fontSize: size * _kFontSize))
          : null),
    );

    // Build the core avatar and badge content
    Widget content = Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        if (borderColor != null)
          Container(
            decoration: BoxDecoration(color: borderColor, shape: BoxShape.circle),
            padding: const EdgeInsets.all(1),
            child: avatar,
          )
        else
          avatar,
        if (badgeColor != null)
          SizedBox(
            height: size * _kBadgeSize,
            width: size * _kBadgeSize,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: badgeColor,
                shape: BoxShape.circle,
                border: Border.fromBorderSide(BorderSide(color: context.surface, width: size * _kBorderWidth)),
              ),
            ),
          ),
        if (badgeIcon != null)
          SizedBox(
            height: size * _kBadgeSize,
            width: size * _kBadgeSize,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.primaryContainer,
                shape: BoxShape.circle,
                border: Border.fromBorderSide(BorderSide(color: context.surface, width: size * _kBorderWidth)),
              ),
              child: InkWell(
                onTap: onTapIcon,
                child: Icon(badgeIcon, color: context.onPrimaryContainer),
              ),
            ),
          ),
      ],
    );

    // Only wrap with Hero if we have a non-null uniqueKey
    if (uniqueKey != null) {
      final heroTag = '${url ?? initials ?? 'avatar'}-$uniqueKey';

      content = Hero(tag: heroTag, child: content);
    }

    return InkWell(onTap: onTap, child: content,
    );
  }
}
