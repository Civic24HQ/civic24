import 'dart:async';

import 'package:citizen/ui/shared/src/assets.gen.dart';
import 'package:citizen/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:models/models.dart';
import 'package:stacked/stacked.dart';
import 'package:styles/styles.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key, this.stopAnimation = false});
  final bool stopAnimation;

  @override
  State<OnboardingView> createState() => OnboardingViewState();
}

class OnboardingViewState extends State<OnboardingView> {
  late PageController pageController;
  List<Onboarding> selectedBuilder = [
    Onboarding(
      title: l10n.featureOnboardingVoiceReport,
      subtitle: l10n.featureOnboardingVoiceReportDesc,
      illustration: Assets.svg.onboardingOne.svg(),
    ),
    Onboarding(
      title: l10n.featureOnboardingConnectVoice,
      subtitle: l10n.featureOnboardingConnectVoiceDesc,
      illustration: Assets.svg.onboardingTwo.svg(),
    ),
    Onboarding(
      title: l10n.featureOnboardingVoiceCount,
      subtitle: l10n.featureOnboardingVoiceCountDesc,
      illustration: Assets.svg.onboardingThree.svg(),
    ),
  ];

  int _currentIndex = 0;
  Timer? _animationTimer;
  final int _pageAnimeSecs = 1200;
  final int timerSeconds = 4;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    restartTimer(0);
  }

  Future<void> changePage() async {
    if (!mounted) return; // prevent running after dispose

    if (_currentIndex < selectedBuilder.length - 1) {
      if (mounted) {
        setState(() => _currentIndex++);
      }
      await pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: _pageAnimeSecs),
        curve: Curves.easeInOut,
      );
    } else {
      if (mounted) {
        setState(() => _currentIndex = 0);
      }
      await pageController.animateToPage(
        0,
        duration: Duration(milliseconds: _pageAnimeSecs),
        curve: Curves.easeInOut,
      );
    }

    if (mounted) {
      restartTimer(_currentIndex);
    }
  }

  void restartTimer(int index) {
    if (widget.stopAnimation) return;
    _animationTimer?.cancel();
    _animationTimer = Timer(Duration(seconds: timerSeconds), () {
      if (mounted) {
        changePage();
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    _animationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: OnboardingViewModel.new,
      builder: (context, viewModel, child) {
        return Material(
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                AppSpacing.large,
                IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.png.iosDark.image(
                        width: AppDimensions.size56,
                        height: AppDimensions.size56,
                      ),
                      Assets.png.civic24Logo2.image(
                        color: context.onSurface,
                        width: AppDimensions.size150,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.40,
                    child: PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: restartTimer,
                      children: selectedBuilder
                          .map((builder) => _OnboardingItem(builder: builder))
                          .toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: AppEdgeInsets.adaptiveHorizontalPadding(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppSpacing.xLarge,
                        ExpandingDotsIndicator(
                          currentIndex: _currentIndex,
                          count: selectedBuilder.length,
                          onDotClicked: restartTimer,
                        ),
                        AppSpacing.large,
                        PrimaryButton(
                          title: 'Proceed',
                          onTap: viewModel.handleLogin,
                        ),
                        AppSpacing.large,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OnboardingItem extends StatefulWidget {
  const _OnboardingItem({required this.builder});
  final Onboarding builder;

  @override
  State<_OnboardingItem> createState() => _OnboardingItemState();
}

class _OnboardingItemState extends State<_OnboardingItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ScaleTransition(
            scale: Tween(begin: 0.8, end: 1.01).animate(
              CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
            ),
            child: widget.builder.illustration,
          ),
        ),
        FractionallySizedBox(
          widthFactor: 0.9,
          child: Text(
            widget.builder.title,
            style: context.headlineLarge,
            textAlign: TextAlign.center,
          ),
        ),
        AppSpacing.standard,
        FractionallySizedBox(
          widthFactor: 0.9,
          child: Text(
            widget.builder.subtitle,
            textAlign: TextAlign.center,
            style: context.bodyLarge?.copyWith(color: context.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}
