import 'package:citizen/ui/bottom_sheets/delete_verification/delete_verification_sheet_model.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:styles/styles.dart';
import 'package:utils/utils.dart';

class DeleteVerificationSheet
    extends StackedView<DeleteVerificationSheetModel> {
  const DeleteVerificationSheet({
    required this.completer,
    required this.request,
    super.key,
  });
  final Function(SheetResponse<dynamic> response)? completer;
  final SheetRequest<dynamic> request;

  @override
  Widget builder(
    BuildContext context,
    DeleteVerificationSheetModel viewModel,
    Widget? child,
  ) {
    if (viewModel.isSocialAuth) {
      return Container(
        decoration: BoxDecoration(
          color: context.surfaceVariant,
          borderRadius: AppBorderRadius.topRadius16,
        ),
        padding: AppEdgeInsets.padding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
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
            Text(
              l10n.featureDialogDeleteVerificationAuthContinue,
              style: context.titleMedium,
            ),
            AppSpacing.small,
            Text(
              l10n.featureDialogDeleteVerificationAuthHint,
              style: context.bodyMedium?.copyWith(
                color: context.neutralHighest,
              ),
            ),
            AppSpacing.large,
            PrimaryButton(
              title:
                  'Re-authenticate with ${viewModel.user.provider.toTitleCase}',
              onTap: viewModel.reauthenticateWithSocialAuth,
            ),
            AppSpacing.medium,
            Align(
              child: TextButton(
                onPressed: () => completer?.call(SheetResponse()),
                child: Text(
                  l10n.generalCancel,
                  style: context.bodyMedium?.copyWith(
                    color: context.neutralHighest,
                  ),
                ),
              ),
            ),
            AppSpacing.medium,
          ],
        ),
      );
    } else {
      return _DeletePasswordVerification(
        password: viewModel.password,
        passwordError: viewModel.passwordError,
        onUpdatePassword: viewModel.updatePassword,
        onForgetPassword: viewModel.handleForgetPassword,
        onVerified: viewModel.reauthenticateWithEmail,
        onCancelled: () => completer?.call(SheetResponse()),
      );
    }
  }

  @override
  DeleteVerificationSheetModel viewModelBuilder(BuildContext context) =>
      DeleteVerificationSheetModel();
}

class _DeletePasswordVerification extends StatefulWidget {
  const _DeletePasswordVerification({
    required this.password,
    required this.passwordError,
    required this.onUpdatePassword,
    required this.onForgetPassword,
    required this.onVerified,
    required this.onCancelled,
  });
  final String password;
  final String? passwordError;
  final ValueChanged<String?>? onUpdatePassword;
  final VoidCallback onForgetPassword;
  final VoidCallback onVerified;
  final VoidCallback onCancelled;

  @override
  State<_DeletePasswordVerification> createState() =>
      _DeletePasswordVerificationState();
}

class _DeletePasswordVerificationState
    extends State<_DeletePasswordVerification> {
  bool _showPassword = false;

  void _togglePassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(
          color: context.surfaceVariant,
          borderRadius: AppBorderRadius.topRadius16,
        ),
        padding: AppEdgeInsets.padding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
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
            Align(
              child: Text(
                l10n.featureDialogDeleteVerificationVerify,
                style: context.titleMedium,
              ),
            ),
            AppSpacing.medium,
            Text(
              l10n.featureDialogDeleteVerificationSecurity,
              style: context.bodyMedium?.copyWith(
                color: context.neutralHighest,
              ),
            ),
            AppSpacing.large,
            AppTextField(
              key: const ValueKey('password'),
              label: l10n.generalPassword,
              hintText: l10n.generalEnterPassword,
              prefixIcon: const Icon(SolarIconsOutline.lockPassword),
              obscureText: !_showPassword,
              errorText: widget.passwordError,
              suffixIcon: widget.password.isNotEmpty
                  ? IconButton(
                      onPressed: _togglePassword,
                      iconSize: AppDimensions.size16,
                      splashRadius: AppDimensions.size24,
                      icon: Icon(
                        _showPassword
                            ? SolarIconsOutline.eye
                            : SolarIconsOutline.eyeClosed,
                      ),
                    )
                  : null,
              onChanged: widget.onUpdatePassword,
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                widget.onVerified.call();
              },
              keyboardType: _showPassword
                  ? TextInputType.visiblePassword
                  : TextInputType.text,
              autofillHints: const [AutofillHints.password],
              textInputAction: TextInputAction.done,
            ),
            AppSpacing.medium,
            if (widget.passwordError != null &&
                widget.passwordError!.isNotEmpty)
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: widget.onForgetPassword,
                  child: Text(
                    l10n.generalForgotPassword,
                    style: context.bodyMedium?.copyWith(color: context.primary),
                  ),
                ),
              ),
            AppSpacing.xxLarge,
            PrimaryButton(
              title: l10n.featureDeleteVerificationContinue,
              onTap: widget.onVerified,
            ),
            AppSpacing.medium,
            Align(
              child: TextButton(
                onPressed: widget.onCancelled,
                child: Text(
                  l10n.generalCancel,
                  style: context.bodyMedium?.copyWith(
                    color: context.neutralHighest,
                  ),
                ),
              ),
            ),
            AppSpacing.medium,
          ],
        ),
      ),
    );
  }
}
