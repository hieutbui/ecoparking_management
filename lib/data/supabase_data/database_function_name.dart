enum DatabaseFunctionName {
  getLast12MonthsTotal,
  getLastYearTotal,
  getLastMonthTotal,
  getYesterDayTotal,
  getLast12MonthsTicketCount,
  getLastYearTicketCount,
  getLastMonthTicketCount,
  getYesterDayTicketCount,
  updateTicketTimes;

  String get functionName {
    switch (this) {
      case DatabaseFunctionName.getLast12MonthsTotal:
        return 'get_last_12_months_total';
      case DatabaseFunctionName.getLastYearTotal:
        return 'get_last_year_total';
      case DatabaseFunctionName.getLastMonthTotal:
        return 'get_last_month_total';
      case DatabaseFunctionName.getYesterDayTotal:
        return 'get_yesterday_total';
      case DatabaseFunctionName.getLast12MonthsTicketCount:
        return 'get_last_12_months_ticket_count';
      case DatabaseFunctionName.getLastYearTicketCount:
        return 'get_last_year_ticket_count';
      case DatabaseFunctionName.getLastMonthTicketCount:
        return 'get_last_month_ticket_count';
      case DatabaseFunctionName.getYesterDayTicketCount:
        return 'get_yesterday_ticket_count';
      case DatabaseFunctionName.updateTicketTimes:
        return 'update_ticket_times';
    }
  }
}
