import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/domain/state/account/sign_in_state.dart';
import 'package:ecoparking_management/pages/login/login.dart';
import 'package:ecoparking_management/pages/login/login_view_styles.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget with ViewLoggy {
  final LoginController controller;

  const LoginView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.login.label,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
            const SizedBox(height: LoginViewStyles.spacing),
            Padding(
              padding: LoginViewStyles.padding,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: LoginViewStyles.spacing),
                  ValueListenableBuilder(
                    valueListenable: controller.signInNotifier,
                    builder: (context, state, child) {
                      return TextField(
                        controller: controller.emailController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          labelStyle: Theme.of(context).textTheme.displaySmall,
                          hintStyle: Theme.of(context).textTheme.headlineSmall,
                        ),
                        enabled: state is! SignInLoading,
                        onSubmitted: controller.onEmailSubmitted,
                      );
                    },
                  ),
                  const SizedBox(height: LoginViewStyles.spacing),
                  ValueListenableBuilder(
                    valueListenable: controller.signInNotifier,
                    builder: (context, state, child) {
                      return ValueListenableBuilder(
                        valueListenable: controller.isObscurePassword,
                        builder: (context, isObscure, child) {
                          return TextField(
                            controller: controller.passwordController,
                            textInputAction: TextInputAction.done,
                            obscureText: isObscure,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              labelStyle:
                                  Theme.of(context).textTheme.displaySmall,
                              hintStyle:
                                  Theme.of(context).textTheme.headlineSmall,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  controller.isObscurePassword.value =
                                      !isObscure;
                                },
                              ),
                            ),
                            enabled: state is! SignInLoading,
                            onSubmitted: controller.onPasswordSubmitted,
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: LoginViewStyles.spacing),
                  ValueListenableBuilder(
                    valueListenable: controller.signInNotifier,
                    builder: (context, state, child) {
                      return ElevatedButton(
                        onPressed:
                            state is! SignInLoading ? controller.login : null,
                        child: state is! SignInLoading
                            ? Text(
                                'Login',
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              )
                            : const CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
