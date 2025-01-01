import 'package:ecoparking_management/config/app_config.dart';
import 'package:ecoparking_management/data/models/employee_nested_info.dart';
import 'package:ecoparking_management/domain/state/analysis/export_data_state.dart';
import 'package:ecoparking_management/domain/state/employee/create_new_employee_state.dart';
import 'package:ecoparking_management/domain/state/employee/delete_employee_state.dart';
import 'package:ecoparking_management/domain/state/employee/save_attendance_to_xlsx_state.dart';
import 'package:ecoparking_management/domain/state/employee/save_employee_to_xlsx_state.dart';
import 'package:ecoparking_management/widgets/time_imput_row/time_input_row.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static final GlobalKey<ScaffoldState> dialogScaffoldKey =
      GlobalKey<ScaffoldState>();

  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isDismissible = false,
    bool useRootNavigator = true,
  }) async {
    return showAdaptiveDialog<T>(
      context: context,
      barrierDismissible: isDismissible,
      useRootNavigator: useRootNavigator,
      builder: builder,
    );
  }

  static Future<bool?> showRequiredLogin<bool>(BuildContext context) async {
    return show<bool>(
      context: context,
      builder: _buildRequiredLoginDialog,
    );
  }

  static Future<void> showLoginError(BuildContext context) async {
    return show(
      context: context,
      builder: _buildLoginErrorDialog,
    );
  }

  static Future<void> showSomethingWentWrong(BuildContext context) async {
    return show(
      context: context,
      builder: _buildSomethingWentWrongDialog,
    );
  }

  static Future<void> showNotAllowedAccount(BuildContext context) async {
    return show(
      context: context,
      builder: _buildNotAllowedAccountDialog,
    );
  }

  static Future<void> showFillAllLoginFields(BuildContext context) async {
    return show(
      context: context,
      builder: _buildFillAllLoginFieldsDialog,
    );
  }

  static Future<ConfirmAction?> showEmployeeInfoDialog({
    required BuildContext context,
    required EmployeeNestedInfo employeeNestedInfo,
    required void Function(TimeOfDay) onStartShiftSelected,
    required void Function(TimeOfDay) onEndShiftSelected,
  }) async {
    return show<ConfirmAction>(
      context: context,
      builder: _buildEmployeeInfoDialog(
        employeeNestedInfo: employeeNestedInfo,
        onStartShiftSelected: onStartShiftSelected,
        onEndShiftSelected: onEndShiftSelected,
      ),
    );
  }

  static Future<ConfirmAction?> showCreateEmployeeDialog({
    required BuildContext context,
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required void Function(TimeOfDay) onStartShiftSelected,
    required void Function(TimeOfDay) onEndShiftSelected,
    required ValueNotifier<CreateNewEmployeeState> notifier,
    required void Function() onCreateEmployee,
  }) async {
    return show<ConfirmAction>(
      context: context,
      builder: _buildCreateEmployeeDialog(
        nameController: nameController,
        emailController: emailController,
        passwordController: passwordController,
        onStartShiftSelected: onStartShiftSelected,
        onEndShiftSelected: onEndShiftSelected,
        notifier: notifier,
        onCreateEmployee: onCreateEmployee,
      ),
    );
  }

  static Future<ConfirmAction?> showDeleteEmployeeDialog({
    required BuildContext context,
    required void Function() onDeleteEmployee,
    required ValueNotifier<DeleteEmployeeState> notifier,
  }) async {
    return show<ConfirmAction>(
      context: context,
      builder: _buildDeleteEmployeeDialog(
        onDeleteEmployee: onDeleteEmployee,
        notifier: notifier,
      ),
    );
  }

  static Future<ConfirmAction?> showNotSelectedEmployeeDialog({
    required BuildContext context,
  }) async {
    return show<ConfirmAction>(
      context: context,
      builder: _buildNotSelectedEmployeeDialog,
    );
  }

  static Future<ConfirmAction?> showSaveEmployeeToXlsxDialog({
    required BuildContext context,
    required ValueNotifier<SaveEmployeeToXlsxState> notifier,
    required void Function() onSaveEmployeeToXlsx,
  }) async {
    onSaveEmployeeToXlsx();

    return show<ConfirmAction>(
      context: context,
      builder: _buildSaveEmployeeToXlsxDialog(
        notifier: notifier,
      ),
    );
  }

  static Future<ConfirmAction?> showExportDataDialog({
    required BuildContext context,
    required ValueNotifier<ExportDataState> notifier,
    required void Function() onExportData,
  }) async {
    onExportData();

    return show<ConfirmAction>(
      context: context,
      builder: _buildExportDataDialog(
        notifier: notifier,
      ),
    );
  }

  static Future<ConfirmAction?> showInvalidTicketDialog({
    required BuildContext context,
  }) async {
    return show<ConfirmAction>(
      context: context,
      builder: _buildInvalidTicketDialog,
    );
  }

  static Future<DateTime?> showSelectDateDialog({
    required BuildContext context,
    required DateTime initialDate,
    required String restorationId,
  }) async {
    return show<DateTime>(
      context: context,
      builder: _buildSelectDateDialog(
        initialDate: initialDate,
        restorationId: restorationId,
      ),
    );
  }

  static Future<ConfirmAction?> showSaveAttendanceToXlsxDialog({
    required BuildContext context,
    required ValueNotifier<SaveAttendanceToXlsxState> notifier,
    required void Function() onSaveAttendanceToXlsx,
  }) async {
    onSaveAttendanceToXlsx();

    return show<ConfirmAction>(
      context: context,
      builder: _buildSaveAttendanceToXlsxDialog(
        notifier: notifier,
      ),
    );
  }

  static WidgetBuilder get _buildRequiredLoginDialog => (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Vui lòng đăng nhập',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          content: Text(
            'Bạn cần đăng nhập để sử dụng tính năng này!',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
          ),
          surfaceTintColor: AppConfig.baseBackgroundColor,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              child: Text(
                'Đăng nhập',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        );
      };

  static WidgetBuilder get _buildLoginErrorDialog => (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Đăng nhập thất bại!',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          content: Text(
            'Đã xảy ra lỗi khi đăng nhập. Vui lòng thử lại.',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
          ),
          surfaceTintColor: AppConfig.baseBackgroundColor,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        );
      };

  static WidgetBuilder get _buildSomethingWentWrongDialog =>
      (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Đã xảy ra lỗi!',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          content: Text(
            'Đã xảy ra lỗi. Vui lòng thử lại.',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
          ),
          surfaceTintColor: AppConfig.baseBackgroundColor,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        );
      };

  static WidgetBuilder get _buildNotAllowedAccountDialog =>
      (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Tài khoản không có quyền truy cập',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          content: Text(
            'Tài khoản của bạn không có quyền truy cập vào tính năng này. Vui lòng liên hệ với quản trị viên để biết thêm chi tiết.',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
          ),
          surfaceTintColor: AppConfig.baseBackgroundColor,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        );
      };

  static WidgetBuilder get _buildFillAllLoginFieldsDialog =>
      (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Thiếu thông tin đăng nhập',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          content: Text(
            'Vui lòng điền đầy đủ thông tin để đăng nhập.',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
          ),
          surfaceTintColor: AppConfig.baseBackgroundColor,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        );
      };

  static WidgetBuilder _buildEmployeeInfoDialog({
    required EmployeeNestedInfo employeeNestedInfo,
    required void Function(TimeOfDay) onStartShiftSelected,
    required void Function(TimeOfDay) onEndShiftSelected,
  }) =>
      (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Thông tin nhân viên',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
          ),
          content: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tên:',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    Text(
                      employeeNestedInfo.profile.name,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Email:',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    Text(
                      employeeNestedInfo.profile.email,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SĐT:',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    Text(
                      employeeNestedInfo.profile.phone ?? '',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Bắt đầu ca: ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(width: 24.0),
                    TimeInputRow(
                      initialTime: employeeNestedInfo.workingStartTime,
                      onSelectTime: onStartShiftSelected,
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Kết thúc ca: ',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(width: 24.0),
                    TimeInputRow(
                      initialTime: employeeNestedInfo.workingEndTime,
                      onSelectTime: onEndShiftSelected,
                    )
                  ],
                ),
              ],
            ),
          ),
          surfaceTintColor: AppConfig.baseBackgroundColor,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(ConfirmAction.cancel),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.outline,
                ),
                shape: const WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
              label: Text(
                'Bỏ qua',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppConfig.negativeTextColor,
                    ),
              ),
              icon: const Icon(
                Icons.cancel,
                color: AppConfig.negativeTextColor,
              ),
            ),
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(ConfirmAction.ok),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.secondary,
                ),
                shape: const WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
              label: Text(
                'OK',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
              icon: Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ],
        );
      };

  static WidgetBuilder _buildCreateEmployeeDialog({
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required void Function(TimeOfDay) onStartShiftSelected,
    required void Function(TimeOfDay) onEndShiftSelected,
    required ValueNotifier<CreateNewEmployeeState> notifier,
    required void Function() onCreateEmployee,
  }) =>
      (BuildContext context) {
        return ValueListenableBuilder(
          valueListenable: notifier,
          builder: (context, state, child) {
            if (state is CreateNewEmployeeInitial) {
              final ValueNotifier<bool> isObscurePassword =
                  ValueNotifier<bool>(true);

              return AlertDialog(
                title: Text(
                  'Tạo nhân viên mới',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                ),
                content: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Tên',
                          hintText: 'Nhập tên',
                          labelStyle: Theme.of(context).textTheme.displaySmall,
                          hintStyle: Theme.of(context).textTheme.headlineSmall,
                        ),
                        enabled: true,
                      ),
                      const SizedBox(height: 8.0),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Nhập email',
                          labelStyle: Theme.of(context).textTheme.displaySmall,
                          hintStyle: Theme.of(context).textTheme.headlineSmall,
                        ),
                        enabled: true,
                      ),
                      const SizedBox(height: 8.0),
                      ValueListenableBuilder(
                        valueListenable: isObscurePassword,
                        builder: (context, isObscure, child) {
                          return TextField(
                            controller: passwordController,
                            obscureText: isObscure,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Nhập mật khẩu',
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
                                  isObscurePassword.value = !isObscure;
                                },
                              ),
                            ),
                            enabled: true,
                          );
                        },
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Bắt đầu ca: ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                          const SizedBox(width: 24.0),
                          TimeInputRow(
                            onSelectTime: onStartShiftSelected,
                          )
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Kết thúc ca: ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                          const SizedBox(width: 24.0),
                          TimeInputRow(
                            onSelectTime: onEndShiftSelected,
                          )
                        ],
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pop(ConfirmAction.cancel),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.outline,
                      ),
                      shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      'Bỏ qua',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppConfig.negativeTextColor,
                              ),
                    ),
                    icon: const Icon(
                      Icons.cancel,
                      color: AppConfig.negativeTextColor,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: onCreateEmployee,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.secondary,
                      ),
                      shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      'OK',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ],
              );
            }

            if (state is CreateNewEmployeeLoading) {
              return AlertDialog(
                title: Text(
                  'Đang tạo nhân viên',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                ),
                content: const SizedBox(
                  height: 48.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                surfaceTintColor: AppConfig.baseBackgroundColor,
              );
            }

            if (state is CreateNewEmployeeAuthFailure ||
                state is CreateNewEmployeeEmpty ||
                state is CreateNewEmployeeFailure) {
              return AlertDialog(
                title: Text(
                  'Không thể tạo nhân viên!',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
                content: Text(
                  'Đã xảy ra lỗi khi tạo nhân viên. Vui lòng thử lại.',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                ),
                surfaceTintColor: AppConfig.baseBackgroundColor,
                actions: <Widget>[
                  TextButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pop(ConfirmAction.cancel),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.outline,
                      ),
                      shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      'Bỏ qua',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppConfig.negativeTextColor,
                              ),
                    ),
                    icon: const Icon(
                      Icons.cancel,
                      color: AppConfig.negativeTextColor,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pop(ConfirmAction.ok),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.secondary,
                      ),
                      shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      'OK',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ],
              );
            }

            if (state is CreateNewEmployeeSuccess) {
              return AlertDialog(
                title: Text(
                  'Tạo nhân viên thành công',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.onSecondary,
                      size: 48.0,
                    ),
                    Text(
                      'Nhân viên đã được tạo thành công.',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                    ),
                  ],
                ),
                surfaceTintColor: AppConfig.baseBackgroundColor,
                actions: <Widget>[
                  TextButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pop(ConfirmAction.cancel),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.outline,
                      ),
                      shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      'Bỏ qua',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppConfig.negativeTextColor,
                              ),
                    ),
                    icon: const Icon(
                      Icons.cancel,
                      color: AppConfig.negativeTextColor,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pop(ConfirmAction.ok),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.secondary,
                      ),
                      shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      'OK',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ],
              );
            }

            return child!;
          },
          child: AlertDialog(
            title: Text(
              'Tạo nhân viên thất bại!',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            content: Text(
              'Đã xảy ra lỗi khi tạo nhân viên. Vui lòng thử lại.',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
            ),
            surfaceTintColor: AppConfig.baseBackgroundColor,
            actions: <Widget>[
              TextButton.icon(
                onPressed: () =>
                    Navigator.of(context).pop(ConfirmAction.cancel),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    Theme.of(context).colorScheme.outline,
                  ),
                  shape: const WidgetStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                label: Text(
                  'Bỏ qua',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: AppConfig.negativeTextColor,
                      ),
                ),
                icon: const Icon(
                  Icons.cancel,
                  color: AppConfig.negativeTextColor,
                ),
              ),
              TextButton.icon(
                onPressed: () => Navigator.of(context).pop(ConfirmAction.ok),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    Theme.of(context).colorScheme.secondary,
                  ),
                  shape: const WidgetStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                label: Text(
                  'OK',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                icon: Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        );
      };

  static WidgetBuilder _buildDeleteEmployeeDialog({
    required void Function() onDeleteEmployee,
    required ValueNotifier<DeleteEmployeeState> notifier,
  }) =>
      (BuildContext context) {
        return ValueListenableBuilder(
          valueListenable: notifier,
          builder: (context, state, child) {
            if (state is DeleteEmployeeInitial) {
              return AlertDialog(
                title: Text(
                  'Xac nhận xóa nhân viên',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
                content: Text(
                  'Bạn có chắc chắn muốn xóa nhân viên này?',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                ),
                surfaceTintColor: AppConfig.baseBackgroundColor,
                actions: <Widget>[
                  TextButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pop(ConfirmAction.cancel),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.outline,
                      ),
                      shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      'Bỏ qua',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppConfig.negativeTextColor,
                              ),
                    ),
                    icon: const Icon(
                      Icons.cancel,
                      color: AppConfig.negativeTextColor,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: onDeleteEmployee,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.secondary,
                      ),
                      shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      'OK',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ],
              );
            }

            if (state is DeleteEmployeeLoading) {
              return AlertDialog(
                title: Text(
                  'Đang xóa nhân viên',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                ),
                content: const SizedBox(
                  height: 48.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                surfaceTintColor: AppConfig.baseBackgroundColor,
              );
            }

            if (state is DeleteEmployeeFailure) {
              return AlertDialog(
                title: Text(
                  'Xóa nhân viên thất bại!',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
                content: Text(
                  'An error occurred while trying to delete employee. Please try again.',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                ),
                surfaceTintColor: AppConfig.baseBackgroundColor,
                actions: <Widget>[
                  TextButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pop(ConfirmAction.cancel),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.outline,
                      ),
                      shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      'Bỏ qua',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppConfig.negativeTextColor,
                              ),
                    ),
                    icon: const Icon(
                      Icons.cancel,
                      color: AppConfig.negativeTextColor,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pop(ConfirmAction.ok),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.secondary,
                      ),
                      shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      'OK',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ],
              );
            }

            if (state is DeleteEmployeeSuccess) {
              return AlertDialog(
                title: Text(
                  'Xóa nhân viên thành công',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.onSecondary,
                      size: 48.0,
                    ),
                    Text(
                      'Nhân viên đã được xóa thành công.',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                    ),
                  ],
                ),
                surfaceTintColor: AppConfig.baseBackgroundColor,
                actions: <Widget>[
                  TextButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pop(ConfirmAction.cancel),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.outline,
                      ),
                      shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      'Bỏ qua',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppConfig.negativeTextColor,
                              ),
                    ),
                    icon: const Icon(
                      Icons.cancel,
                      color: AppConfig.negativeTextColor,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pop(ConfirmAction.ok),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.secondary,
                      ),
                      shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      'OK',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ],
              );
            }

            return child!;
          },
          child: AlertDialog(
            title: Text(
              'Xóa nhân viên thất bại!',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            content: Text(
              'Đã xảy ra lỗi khi xóa nhân viên. Vui lòng thử lại.',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
            ),
            surfaceTintColor: AppConfig.baseBackgroundColor,
            actions: <Widget>[
              TextButton.icon(
                onPressed: () =>
                    Navigator.of(context).pop(ConfirmAction.cancel),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    Theme.of(context).colorScheme.outline,
                  ),
                  shape: const WidgetStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                label: Text(
                  'Bỏ qua',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: AppConfig.negativeTextColor,
                      ),
                ),
                icon: const Icon(
                  Icons.cancel,
                  color: AppConfig.negativeTextColor,
                ),
              ),
              TextButton.icon(
                onPressed: () => Navigator.of(context).pop(ConfirmAction.ok),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    Theme.of(context).colorScheme.secondary,
                  ),
                  shape: const WidgetStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                label: Text(
                  'OK',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                icon: Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        );
      };

  static WidgetBuilder get _buildNotSelectedEmployeeDialog =>
      (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Chưa chọn nhân viên',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          content: Text(
            'Vui lòng chọn một nhân viên để thực hiện thao tác này.',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
          ),
          surfaceTintColor: AppConfig.baseBackgroundColor,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(ConfirmAction.ok),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.secondary,
                ),
                shape: const WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
              label: Text(
                'OK',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
              icon: Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ],
        );
      };

  static WidgetBuilder _buildSaveEmployeeToXlsxDialog({
    required ValueNotifier<SaveEmployeeToXlsxState> notifier,
  }) =>
      (BuildContext context) {
        return ValueListenableBuilder(
          valueListenable: notifier,
          builder: (context, state, child) {
            if (state is SaveEmployeeToXlsxInitial ||
                state is SaveEmployeeToXlsxLoading) {
              return AlertDialog(
                title: Text(
                  'Đang lưu nhân viên',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                ),
                content: const SizedBox(
                  height: 48.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                surfaceTintColor: AppConfig.baseBackgroundColor,
              );
            }

            if (state is SaveEmployeeToXlsxSuccess) {
              return AlertDialog(
                title: Text(
                  'Lưu nhân viên thành công',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.onSecondary,
                      size: 48.0,
                    ),
                    Text(
                      'Nhân viên đã được lưu thành công.',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                    ),
                  ],
                ),
                surfaceTintColor: AppConfig.baseBackgroundColor,
                actions: <Widget>[
                  TextButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pop(ConfirmAction.cancel),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.outline,
                      ),
                      shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      'Bỏ qua',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppConfig.negativeTextColor,
                              ),
                    ),
                    icon: const Icon(
                      Icons.cancel,
                      color: AppConfig.negativeTextColor,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pop(ConfirmAction.ok),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.secondary,
                      ),
                      shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      'OK',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ],
              );
            }

            return child!;
          },
          child: AlertDialog(
            title: Text(
              'Lưu nhân viên thất bại!',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            content: Text(
              'Đã xảy ra lỗi khi lưu nhân viên. Vui lòng thử lại.',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
            ),
            surfaceTintColor: AppConfig.baseBackgroundColor,
            actions: <Widget>[
              TextButton.icon(
                onPressed: () =>
                    Navigator.of(context).pop(ConfirmAction.cancel),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    Theme.of(context).colorScheme.outline,
                  ),
                  shape: const WidgetStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                label: Text(
                  'Bỏ qua',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: AppConfig.negativeTextColor,
                      ),
                ),
                icon: const Icon(
                  Icons.cancel,
                  color: AppConfig.negativeTextColor,
                ),
              ),
              TextButton.icon(
                onPressed: () => Navigator.of(context).pop(ConfirmAction.ok),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    Theme.of(context).colorScheme.secondary,
                  ),
                  shape: const WidgetStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                label: Text(
                  'OK',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                icon: Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        );
      };

  static WidgetBuilder _buildExportDataDialog({
    required ValueNotifier<ExportDataState> notifier,
  }) =>
      (BuildContext context) {
        return ValueListenableBuilder(
          valueListenable: notifier,
          builder: (context, state, child) {
            if (state is ExportDataInitial || state is ExportDataLoading) {
              return AlertDialog(
                title: Text(
                  'Đang xuất dữ liệu',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                ),
                content: const SizedBox(
                  height: 48.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                surfaceTintColor: AppConfig.baseBackgroundColor,
              );
            }

            if (state is ExportDataSuccess) {
              return AlertDialog(
                title: Text(
                  'Xuất dữ liệu thành công',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.onSecondary,
                      size: 48.0,
                    ),
                    Text(
                      'Dữ liệu đã được xuất thành công.',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                    ),
                  ],
                ),
                surfaceTintColor: AppConfig.baseBackgroundColor,
                actions: <Widget>[
                  TextButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pop(ConfirmAction.cancel),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.outline,
                      ),
                      shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      'Bỏ qua',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppConfig.negativeTextColor,
                              ),
                    ),
                    icon: const Icon(
                      Icons.cancel,
                      color: AppConfig.negativeTextColor,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pop(ConfirmAction.ok),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.secondary,
                      ),
                      shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      'OK',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ],
              );
            }

            return child!;
          },
          child: AlertDialog(
            title: Text(
              'Xuất dữ liệu thất bại!',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            content: Text(
              'Đã xảy ra lỗi khi xuất dữ liệu. Vui lòng thử lại.',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
            ),
            surfaceTintColor: AppConfig.baseBackgroundColor,
            actions: <Widget>[
              TextButton.icon(
                onPressed: () =>
                    Navigator.of(context).pop(ConfirmAction.cancel),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    Theme.of(context).colorScheme.outline,
                  ),
                  shape: const WidgetStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                label: Text(
                  'Bỏ qua',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: AppConfig.negativeTextColor,
                      ),
                ),
                icon: const Icon(
                  Icons.cancel,
                  color: AppConfig.negativeTextColor,
                ),
              ),
              TextButton.icon(
                onPressed: () => Navigator.of(context).pop(ConfirmAction.ok),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    Theme.of(context).colorScheme.secondary,
                  ),
                  shape: const WidgetStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                label: Text(
                  'OK',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                icon: Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        );
      };

  static WidgetBuilder get _buildInvalidTicketDialog => (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Vé không hợp lệ',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          content: Text(
            'Vé không hợp lệ hoặc đã được sử dụng. Vui lòng kiểm tra lại.',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
          ),
          surfaceTintColor: AppConfig.baseBackgroundColor,
          actions: <Widget>[
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(ConfirmAction.cancel),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.outline,
                ),
                shape: const WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
              label: Text(
                'Bỏ qua',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppConfig.negativeTextColor,
                    ),
              ),
              icon: const Icon(
                Icons.cancel,
                color: AppConfig.negativeTextColor,
              ),
            ),
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(ConfirmAction.ok),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.secondary,
                ),
                shape: const WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
              label: Text(
                'OK',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
              icon: Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ],
        );
      };

  static WidgetBuilder _buildSelectDateDialog({
    required DateTime initialDate,
    required String restorationId,
  }) =>
      (BuildContext context) {
        final lastDate = DateTime.now();
        final firstDate = DateTime.now().subtract(const Duration(days: 365));

        return DatePickerDialog(
          restorationId: restorationId,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
        );
      };

  static WidgetBuilder _buildSaveAttendanceToXlsxDialog({
    required ValueNotifier<SaveAttendanceToXlsxState> notifier,
  }) =>
      (BuildContext context) {
        return ValueListenableBuilder(
          valueListenable: notifier,
          builder: (context, state, child) {
            if (state is SaveAttendanceToXlsxInitial ||
                state is SaveAttendanceToXlsxLoading) {
              return AlertDialog(
                title: Text(
                  'Đang lưu thông tin chấm công',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                ),
                content: const SizedBox(
                  height: 48.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                surfaceTintColor: AppConfig.baseBackgroundColor,
              );
            }

            if (state is SaveAttendanceToXlsxSuccess) {
              return AlertDialog(
                title: Text(
                  'Lưu thông tin chấm công thành công',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.onSecondary,
                      size: 48.0,
                    ),
                    Text(
                      'Thông tin chấm công đã được lưu thành công.',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                    ),
                  ],
                ),
                surfaceTintColor: AppConfig.baseBackgroundColor,
                actions: <Widget>[
                  TextButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pop(ConfirmAction.cancel),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.outline,
                      ),
                      shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      'Bỏ qua',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppConfig.negativeTextColor,
                              ),
                    ),
                    icon: const Icon(
                      Icons.cancel,
                      color: AppConfig.negativeTextColor,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () =>
                        Navigator.of(context).pop(ConfirmAction.ok),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.secondary,
                      ),
                      shape: const WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    label: Text(
                      'OK',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                    ),
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ],
              );
            }

            return child!;
          },
          child: AlertDialog(
            title: Text(
              'Lưu thông tin chấm công thất bại!',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            content: Text(
              'Đã xảy ra lỗi khi lưu thông tin chấm công. Vui lòng thử lại.',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
            ),
            surfaceTintColor: AppConfig.baseBackgroundColor,
            actions: <Widget>[
              TextButton.icon(
                onPressed: () =>
                    Navigator.of(context).pop(ConfirmAction.cancel),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    Theme.of(context).colorScheme.outline,
                  ),
                  shape: const WidgetStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                label: Text(
                  'Bỏ qua',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: AppConfig.negativeTextColor,
                      ),
                ),
                icon: const Icon(
                  Icons.cancel,
                  color: AppConfig.negativeTextColor,
                ),
              ),
              TextButton.icon(
                onPressed: () => Navigator.of(context).pop(ConfirmAction.ok),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(
                    Theme.of(context).colorScheme.secondary,
                  ),
                  shape: const WidgetStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                label: Text(
                  'OK',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
                icon: Icon(
                  Icons.check,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        );
      };
}

enum ConfirmAction {
  cancel,
  ok;

  String get title {
    switch (this) {
      case ConfirmAction.cancel:
        return 'Bỏ qua';
      case ConfirmAction.ok:
        return 'OK';
    }
  }
}
