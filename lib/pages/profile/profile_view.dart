import 'package:ecoparking_management/config/app_paths.dart';
import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:ecoparking_management/domain/state/account/get_employee_info_state.dart';
import 'package:ecoparking_management/domain/state/account/get_owner_info_state.dart';
import 'package:ecoparking_management/domain/state/account/get_user_profile_state.dart';
import 'package:ecoparking_management/pages/profile/profile.dart';
import 'package:ecoparking_management/pages/profile/profile_ui_state.dart';
import 'package:ecoparking_management/pages/profile/profile_view_styles.dart';
import 'package:ecoparking_management/resources/image_paths.dart';
import 'package:ecoparking_management/utils/mixins/custom_logger.dart';
import 'package:ecoparking_management/widgets/app_scaffold.dart';
import 'package:ecoparking_management/widgets/date_input_row/date_input_row.dart';
import 'package:ecoparking_management/widgets/dropdown_currency/dropdown_currency.dart';
import 'package:ecoparking_management/widgets/dropdown_gender/dropdown_gender.dart';
import 'package:ecoparking_management/widgets/info_card_with_title.dart';
import 'package:ecoparking_management/widgets/phone_input_row/phone_input_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';

class ProfileView extends StatelessWidget with ViewLoggy {
  final ProfileController controller;

  const ProfileView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: AppPaths.profile.label,
      body: ValueListenableBuilder(
        valueListenable: controller.profileUIStateNotifier,
        builder: (context, state, child) {
          if (state is ProfileUIEmptyProfile) {
            return Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'Empty Profile',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                  const SizedBox(height: ProfileViewStyles.spacing),
                  ElevatedButton(
                    onPressed: controller.navigateToLogin,
                    child: Text(
                      'Login to your account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is ProfileUIAuthenticated) {
            final profile = state.userProfile;
            final avatar = profile.avatar;

            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: avatar != null
                        ? GFAvatar(
                            backgroundImage: NetworkImage(avatar),
                            shape: GFAvatarShape.circle,
                            size: ProfileViewStyles.avatarSize,
                          )
                        : Container(
                            width: ProfileViewStyles.avatarSize,
                            height: ProfileViewStyles.avatarSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest,
                            ),
                            child: SvgPicture.asset(
                              ImagePaths.icPerson,
                              width: ProfileViewStyles.dummyAvatarWidth,
                              height: ProfileViewStyles.dummyAvatarHeight,
                            ),
                          ),
                  ),
                  const SizedBox(height: ProfileViewStyles.avatarBottomSpacing),
                  Padding(
                    padding: ProfileViewStyles.padding,
                    child: ValueListenableBuilder(
                      valueListenable: controller.isEditing,
                      builder: (context, isEdit, child) {
                        return InfoCardWithTitle(
                          title: 'User Information',
                          functionButton: isEdit
                              ? Row(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.save,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiaryContainer,
                                      ),
                                      onPressed: controller.saveProfile,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.cancel,
                                        color:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                      onPressed: controller.cancelEditProfile,
                                    ),
                                  ],
                                )
                              : IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer,
                                  ),
                                  onPressed: controller.editProfile,
                                ),
                          child: Padding(
                            padding: ProfileViewStyles.cardPadding,
                            child: isEdit
                                ? Column(
                                    children: <Widget>[
                                      TextField(
                                        controller: controller.nameController,
                                        decoration: InputDecoration(
                                          labelText: 'Name',
                                          hintText: 'Enter your name',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                        enabled: true,
                                      ),
                                      const SizedBox(
                                        height: ProfileViewStyles.spacing,
                                      ),
                                      TextField(
                                        controller: controller.emailController,
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          hintText: 'Enter your email',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .displaySmall,
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        enabled: true,
                                      ),
                                      const SizedBox(
                                          height: ProfileViewStyles.spacing),
                                      PhoneInputRow(
                                        initialPhoneNumber:
                                            controller.phoneController.text,
                                        onChanged: controller.onPhoneChanged,
                                      ),
                                      const SizedBox(
                                          height: ProfileViewStyles.spacing),
                                      DropdownGender(
                                        initialGender:
                                            controller.genderNotifier.value,
                                        onSelectGender:
                                            controller.onSelectGender,
                                      ),
                                      const SizedBox(
                                          height: ProfileViewStyles.spacing),
                                      DateInputRow(
                                        initialDate:
                                            controller.dateNotifier.value,
                                        onDateSelected:
                                            controller.onDateSelected,
                                      ),
                                    ],
                                  )
                                : ValueListenableBuilder(
                                    valueListenable:
                                        controller.getUserProfileStateNotifier,
                                    builder:
                                        (context, getUserProfileState, child) {
                                      UserProfile userProfile;

                                      if (getUserProfileState
                                          is GetUserProfileSuccess) {
                                        userProfile =
                                            getUserProfileState.response;
                                      } else {
                                        userProfile = profile;
                                      }

                                      if (getUserProfileState
                                          is GetUserProfileLoading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      if (getUserProfileState
                                          is GetUserProfileFailure) {
                                        return Center(
                                          child: Text(
                                            'Failed to get user profile',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error,
                                                ),
                                          ),
                                        );
                                      }

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Name:',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                    ),
                                              ),
                                              Text(
                                                userProfile.fullName ?? '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .inversePrimary,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                              height: ProfileViewStyles
                                                  .infoLineSpacing),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Email:',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                    ),
                                              ),
                                              Text(
                                                userProfile.email,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .inversePrimary,
                                                    ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                              height: ProfileViewStyles
                                                  .infoLineSpacing),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Phone:',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                    ),
                                              ),
                                              Text(
                                                userProfile.phone ?? '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .inversePrimary,
                                                    ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                              height: ProfileViewStyles
                                                  .infoLineSpacing),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Gender:',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                    ),
                                              ),
                                              Text(
                                                userProfile.gender != null
                                                    ? userProfile.gender!
                                                        .toDisplayString()
                                                    : '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .inversePrimary,
                                                    ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                              height: ProfileViewStyles
                                                  .infoLineSpacing),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Date of Birth: ${userProfile.dob ?? ''}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSurface,
                                                    ),
                                              ),
                                              Text(
                                                userProfile.dob != null
                                                    ? '${userProfile.dob!.day}/${userProfile.dob!.month}/${userProfile.dob!.year}'
                                                    : '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .inversePrimary,
                                                    ),
                                              )
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                  _buildParkingPosition(
                    context: context,
                    profile: profile,
                    getEmployeeInfoStateNotifier:
                        controller.getEmployeeInfoStateNotifier,
                    getOwnerInfoStateNotifier:
                        controller.getOwnerInfoStateNotifier,
                  ),
                  const SizedBox(height: ProfileViewStyles.spacing),
                  Padding(
                    padding: ProfileViewStyles.padding,
                    child: InfoCardWithTitle(
                      title: 'Setting',
                      child: Padding(
                        padding: ProfileViewStyles.padding,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Currency: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                ),
                                const SizedBox(
                                  width: ProfileViewStyles.infoLineSpacing,
                                ),
                                ValueListenableBuilder(
                                  valueListenable: controller.currencyNotifier,
                                  builder: (context, currency, child) {
                                    return DropdownCurrency(
                                      initialCurrency: currency,
                                      onSelectCurrency:
                                          controller.onSelectCurrency,
                                    );
                                  },
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: <Widget>[
                            //     Text(
                            //       'Working start time: ',
                            //       style: Theme.of(context)
                            //           .textTheme
                            //           .bodyMedium!
                            //           .copyWith(
                            //             color: Theme.of(context)
                            //                 .colorScheme
                            //                 .onSurface,
                            //           ),
                            //     ),
                            //     const SizedBox(
                            //       width: ProfileViewStyles.infoLineSpacing,
                            //     ),
                            //     TimeInputRow(
                            //       initialTime:
                            //           controller.workingStartTimeNotifier.value,
                            //       onSelectTime:
                            //           controller.onWorkingStartTimeSelected,
                            //     )
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: <Widget>[
                            //     Text(
                            //       'Working end time: ',
                            //       style: Theme.of(context)
                            //           .textTheme
                            //           .bodyMedium!
                            //           .copyWith(
                            //             color: Theme.of(context)
                            //                 .colorScheme
                            //                 .onSurface,
                            //           ),
                            //     ),
                            //     const SizedBox(
                            //       width: ProfileViewStyles.infoLineSpacing,
                            //     ),
                            //     TimeInputRow(
                            //       initialTime:
                            //           controller.workingEndTimeNotifier.value,
                            //       onSelectTime:
                            //           controller.onWorkingEndTimeSelected,
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: ProfileViewStyles.spacing,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: ProfileViewStyles.cardPadding,
                    child: ElevatedButton(
                      onPressed: controller.onSignOut,
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                          Colors.white,
                        ),
                        padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                          ProfileViewStyles.cardPadding,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(
                              width: ProfileViewStyles.infoLineSpacing),
                          Text(
                            'Logout',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return child!;
        },
        child: Center(
          child: Center(
            child: Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildParkingPosition({
  required BuildContext context,
  required UserProfile profile,
  required ValueNotifier<GetEmployeeInfoState> getEmployeeInfoStateNotifier,
  required ValueNotifier<GetOwnerInfoState> getOwnerInfoStateNotifier,
}) {
  const cardTitle = 'Parking position';

  if (profile.accountType == AccountType.parkingOwner) {
    return Padding(
      padding: ProfileViewStyles.cardPadding,
      child: InfoCardWithTitle(
        title: cardTitle,
        child: ValueListenableBuilder(
          valueListenable: getOwnerInfoStateNotifier,
          builder: (context, state, child) {
            if (state is GetOwnerInfoEmpty || state is GetOwnerInfoFailure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(
                    ProfileViewStyles.infoLineSpacing,
                  ),
                  child: Text(
                    'Failed to get parking position',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                ),
              );
            }

            if (state is GetOwnerInfoLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is GetOwnerInfoSuccess) {
              final ownerInfo = state.ownerInfo;

              return Padding(
                padding: ProfileViewStyles.cardPadding,
                child: _buildParkingPositionInfo(
                  context: context,
                  parkingName: ownerInfo.parking?.parkingName ?? '',
                  role: profile.accountType,
                ),
              );
            }

            return child!;
          },
          child: const SizedBox.shrink(),
        ),
      ),
    );
  } else if (profile.accountType == AccountType.employee) {
    return Padding(
      padding: ProfileViewStyles.cardPadding,
      child: InfoCardWithTitle(
        title: cardTitle,
        child: ValueListenableBuilder(
          valueListenable: getEmployeeInfoStateNotifier,
          builder: (context, state, child) {
            if (state is GetEmployeeInfoEmpty ||
                state is GetEmployeeInfoFailure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(
                    ProfileViewStyles.infoLineSpacing,
                  ),
                  child: Text(
                    'Failed to get parking position',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  ),
                ),
              );
            }

            if (state is GetEmployeeInfoLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is GetEmployeeInfoSuccess) {
              final employeeInfo = state.employeeInfo;

              return Padding(
                padding: ProfileViewStyles.cardPadding,
                child: _buildParkingPositionInfo(
                  context: context,
                  parkingName: employeeInfo.parking?.parkingName ?? '',
                  role: profile.accountType,
                  workingStartTime: employeeInfo.workingStartTime,
                  workingEndTime: employeeInfo.workingEndTime,
                ),
              );
            }

            return child!;
          },
          child: const SizedBox.shrink(),
        ),
      ),
    );
  } else {
    return const SizedBox.shrink();
  }
}

Widget _buildParkingPositionInfo({
  required BuildContext context,
  required String parkingName,
  required AccountType role,
  TimeOfDay? workingStartTime,
  TimeOfDay? workingEndTime,
}) {
  return Padding(
    padding: ProfileViewStyles.cardPadding,
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Parking Name: ',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            const SizedBox(
              width: ProfileViewStyles.infoLineSpacing,
            ),
            Text(
              parkingName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
            ),
          ],
        ),
        const SizedBox(
          height: ProfileViewStyles.infoLineSpacing,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Role: ',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            Text(
              role.toDisplayString(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
            ),
          ],
        ),
        if (workingStartTime != null) ...[
          const SizedBox(
            height: ProfileViewStyles.infoLineSpacing,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Start shift: ',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              Text(
                workingStartTime.format(context),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
              ),
            ],
          ),
        ],
        if (workingEndTime != null) ...[
          const SizedBox(
            height: ProfileViewStyles.infoLineSpacing,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'End shift: ',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              Text(
                workingEndTime.format(context),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
              ),
            ],
          ),
        ],
        const SizedBox(
          height: ProfileViewStyles.infoLineSpacing,
        ),
      ],
    ),
  );
}
