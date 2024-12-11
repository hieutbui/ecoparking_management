enum TicketStatus {
  paid,
  cancelled,
  completed,
  active;

  @override
  String toString() {
    switch (this) {
      case TicketStatus.paid:
        return 'paid';
      case TicketStatus.cancelled:
        return 'cancelled';
      case TicketStatus.completed:
        return 'completed';
      case TicketStatus.active:
        return 'active';
    }
  }

  String get displayString {
    switch (this) {
      case TicketStatus.paid:
        return 'Paid';
      case TicketStatus.cancelled:
        return 'Cancelled';
      case TicketStatus.completed:
        return 'Completed';
      case TicketStatus.active:
        return 'Active';
    }
  }
}
