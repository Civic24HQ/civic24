import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class UploadMediaDialog extends StatelessWidget {
  const UploadMediaDialog({
    required this.request,
    required this.completer,
    super.key,
  });
  final DialogRequest<dynamic> request;
  final Function(DialogResponse<dynamic>) completer;

  @override
  Widget build(BuildContext context) {
    return MediaSourceDialog(
      onAssetSourceTapped: (source) async {
        completer(DialogResponse(confirmed: true, data: source));
      },
    );
  }
}
