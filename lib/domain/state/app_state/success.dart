import 'package:dartz/dartz.dart';
import 'package:ecoparking_management/domain/state/app_state/failure.dart';
import 'package:equatable/equatable.dart';

abstract class Success extends Equatable {
  const Success();
}

extension SuccessExtension on Either {
  T? getSuccessOrNull<T extends Success>({T? fallbackValue}) => fold(
        (failure) => fallbackValue,
        (success) => success is T ? success : fallbackValue,
      );

  T? getFailureOrNull<T extends Failure>({T? fallbackValue}) => fold(
        (failure) => failure is T ? failure : fallbackValue,
        (success) => fallbackValue,
      );
}
