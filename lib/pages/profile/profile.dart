import 'dart:async';
import 'package:dartz/dartz.dart' hide State;
import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:ecoparking_management/di/global/get_it_initializer.dart';
import 'package:ecoparking_management/domain/services/profile_service.dart';
import 'package:ecoparking_management/domain/state/account/get_employee_info_state.dart';
import 'package:ecoparking_management/domain/state/account/get_owner_info_state.dart';
import 'package:ecoparking_management/domain/state/account/get_user_profile_state.dart';
import 'package:ecoparking_management/domain/state/account/update_employee_currency_locale_state.dart';
import 'package:ecoparking_management/domain/state/account/update_owner_currency_locale_state.dart';
import 'package:ecoparking_management/domain/state/account/update_user_profile_state.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:ecoparking_management/domain/state/app_state/success.dart';
import 'package:ecoparking_management/domain/usecase/account/get_employee_info_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/get_owner_info_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/get_user_profile_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/sign_out_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/update_employee_currency_locale_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/update_owner_currency_locale_interactor.dart';
import 'package:ecoparking_management/domain/usecase/account/update_user_profile_interactor.dart';
import 'package:ecoparking_management/pages/profile/profile_ui_state.dart';
import 'package:ecoparking_management/pages/profile/profile_view.dart';
import 'package:ecoparking_management/utils/dialog_utils.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/utils/navigation_utils.dart';
import 'package:ecoparking_management/widgets/dropdown_currency/supported_currencies.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfileController createState() => ProfileController();
}

class ProfileController extends State<Profile> with ControllerLoggy {
  final ProfileService _profileService = getIt.get<ProfileService>();

  final GetUserProfileInteractor _getUserProfileInteractor =
      getIt.get<GetUserProfileInteractor>();
  final UpdateUserProfileInteractor _updateUserProfileInteractor =
      getIt.get<UpdateUserProfileInteractor>();
  final SignOutInteractor _signOutInteractor = getIt.get<SignOutInteractor>();
  final GetEmployeeInfoInteractor _getEmployeeInfoInteractor =
      getIt.get<GetEmployeeInfoInteractor>();
  final GetOwnerInfoInteractor _getOwnerInfoInteractor =
      getIt.get<GetOwnerInfoInteractor>();
  final UpdateEmployeeCurrencyLocaleInteractor
      _updateEmployeeCurrencyLocaleInteractor =
      getIt.get<UpdateEmployeeCurrencyLocaleInteractor>();
  final UpdateOwnerCurrencyLocaleInteractor
      _updateOwnerCurrencyLocaleInteractor =
      getIt.get<UpdateOwnerCurrencyLocaleInteractor>();

  final ValueNotifier<ProfileUIState> profileUIStateNotifier =
      ValueNotifier(const ProfileUIInitial());
  final ValueNotifier<GetUserProfileState> getUserProfileStateNotifier =
      ValueNotifier(const GetUserProfileInitial());
  final ValueNotifier<UpdateUserProfileState> updateUserProfileStateNotifier =
      ValueNotifier(const UpdateUserProfileInitial());
  final ValueNotifier<GetEmployeeInfoState> getEmployeeInfoStateNotifier =
      ValueNotifier(const GetEmployeeInfoInitial());
  final ValueNotifier<GetOwnerInfoState> getOwnerInfoStateNotifier =
      ValueNotifier(const GetOwnerInfoInitial());
  final ValueNotifier<UpdateEmployeeCurrencyLocaleState>
      updateEmployeeCurrencyLocaleStateNotifier =
      ValueNotifier(const UpdateEmployeeCurrencyLocaleInitial());
  final ValueNotifier<UpdateOwnerCurrencyLocaleState>
      updateOwnerCurrencyLocaleStateNotifier =
      ValueNotifier(const UpdateOwnerCurrencyLocaleInitial());

  final ValueNotifier<Gender?> genderNotifier = ValueNotifier(null);
  final ValueNotifier<DateTime?> dateNotifier = ValueNotifier<DateTime?>(null);
  final ValueNotifier<bool> isEditing = ValueNotifier(false);
  final ValueNotifier<SupportedCurrency> currencyNotifier =
      ValueNotifier(supportedCurrencies.first);
  final ValueNotifier<TimeOfDay?> workingStartTimeNotifier =
      ValueNotifier<TimeOfDay?>(null);
  final ValueNotifier<TimeOfDay?> workingEndTimeNotifier =
      ValueNotifier<TimeOfDay?>(null);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  StreamSubscription<Either<Failure, Success>>? _getUserProfileSubscription;
  StreamSubscription<Either<Failure, Success>>? _updateUserProfileSubscription;
  StreamSubscription<Either<Failure, Success>>? _getEmployeeInfoSubscription;
  StreamSubscription<Either<Failure, Success>>? _getOwnerInfoSubscription;
  StreamSubscription<Either<Failure, Success>>?
      _updateEmployeeCurrencyLocaleSubscription;
  StreamSubscription<Either<Failure, Success>>?
      _updateOwnerCurrencyLocaleSubscription;

  @override
  void initState() {
    super.initState();
    _checkProfileIsEmpty();
    _getUserPosition();
    _initializeTextControllers();
    _initializeCurrencyLocale();
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

  void _initializeCurrencyLocale() {
    final profile = _profileService.userProfile;

    if (profile == null) return;

    if (profile.accountType == AccountType.employee) {
      final employee = _profileService.parkingEmployee;

      if (employee != null) {
        currencyNotifier.value = supportedCurrencies.firstWhere(
          (currency) => currency.locale == employee.currencyLocale,
          orElse: () => supportedCurrencies.first,
        );
      }
    } else if (profile.accountType == AccountType.parkingOwner) {
      final owner = _profileService.parkingOwner;

      if (owner != null) {
        currencyNotifier.value = supportedCurrencies.firstWhere(
          (currency) => currency.locale == owner.currencyLocale,
          orElse: () => supportedCurrencies.first,
        );
      }
    }
  }

  void _getUserPosition() {
    final profileUIStateValue = profileUIStateNotifier.value;

    if (profileUIStateValue is ProfileUIAuthenticated) {
      final profile = profileUIStateValue.userProfile;

      if (profile.accountType == AccountType.employee) {
        _getEmployeeInfo(profileId: profile.id);
      } else if (profile.accountType == AccountType.parkingOwner) {
        _getOwnerInfo(profileId: profile.id);
      }
    }
  }

  void _disposeNotifiers() {
    profileUIStateNotifier.dispose();
    isEditing.dispose();
    genderNotifier.dispose();
    dateNotifier.dispose();
    getUserProfileStateNotifier.dispose();
    updateUserProfileStateNotifier.dispose();
    currencyNotifier.dispose();
    workingStartTimeNotifier.dispose();
    workingEndTimeNotifier.dispose();
    getEmployeeInfoStateNotifier.dispose();
    getOwnerInfoStateNotifier.dispose();
    updateEmployeeCurrencyLocaleStateNotifier.dispose();
    updateOwnerCurrencyLocaleStateNotifier.dispose();
  }

  void _cancelSubscriptions() {
    _getUserProfileSubscription?.cancel();
    _updateUserProfileSubscription?.cancel();
    _getEmployeeInfoSubscription?.cancel();
    _getOwnerInfoSubscription?.cancel();
    _updateEmployeeCurrencyLocaleSubscription?.cancel();
    _updateOwnerCurrencyLocaleSubscription?.cancel();
    _getUserProfileSubscription = null;
    _updateUserProfileSubscription = null;
    _getEmployeeInfoSubscription = null;
    _getOwnerInfoSubscription = null;
    _updateEmployeeCurrencyLocaleSubscription = null;
    _updateOwnerCurrencyLocaleSubscription = null;
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
    if (mounted) {
      NavigationUtils.navigateTo(
        context: context,
        path: AppPaths.login,
      );
    }
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

  void onSelectCurrency(SupportedCurrency currency) {
    currencyNotifier.value = currency;

    if (_profileService.userProfile?.accountType == AccountType.employee) {
      _saveCurrencyForEmployee();
    } else if (_profileService.userProfile?.accountType ==
        AccountType.parkingOwner) {
      _saveCurrencyForOwner();
    }
  }

  void _saveCurrencyForEmployee() {
    final employId = _profileService.parkingEmployee?.id;

    if (employId == null || employId.isEmpty) return;

    _updateEmployeeCurrencyLocaleSubscription =
        _updateEmployeeCurrencyLocaleInteractor
            .execute(
              employeeId: employId,
              currencyLocale: currencyNotifier.value.locale,
            )
            .listen(
              (result) => result.fold(
                _handleUpdateEmployeeCurrencyLocaleFailure,
                _handleUpdateEmployeeCurrencyLocaleSuccess,
              ),
            );
  }

  void _saveCurrencyForOwner() {
    final ownerId = _profileService.parkingOwner?.id;

    if (ownerId == null || ownerId.isEmpty) return;

    _updateOwnerCurrencyLocaleSubscription =
        _updateOwnerCurrencyLocaleInteractor
            .execute(
              ownerId: ownerId,
              currencyLocale: currencyNotifier.value.locale,
            )
            .listen(
              (result) => result.fold(
                _handleUpdateOwnerCurrencyLocaleFailure,
                _handleUpdateOwnerCurrencyLocaleSuccess,
              ),
            );
  }

  void onWorkingStartTimeSelected(TimeOfDay? time) {
    workingStartTimeNotifier.value = time;
    //TODO: Save working start time
  }

  void onWorkingEndTimeSelected(TimeOfDay? time) {
    workingEndTimeNotifier.value = time;
    //TODO: Save working end time
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
    loggy.info('Get user profile success');
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
    loggy.info('Update user profile success');
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
    loggy.info('Sign out success');
    _handleSignOutCommon();
  }

  void _handleSignOutCommon() {
    _profileService.clear();
    navigateToLogin();
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
      currencyNotifier.value = supportedCurrencies.firstWhere(
        (currency) => currency.locale == success.employeeInfo.currencyLocale,
        orElse: () => supportedCurrencies.first,
      );
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
      currencyNotifier.value = supportedCurrencies.firstWhere(
        (currency) => currency.locale == success.ownerInfo.currencyLocale,
        orElse: () => supportedCurrencies.first,
      );
    } else if (success is GetOwnerInfoLoading) {
      getOwnerInfoStateNotifier.value = success;
    }
  }

  void _handleUpdateEmployeeCurrencyLocaleFailure(Failure failure) {
    loggy.error('Update employee currency locale failure: $failure');
    if (failure is UpdateEmployeeCurrencyLocaleEmpty) {
      updateEmployeeCurrencyLocaleStateNotifier.value =
          const UpdateEmployeeCurrencyLocaleEmpty();
    } else if (failure is UpdateEmployeeCurrencyLocaleFailure) {
      updateEmployeeCurrencyLocaleStateNotifier.value = failure;
    } else {
      updateEmployeeCurrencyLocaleStateNotifier.value =
          UpdateEmployeeCurrencyLocaleFailure(exception: failure);
    }
  }

  void _handleUpdateEmployeeCurrencyLocaleSuccess(Success success) {
    loggy.info('Update employee currency locale success');
    if (success is UpdateEmployeeCurrencyLocaleSuccess) {
      updateEmployeeCurrencyLocaleStateNotifier.value = success;
      _profileService.setParkingEmployee(success.employee);
    } else if (success is UpdateEmployeeCurrencyLocaleLoading) {
      updateEmployeeCurrencyLocaleStateNotifier.value = success;
    }
  }

  void _handleUpdateOwnerCurrencyLocaleFailure(Failure failure) {
    loggy.error('Update owner currency locale failure: $failure');
    if (failure is UpdateOwnerCurrencyLocaleEmpty) {
      updateOwnerCurrencyLocaleStateNotifier.value =
          const UpdateOwnerCurrencyLocaleEmpty();
    } else if (failure is UpdateOwnerCurrencyLocaleFailure) {
      updateOwnerCurrencyLocaleStateNotifier.value = failure;
    } else {
      updateOwnerCurrencyLocaleStateNotifier.value =
          UpdateOwnerCurrencyLocaleFailure(exception: failure);
    }
  }

  void _handleUpdateOwnerCurrencyLocaleSuccess(Success success) {
    loggy.info('Update owner currency locale success');
    if (success is UpdateOwnerCurrencyLocaleSuccess) {
      updateOwnerCurrencyLocaleStateNotifier.value = success;
      _profileService.setParkingOwner(success.owner);
    } else if (success is UpdateOwnerCurrencyLocaleLoading) {
      updateOwnerCurrencyLocaleStateNotifier.value = success;
    }
  }

  @override
  Widget build(BuildContext context) => ProfileView(controller: this);
}
