import 'dart:math';
import 'package:citizen/ui/shared/src/assets.gen.dart';
import 'package:citizen/ui/views/startup/startup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';
import 'package:styles/styles.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({super.key});

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      backgroundColor: context.primaryFixedDim,
      body: Stack(
        children: [
          AnimatedPositioned(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 2000),
            left: viewModel.isAnimate ? 0 : -width,
            top: AppDimensions.size16,
            child: Assets.svg.leftSide.svg(),
          ),
          Positioned(
            right: AppDimensions.size40,
            top: AppDimensions.size120,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1000),
              opacity: viewModel.isAnimate ? 1 : 0,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: viewModel.angle),
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
                onEnd: viewModel.animateLight,
                builder: (context, value, child) {
                  final dx = AppDimensions.size12 * cos(value);
                  final dy = AppDimensions.size12 * sin(value);
                  return Transform.translate(
                    offset: Offset(dx, -dy),
                    child: child,
                  );
                },
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Assets.svg.light.svg(
                    colorFilter: ColorFilter.mode(
                      context.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: (width / 2) - (AppDimensions.size150 / 2),
            top: viewModel.isAnimate
                ? (height / 2) - (AppDimensions.size200 / 2)
                : -height,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 5000),
              scale: viewModel.isAnimate ? 1.0 : 0.0,
              child: Assets.png.iosDark.image(
                width: AppDimensions.size150,
                height: AppDimensions.size150,
              ),
            ),
          ),
          Positioned(
            left: (width / 2) - (AppDimensions.size320 / 2),
            top: viewModel.isAnimate
                ? (height / 2) -
                      (AppDimensions.size200 / 2) +
                      AppDimensions.size24
                : -height,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 5000),
              scale: viewModel.isAnimate ? 1.0 : 0.0,
              child: Assets.png.civic24Logo2.image(
                color: context.onSurface,
                width: AppDimensions.size320,
                height: AppDimensions.size320,
              ),
            ),
          ),
          Positioned(
            left: AppDimensions.size32,
            bottom: AppDimensions.size150,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1000),
              opacity: viewModel.isAnimate ? 1 : 0,
              child: AnimatedRotation(
                alignment: Alignment.topCenter,
                turns: viewModel.turns,
                duration: const Duration(seconds: 2),
                onEnd: viewModel.rotate,
                child: Assets.svg.outlineCircle.svg(
                  colorFilter: ColorFilter.mode(
                    context.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 2500),
            right: viewModel.isAnimate ? 0 : -width,
            bottom: AppDimensions.size32,
            child: Assets.svg.rightSide.svg(),
          ),
        ],
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
