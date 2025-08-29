import 'package:citizen/ui/bottom_sheets/comment/comment_sheet_model.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:models/models.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

class CommentSheet extends StackedView<CommentSheetModel> {
  const CommentSheet({
    required this.completer,
    required this.request,
    super.key,
  });

  final SheetRequest<dynamic> request;
  final Function(SheetResponse<dynamic>) completer;

  @override
  Widget builder(
    BuildContext context,
    CommentSheetModel viewModel,
    Widget? child,
  ) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      constraints: BoxConstraints(maxHeight: deviceHeight * 0.7),
      padding: AppEdgeInsets.padding16,
      decoration: BoxDecoration(
        color: context.surfaceVariant,
        borderRadius: AppBorderRadius.topRadius16,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacing.medium,
            Center(
              child: Container(
                width: 64,
                height: 5,
                decoration: BoxDecoration(
                  color: context.neutralLow,
                  borderRadius: AppBorderRadius.radius12,
                ),
              ),
            ),
            AppSpacing.normal,
            Center(
              child: Text(
                l10n.generalComment,
                style: context.headlineSmall?.copyWith(
                  fontSize: AppDimensions.size16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            AppSpacing.normal,
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: AppDimensions.size12,
                    leading: SizedBox(
                      width: AppDimensions.size40,
                      height: AppDimensions.size40,
                      child: ClipRRect(
                        borderRadius: AppBorderRadius.radius12,
                        child: AppCachedImage(
                          imageUrl: viewModel.comments[index].userImageUrl,
                        ),
                      ),
                    ),
                    title: Text(
                      viewModel.comments[index].fullName,
                      style: context.bodyLarge?.copyWith(
                        fontSize: AppDimensions.size14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      viewModel.comments[index].comment,
                      style: context.bodyLarge?.copyWith(
                        fontSize: AppDimensions.size14,
                      ),
                    ),
                    trailing: Text(
                      viewModel.comments[index].createdAt.timeAgoInWords,
                      style: context.bodyLarge?.copyWith(
                        color: context.neutralHigh,
                        fontSize: AppDimensions.size12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                  );
                },
              ),
            ),
            AppSpacing.normal,
            AppTextField(
              hintText: l10n.generalAddComment,
              filled: true,
              controller: TextEditingController(),
              fillColor: context.surface,
              enabledBorder: context.surface,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send,
                  size: AppDimensions.size24,
                  color: context.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  CommentSheetModel viewModelBuilder(BuildContext context) =>
      CommentSheetModel(request.data as List<CommentData>? ?? []);
}
