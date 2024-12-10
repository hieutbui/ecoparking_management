import 'dart:async';
import 'package:dartz/dartz.dart' hide State;
import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/services/profile_service.dart';
import 'package:ecoparking_management/domain/state/account/get_user_parking_state.dart';
import 'package:ecoparking_management/domain/state/account/get_user_profile_state.dart';
import 'package:ecoparking_management/domain/state/account/update_user_profile_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/usecase/account/get_user_parking_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/get_user_profile_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/sign_out_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/update_user_profile_interactor.dart';
import 'package:ecoparking_management/pages/profile/profile_ui_state.dart';
import 'package:ecoparking_management/pages/profile/profile_view.dart';
import 'package:ecoparking_management/utils/dialog_utils.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfileController createState() => ProfileController();
}

class ProfileController extends State<Profile> with ControllerLoggy {
  final ProfileService _profileService = getIt.get<ProfileService>();
  final GetUserParkingInteractor _getUserParkingInteractor =
      getIt.get<GetUserParkingInteractor>();
  final GetUserProfileInteractor _getUserProfileInteractor =
      getIt.get<GetUserProfileInteractor>();
  final UpdateUserProfileInteractor _updateUserProfileInteractor =
      getIt.get<UpdateUserProfileInteractor>();
  final SignOutInteractor _signOutInteractor = getIt.get<SignOutInteractor>();

  final ValueNotifier<ProfileUIState> profileUIStateNotifier =
      ValueNotifier(const ProfileUIInitial());
  final ValueNotifier<GetUserParkingState> getUserParkingStateNotifier =
      ValueNotifier(const GetUserParkingInitial());
  final ValueNotifier<GetUserProfileState> getUserProfileStateNotifier =
      ValueNotifier(const GetUserProfileInitial());
  final ValueNotifier<UpdateUserProfileState> updateUserProfileStateNotifier =
      ValueNotifier(const UpdateUserProfileInitial());

  final ValueNotifier<Gender?> genderNotifier = ValueNotifier(null);
  final ValueNotifier<DateTime?> dateNotifier = ValueNotifier<DateTime?>(null);
  final ValueNotifier<bool> isEditing = ValueNotifier(false);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  StreamSubscription<Either<Failure, Success>>? _getUserParkingSubscription;
  StreamSubscription<Either<Failure, Success>>? _getUserProfileSubscription;
  StreamSubscription<Either<Failure, Success>>? _updateUserProfileSubscription;

  @override
  void initState() {
    super.initState();
    _checkProfileIsEmpty();
    _initializeTextControllers();
    getUserParking();
  }

  @override
  void dispose() {
    _disposeTextControllers();
    _disposeNotifiers();
    _cancelSubscriptions();
    super.dispose();
  }

  void _initializeTextControllers() {
    final profile = _profileService.userProfile;

    if (profile != null) {
      emailController.text = profile.email;
      nameController.text = profile.fullName ?? '';
      phoneController.text = profile.phone ?? '';
    }
  }

  void _disposeNotifiers() {
    profileUIStateNotifier.dispose();
    getUserParkingStateNotifier.dispose();
    isEditing.dispose();
    genderNotifier.dispose();
    dateNotifier.dispose();
    getUserProfileStateNotifier.dispose();
  }

  void _cancelSubscriptions() {
    _getUserParkingSubscription?.cancel();
    _getUserProfileSubscription?.cancel();
    _updateUserProfileSubscription?.cancel();
    _getUserParkingSubscription = null;
    _getUserProfileSubscription = null;
    _updateUserProfileSubscription = null;
  }

  void _disposeTextControllers() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  Future<void> _checkProfileIsEmpty() async {
    final profile = _profileService.userProfile;

    if (profile == null || !_profileService.isAuthenticated) {
      profileUIStateNotifier.value = const ProfileUIEmptyProfile();
      await DialogUtils.showRequiredLogin(context);
      navigateToLogin();

      return;
    } else {
      profileUIStateNotifier.value = ProfileUIAuthenticated(
        userProfile: profile,
      );
    }
  }

  void navigateToLogin() {
    NavigationUtils.navigateTo(
      context: context,
      path: AppPaths.login,
    );
  }

  void saveProfile() {
    loggy.info('Save profile');
    final UserProfile profile = UserProfile(
      id: _profileService.userProfile!.id,
      email: emailController.text,
      accountType: _profileService.userProfile!.accountType,
      fullName: nameController.text,
      phone: phoneController.text,
      dob: dateNotifier.value,
      gender: genderNotifier.value,
    );

    _updateUserProfileSubscription = _updateUserProfileInteractor
        .execute(
          userProfile: profile,
        )
        .listen(
          (result) => result.fold(
            _handleUpdateUserProfileFailure,
            _handleUpdateUserProfileSuccess,
          ),
        );
  }

  void editProfile() {
    isEditing.value = true;
  }

  void cancelEditProfile() {
    isEditing.value = false;
    _initializeTextControllers();
  }

  void onPhoneChanged(PhoneNumber? phoneNumber) {
    loggy.info('Phone number changed: $phoneNumber');
    phoneController.text = phoneNumber?.international ?? '';
  }

  void onSelectGender(Gender gender) {
    loggy.info('Selected gender: $gender');
    genderNotifier.value = gender;
  }

  void onDateSelected(DateTime? date) {
    loggy.info('Selected date: $date');
    dateNotifier.value = date;
  }

  void getUserParking() async {
    await _checkProfileIsEmpty();

    _getUserParkingSubscription = _getUserParkingInteractor
        .execute(
          userId: _profileService.user!.id,
        )
        .listen(
          (result) => result.fold(
            _handleGetUserParkingFailure,
            _handleGetUserParkingSuccess,
          ),
        );
  }

  void _getUserProfile({required String userId}) {
    _getUserProfileSubscription = _getUserProfileInteractor
        .execute(
          userId: userId,
        )
        .listen(
          (result) => result.fold(
            _handleGetUserProfileFailure,
            _handleGetUserProfileSuccess,
          ),
        );
  }

  void onSignOut() {
    _signOutInteractor.execute().listen(
          (result) => result.fold(
            _handleSignOutFailure,
            _handleSignOutSuccess,
          ),
        );
  }

  void _handleGetUserParkingFailure(Failure failure) {
    loggy.error('Get user parking failure: $failure');
    if (failure is GetUserParkingEmpty) {
      getUserParkingStateNotifier.value = const GetUserParkingEmpty();
    } else if (failure is GetUserParkingFailure) {
      getUserParkingStateNotifier.value = failure;
    } else {
      getUserParkingStateNotifier.value =
          GetUserParkingFailure(exception: failure);
    }
  }

  void _handleGetUserParkingSuccess(Success success) {
    loggy.info('Get user parking success: $success');
    if (success is GetUserParkingSuccess) {
      getUserParkingStateNotifier.value = success;
    } else if (success is GetUserParkingLoading) {
      getUserParkingStateNotifier.value = success;
    }
  }

  void _handleGetUserProfileFailure(Failure failure) {
    loggy.error('Get user profile failure: $failure');
    if (failure is GetUserProfileEmpty) {
      getUserProfileStateNotifier.value = const GetUserProfileEmpty();
    } else if (failure is GetUserProfileFailure) {
      getUserProfileStateNotifier.value = failure;
    } else {
      getUserProfileStateNotifier.value =
          GetUserProfileFailure(exception: failure);
    }
  }

  void _handleGetUserProfileSuccess(Success success) {
    loggy.info('Get user profile success: $success');
    if (success is GetUserProfileSuccess) {
      getUserProfileStateNotifier.value = success;
      _profileService.setUserProfile(success.response);
      isEditing.value = false;
    } else if (success is GetUserProfileLoading) {
      getUserProfileStateNotifier.value = success;
    }
  }

  void _handleUpdateUserProfileFailure(Failure failure) {
    loggy.error('Update user profile failure: $failure');
    if (failure is UpdateUserProfileEmpty) {
      updateUserProfileStateNotifier.value = const UpdateUserProfileEmpty();
    } else if (failure is UpdateUserProfileFailure) {
      updateUserProfileStateNotifier.value = failure;
    } else {
      updateUserProfileStateNotifier.value =
          UpdateUserProfileFailure(exception: failure);
    }
  }

  void _handleUpdateUserProfileSuccess(Success success) {
    loggy.info('Update user profile success: $success');
    if (success is UpdateUserProfileSuccess) {
      updateUserProfileStateNotifier.value = success;
      _getUserProfile(userId: success.userProfile.id);
    } else if (success is UpdateUserProfileLoading) {
      updateUserProfileStateNotifier.value = success;
    }
  }

  void _handleSignOutFailure(Failure failure) {
    loggy.error('Sign out failure: $failure');
    _handleSignOutCommon();
  }

  void _handleSignOutSuccess(Success success) {
    loggy.info('Sign out success: $success');
    _handleSignOutCommon();
  }

  void _handleSignOutCommon() {
    _profileService.clear();
    navigateToLogin();
  }

  @override
  Widget build(BuildContext context) => ProfileView(controller: this);
}
