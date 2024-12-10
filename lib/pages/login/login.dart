import 'dart:async';
import 'package:dartz/dartz.dart' hide State;
import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/services/profile_service.dart';
import 'package:ecoparking_management/domain/state/account/get_user_profile_state.dart';
import 'package:ecoparking_management/domain/state/account/sign_in_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/usecase/account/get_user_profile_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/sign_in_interactor.dart';
import 'package:ecoparking_management/pages/login/login_view.dart';
import 'package:ecoparking_management/utils/dialog_utils.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginController();
}

class LoginController extends State<Login> with ControllerLoggy {
  final SignInInteractor _signInInteractor = getIt.get<SignInInteractor>();
  final GetUserProfileInteractor _getUserProfileInteractor =
      getIt.get<GetUserProfileInteractor>();

  final ProfileService _profileService = getIt.get<ProfileService>();

  final ValueNotifier<SignInState> signInNotifier =
      ValueNotifier(const SignInInitial());
  final ValueNotifier<GetUserProfileState> getUserProfileNotifier =
      ValueNotifier(const GetUserProfileInitial());

  final ValueNotifier<bool> isObscurePassword = ValueNotifier(true);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  StreamSubscription<Either<Failure, Success>>? _signInSubscription;
  StreamSubscription<Either<Failure, Success>>? _getUserProfileSubscription;

  User? get user =>
      _profileService.user ?? Supabase.instance.client.auth.currentUser;
  Session? get session =>
      _profileService.session ?? Supabase.instance.client.auth.currentSession;
  UserProfile? get userProfile => _profileService.userProfile;

  @override
  void initState() {
    super.initState();
    _checkSignedIn();
  }

  @override
  void dispose() {
    _disposeTextControllers();
    _disposeNotifiers();
    _cancelSubscriptions();
    super.dispose();
  }

  void _checkSignedIn() {
    if (user != null && session != null) {
      _profileService.setSession(session!);
      _profileService.setUser(user!);
      if (userProfile != null) {
        _navigateToLiveOverview();
      } else {
        _getUserProfile(userId: user!.id);
      }
    }
  }

  void _disposeTextControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  void _disposeNotifiers() {
    signInNotifier.dispose();
    getUserProfileNotifier.dispose();
    isObscurePassword.dispose();
  }

  void _cancelSubscriptions() {
    _signInSubscription?.cancel();
    _getUserProfileSubscription?.cancel();
    _signInSubscription = null;
    _getUserProfileSubscription = null;
  }

  void login() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      await DialogUtils.showFillAllLoginFields(context);
      return;
    }

    loggy.info('Login');
    _signInSubscription = _signInInteractor
        .execute(
          email: email,
          password: password,
        )
        .listen(
          (result) => result.fold(
            _handleLoginFailure,
            _handleLoginSuccess,
          ),
        );
  }

  void _getUserProfile({required String userId}) {
    _getUserProfileSubscription =
        _getUserProfileInteractor.execute(userId: userId).listen(
              (result) => result.fold(
                _handleGetUserProfileFailure,
                _handleGetUserProfileSuccess,
              ),
            );
  }

  void toggleObscurePassword() {
    isObscurePassword.value = !isObscurePassword.value;
  }

  void _navigateToLiveOverview() {
    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.liveOverview,
    );
  }

  void onEmailSubmitted(String email) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void onPasswordSubmitted(String password) {
    login();
  }

  void _handleLoginFailure(Failure failure) async {
    loggy.error('Login failure');
    if (failure is SignInAuthFailure) {
      signInNotifier.value = failure;
    } else if (failure is SignInEmailEmpty) {
      signInNotifier.value = failure;
    } else if (failure is SignInFailure) {
      signInNotifier.value = failure;
    } else {
      signInNotifier.value = SignInFailure(exception: failure);
    }

    await DialogUtils.showLoginError(context);
  }

  void _handleLoginSuccess(Success success) async {
    loggy.info('Login success');
    if (success is SignInSuccess) {
      signInNotifier.value = success;
      final user = success.response.user;

      if (user == null) {
        await DialogUtils.showSomethingWentWrong(context);
        return;
      }

      final session = success.response.session;
      if (session != null) {
        _profileService.setSession(session);
      }

      _profileService.setUser(user);
      _getUserProfile(userId: user.id);
    } else if (success is SignInLoading) {
      signInNotifier.value = success;
    }
  }

  void _handleGetUserProfileFailure(Failure failure) {
    loggy.error('Get user profile failure $failure');
    if (failure is GetUserProfileEmpty) {
      getUserProfileNotifier.value = failure;
    } else if (failure is GetUserProfileFailure) {
      getUserProfileNotifier.value = failure;
    } else {
      getUserProfileNotifier.value = GetUserProfileFailure(exception: failure);
    }
  }

  void _handleGetUserProfileSuccess(Success success) async {
    loggy.info('Get user profile success');
    if (success is GetUserProfileSuccess) {
      getUserProfileNotifier.value = success;

      if (success.response.accountType == AccountType.user) {
        await DialogUtils.showNotAllowedAccount(context);
        return;
      }

      _profileService.setUserProfile(success.response);
      _navigateToLiveOverview();
    } else if (success is GetUserProfileLoading) {
      getUserProfileNotifier.value = success;
    }
  }

  @override
  Widget build(BuildContext context) => LoginView(controller: this);
}
