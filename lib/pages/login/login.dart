import 'dart:async';
import 'package:dartz/dartz.dart' hide State;
import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/services/profile_service.dart';
import 'package:ecoparking_management/domain/state/account/get_employee_info_state.dart';
import 'package:ecoparking_management/domain/state/account/get_owner_info_state.dart';
import 'package:ecoparking_management/domain/state/account/get_user_profile_state.dart';
import 'package:ecoparking_management/domain/state/account/sign_in_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/usecase/account/get_employee_info_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/get_owner_info_interactor.dart';
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
  final GetEmployeeInfoInteractor _getEmployeeInfoInteractor =
      getIt.get<GetEmployeeInfoInteractor>();
  final GetOwnerInfoInteractor _getOwnerInfoInteractor =
      getIt.get<GetOwnerInfoInteractor>();

  final ProfileService _profileService = getIt.get<ProfileService>();

  final ValueNotifier<SignInState> signInNotifier =
      ValueNotifier(const SignInInitial());
  final ValueNotifier<GetUserProfileState> getUserProfileNotifier =
      ValueNotifier(const GetUserProfileInitial());
  final ValueNotifier<GetEmployeeInfoState> getEmployeeInfoStateNotifier =
      ValueNotifier(const GetEmployeeInfoInitial());
  final ValueNotifier<GetOwnerInfoState> getOwnerInfoStateNotifier =
      ValueNotifier(const GetOwnerInfoInitial());

  final ValueNotifier<bool> isObscurePassword = ValueNotifier(true);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  StreamSubscription<Either<Failure, Success>>? _signInSubscription;
  StreamSubscription<Either<Failure, Success>>? _getUserProfileSubscription;
  StreamSubscription<Either<Failure, Success>>? _getEmployeeInfoSubscription;
  StreamSubscription<Either<Failure, Success>>? _getOwnerInfoSubscription;

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
    _clearTextControllers();
    _disposeTextControllers();
    _disposeNotifiers();
    _cancelSubscriptions();
    _disposeFocusNodes();
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
    getEmployeeInfoStateNotifier.dispose();
    getOwnerInfoStateNotifier.dispose();
  }

  void _cancelSubscriptions() {
    _signInSubscription?.cancel();
    _getUserProfileSubscription?.cancel();
    _getEmployeeInfoSubscription?.cancel();
    _getOwnerInfoSubscription?.cancel();
    _signInSubscription = null;
    _getUserProfileSubscription = null;
    _getEmployeeInfoSubscription = null;
    _getOwnerInfoSubscription = null;
  }

  void _clearTextControllers() {
    emailController.clear();
    passwordController.clear();
  }

  void _disposeFocusNodes() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  void login() async {
    final String email = emailController.text;
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      await DialogUtils.showFillAllLoginFields(context);
      return;
    }

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

  void _getUserPosition({
    required UserProfile profile,
  }) {
    if (profile.accountType == AccountType.employee) {
      _getEmployeeInfo(profileId: profile.id);
    } else if (profile.accountType == AccountType.parkingOwner) {
      _getOwnerInfo(profileId: profile.id);
    }
  }

  void _getEmployeeInfo({required String profileId}) {
    _getEmployeeInfoSubscription = _getEmployeeInfoInteractor
        .execute(
          profileId: profileId,
        )
        .listen(
          (result) => result.fold(
            _handleGetEmployeeInfoFailure,
            _handleGetEmployeeInfoSuccess,
          ),
        );
  }

  void _getOwnerInfo({required String profileId}) {
    _getOwnerInfoSubscription = _getOwnerInfoInteractor
        .execute(
          profileId: profileId,
        )
        .listen(
          (result) => result.fold(
            _handleGetOwnerInfoFailure,
            _handleGetOwnerInfoSuccess,
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
    passwordFocusNode.requestFocus();
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
      _getUserPosition(profile: success.response);
    } else if (success is GetUserProfileLoading) {
      getUserProfileNotifier.value = success;
    }
  }

  void _handleGetEmployeeInfoFailure(Failure failure) {
    loggy.error('Get employee info failure: $failure');
    if (failure is GetEmployeeInfoEmpty) {
      getEmployeeInfoStateNotifier.value = const GetEmployeeInfoEmpty();
    } else if (failure is GetEmployeeInfoFailure) {
      getEmployeeInfoStateNotifier.value = failure;
    } else {
      getEmployeeInfoStateNotifier.value =
          GetEmployeeInfoFailure(exception: failure);
    }
  }

  void _handleGetEmployeeInfoSuccess(Success success) {
    loggy.info('Get employee info success');
    if (success is GetEmployeeInfoSuccess) {
      getEmployeeInfoStateNotifier.value = success;
      _profileService.setParkingEmployee(success.employeeInfo);
      _navigateToLiveOverview();
    } else if (success is GetEmployeeInfoLoading) {
      getEmployeeInfoStateNotifier.value = success;
    }
  }

  void _handleGetOwnerInfoFailure(Failure failure) {
    loggy.error('Get owner info failure: $failure');
    if (failure is GetOwnerInfoEmpty) {
      getOwnerInfoStateNotifier.value = const GetOwnerInfoEmpty();
    } else if (failure is GetOwnerInfoFailure) {
      getOwnerInfoStateNotifier.value = failure;
    } else {
      getOwnerInfoStateNotifier.value = GetOwnerInfoFailure(exception: failure);
    }
  }

  void _handleGetOwnerInfoSuccess(Success success) {
    loggy.info('Get owner info success');
    if (success is GetOwnerInfoSuccess) {
      getOwnerInfoStateNotifier.value = success;
      _profileService.setParkingOwner(success.ownerInfo);
      _navigateToLiveOverview();
    } else if (success is GetOwnerInfoLoading) {
      getOwnerInfoStateNotifier.value = success;
    }
  }

  @override
  Widget build(BuildContext context) => LoginView(controller: this);
}
