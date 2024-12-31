enum PreviousAnalysisViewType {
  last12months,
  lastYear,
  lastMonth,
  yesterday;

  String get title {
    switch (this) {
      case PreviousAnalysisViewType.last12months:
        return '12 tháng qua';
      case PreviousAnalysisViewType.lastYear:
        return 'Năm trước';
      case PreviousAnalysisViewType.lastMonth:
        return 'Tháng trước';
      case PreviousAnalysisViewType.yesterday:
        return 'Hôm qua';
    }
  }

  String get chartKey {
    switch (this) {
      case PreviousAnalysisViewType.last12months:
        return 'last12months';
      case PreviousAnalysisViewType.lastYear:
        return 'lastYear';
      case PreviousAnalysisViewType.lastMonth:
        return 'lastMonth';
      case PreviousAnalysisViewType.yesterday:
        return 'yesterday';
    }
  }
}
