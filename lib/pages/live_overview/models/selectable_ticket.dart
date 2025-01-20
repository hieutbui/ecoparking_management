import 'package:ecoparking_management/data/models/ticket_info.dart';
import 'package:equatable/equatable.dart';

class SelectableTicket with EquatableMixin {
  final TicketInfo ticket;
  final bool isSelected;

  SelectableTicket({
    required this.ticket,
    this.isSelected = false,
  });

  SelectableTicket copyWith({
    TicketInfo? ticket,
    bool? isSelected,
  }) {
    return SelectableTicket(
      ticket: ticket ?? this.ticket,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [ticket, isSelected];
}
