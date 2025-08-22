import 'package:flutter/material.dart';
import 'package:citizen/ui/common/app_colors.dart';
import 'package:citizen/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'comment_sheet_model.dart';

class CommentSheet extends StackedView<CommentSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const CommentSheet({Key? key, required this.completer, required this.request})
    : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CommentSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title ?? 'Hello Stacked Sheet!!',
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          if (request.description != null) ...[
            verticalSpaceTiny,
            Text(
              request.description!,
              style: const TextStyle(fontSize: 14, color: kcMediumGrey),
              maxLines: 3,
              softWrap: true,
            ),
          ],
          verticalSpaceLarge,
        ],
      ),
    );
  }

  @override
  CommentSheetModel viewModelBuilder(BuildContext context) =>
      CommentSheetModel();
}
