enum PreviousAnalysisViewType {
  last12months,
  lastYear,
  lastMonth,
  yesterday;

  String get title {
    switch (this) {
      case PreviousAnalysisViewType.last12months:
        return 'Last 12 months';
      case PreviousAnalysisViewType.lastYear:
        return 'Last year';
      case PreviousAnalysisViewType.lastMonth:
        return 'Last month';
      case PreviousAnalysisViewType.yesterday:
        return 'Yesterday';
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
