import 'package:admin/ui/views/home/home_viewmodel.dart';
import 'package:assets/asset_gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:styles/styles.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Hello, World!!!',
                      style: TextStyle(
                        fontFamily: FontFamily.poppins,
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        color: context.onSurface,
                      ),
                    ),
                  ],
                ),
                Text(
                  'This is the Admin App sample page using Stacked View',
                  style: TextStyle(fontFamily: FontFamily.poppins, fontSize: 20, color: context.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
