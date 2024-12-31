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
        return 'Đã thanh toán';
      case TicketStatus.cancelled:
        return 'Đã hủy';
      case TicketStatus.completed:
        return 'Hoàn thành';
      case TicketStatus.active:
        return 'Đang hoạt động';
    }
  }
}
