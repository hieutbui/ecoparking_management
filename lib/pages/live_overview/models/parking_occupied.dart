import 'package:equatable/equatable.dart';

class ParkingOccupied with EquatableMixin {
  final int occupied;
  final int total;

  const ParkingOccupied({
    required this.occupied,
    required this.total,
  });

  @override
  List<Object?> get props => [
        occupied,
        total,
      ];
}
