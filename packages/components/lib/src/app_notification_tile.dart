import 'package:flutter/material.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

class AppNotificationTile extends StatelessWidget {
  const AppNotificationTile({
    required this.title,
    required this.description,
    required this.timestamp,
    this.hasBeenSeen = false,
    this.onTap,
    super.key,
  });
  final String title;
  final String description;
  final DateTime timestamp;
  final bool hasBeenSeen;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          padding: AppEdgeInsets.padding12,
          decoration: BoxDecoration(
            color: context.surface,
            borderRadius: AppBorderRadius.radius4,
            border: Border.all(color: context.neutralLowest),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.titleMedium?.copyWith(
                  fontSize: AppDimensions.size14,
                  color: hasBeenSeen ? context.onSurfaceVariant : context.onPrimaryContainer,
                ),
              ),
              AppSpacing.small,
              Text(
                description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: context.bodyMedium?.copyWith(color: hasBeenSeen ? context.neutralHighest : null),
              ),
              AppSpacing.small,
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  timestamp.timeAgoInWords,
                  style: context.bodySmall?.copyWith(color: context.onSurfaceVariant),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
