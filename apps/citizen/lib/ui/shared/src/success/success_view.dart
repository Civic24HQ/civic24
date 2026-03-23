import 'package:citizen/ui/shared/src/success/success_viewmodel.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:styles/styles.dart';

class SuccessView extends StackedView<SuccessViewModel> {
  const SuccessView({
    required this.onProceed,
    required this.iconPath,
    required this.title,
    required this.body,
    required this.buttonLabel,
    super.key,
  });

  final VoidCallback onProceed;
  final String iconPath;
  final String title;
  final String body;
  final String buttonLabel;

  @override
  Widget builder(
    BuildContext context,
    SuccessViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: AppEdgeInsets.adaptiveHorizontalPadding(context),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppSpacing.xxxLarge,
                          AppSpacing.xxxLarge,
                          Lottie.asset(iconPath, height: AppDimensions.size240),
                          Text(
                            title,
                            style: context.headlineSmall?.copyWith(
                              color: context.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          AppSpacing.standard,

                          FractionallySizedBox(
                            widthFactor: 0.85,
                            child: Text(
                              body,
                              style: context.titleMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: context.onSurfaceVariant,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.large,
                      const Spacer(),
                      PrimaryButton(title: buttonLabel, onTap: onProceed),
                      AppSpacing.large,
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  SuccessViewModel viewModelBuilder(BuildContext context) => SuccessViewModel();
}
