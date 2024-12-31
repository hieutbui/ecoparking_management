import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecoparking_management/data/models/user_profile.dart';
import 'package:ecoparking_management/widgets/dropdown_gender/dropdown_gender_styles.dart';
import 'package:flutter/material.dart';

class DropdownGender extends StatefulWidget {
  final Gender? initialGender;
  final ValueChanged<Gender>? onSelectGender;

  const DropdownGender({
    super.key,
    this.initialGender,
    this.onSelectGender,
  });

  @override
  State<DropdownGender> createState() => _DropdownGenderState();
}

class _DropdownGenderState extends State<DropdownGender> {
  late FocusNode _focusNode;
  bool _isFocus = false;
  Gender? _selectedGender;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {
        _isFocus = _focusNode.hasFocus;
      });
    });

    if (widget.initialGender != null) {
      _selectedGender = widget.initialGender;
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Gender>(
        focusNode: _focusNode,
        value: _selectedGender,
        isExpanded: true,
        hint: Text(
          'Giới tính',
          style: DropdownGenderStyles.hintStyle(context),
        ),
        items: Gender.values
            .map(
              (Gender gender) => DropdownMenuItem(
                value: gender,
                child: Text(
                  gender.toDisplayString(),
                  style: DropdownGenderStyles.itemsTextStyle(context),
                ),
              ),
            )
            .toList(),
        onChanged: _selectGender,
        buttonStyleData: DropdownGenderStyles.buttonStyleData(
          context,
          _isFocus,
        ),
        iconStyleData: DropdownGenderStyles.iconStyleData(
          context,
          _isFocus,
          _selectedGender,
        ),
        dropdownStyleData: DropdownGenderStyles.dropdownStyleData(
          context,
          _isFocus,
        ),
      ),
    );
  }

  void _selectGender(Gender? gender) async {
    if (gender != null) {
      setState(() {
        _selectedGender = gender;
      });
      if (widget.onSelectGender != null) {
        widget.onSelectGender!(gender);
      }
    }
  }
}
