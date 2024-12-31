import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecoparking_management/pages/previous_analysis/previous_analysis_view_type.dart';
import 'package:ecoparking_management/widgets/dropdown_previous_view_type/dropdown_previous_view_type_styles.dart';
import 'package:flutter/material.dart';

class DropdownPreviousViewType extends StatefulWidget {
  final PreviousAnalysisViewType initialViewType;
  final ValueChanged<PreviousAnalysisViewType>? onSelectViewType;

  const DropdownPreviousViewType({
    super.key,
    required this.initialViewType,
    this.onSelectViewType,
  });

  @override
  State<DropdownPreviousViewType> createState() =>
      _DropdownPreviousViewTypeState();
}

class _DropdownPreviousViewTypeState extends State<DropdownPreviousViewType> {
  late FocusNode _focusNode;
  bool _isFocus = false;
  PreviousAnalysisViewType? _selectedViewType;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {
        _isFocus = _focusNode.hasFocus;
      });
    });

    _selectedViewType = widget.initialViewType;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        focusNode: _focusNode,
        value: _selectedViewType,
        isExpanded: true,
        hint: Text(
          'Chọn loại hiển thị',
          style: DropdownPreviousViewTypeStyles.hintStyle(context),
        ),
        items: PreviousAnalysisViewType.values
            .map(
              (PreviousAnalysisViewType viewType) => DropdownMenuItem(
                value: viewType,
                child: Text(
                  viewType.title,
                  style: DropdownPreviousViewTypeStyles.itemsTextStyle(context),
                ),
              ),
            )
            .toList(),
        onChanged: _onSelectViewType,
        buttonStyleData: DropdownPreviousViewTypeStyles.buttonStyleData,
        iconStyleData: DropdownPreviousViewTypeStyles.iconStyleData(
          context,
          _isFocus,
        ),
        dropdownStyleData:
            DropdownPreviousViewTypeStyles.dropdownStyleData(context),
      ),
    );
  }

  void _onSelectViewType(PreviousAnalysisViewType? viewType) {
    if (viewType != null) {
      setState(() {
        _selectedViewType = viewType;
      });

      if (widget.onSelectViewType != null) {
        widget.onSelectViewType!(viewType);
      }
    }
  }
}
