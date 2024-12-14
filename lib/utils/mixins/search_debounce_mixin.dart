import 'package:easy_debounce/easy_debounce.dart';

mixin SearchDebounceMixin {
  static const _debounceIntervalDuration = Duration(milliseconds: 300);
  static const _debounceId = 'search_debounce';

  String? _searchQuery;
  void Function(String?)? _onDebounce;

  void initializeDebounce({required void Function(String?) onDebounce}) {
    _onDebounce = onDebounce;
  }

  void setSearchQuery(String? searchQuery) {
    _searchQuery = searchQuery;
    EasyDebounce.debounce(
      _debounceId,
      _debounceIntervalDuration,
      () => _onDebounce?.call(_searchQuery),
    );
  }

  void cancelDebounce() {
    EasyDebounce.cancel(_debounceId);
  }
}
