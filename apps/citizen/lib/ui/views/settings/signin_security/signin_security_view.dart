import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'signin_security_viewmodel.dart';

class SigninSecurityView extends StackedView<SigninSecurityViewModel> {
  const SigninSecurityView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SigninSecurityViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("SigninSecurityView")),
      ),
    );
  }

  @override
  SigninSecurityViewModel viewModelBuilder(BuildContext context) =>
      SigninSecurityViewModel();
}
