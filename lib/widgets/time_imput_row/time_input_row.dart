import 'package:ecoparking_management/widgets/time_imput_row/time_input_row_styles.dart';
import 'package:flutter/material.dart';

class TimeInputRow extends StatefulWidget {
  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay>? onSelectTime;
  final TextInputAction? textInputAction;

  const TimeInputRow({
    super.key,
    this.initialTime,
    this.onSelectTime,
    this.textInputAction,
  });

  @override
  State<TimeInputRow> createState() => _TimeInputRowState();
}

class _TimeInputRowState extends State<TimeInputRow> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final initialTime = widget.initialTime;
    if (initialTime != null) {
      final initialHour = initialTime.hour.toString().padLeft(2, '0');
      final initialMinute = initialTime.minute.toString().padLeft(2, '0');
      _controller = TextEditingController(
        text: '$initialHour:$initialMinute',
      );
    } else {
      _controller = TextEditingController();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: TimeInputRowStyles.width,
      child: TextField(
        controller: _controller,
        style: TimeInputRowStyles.inputtedTextStyle(context),
        decoration: InputDecoration(
          hintText: 'Chọn giờ',
          hintStyle: TimeInputRowStyles.hintTextStyle(context),
          suffixIcon: Icon(
            Icons.access_time_rounded,
            color: _controller.text.isNotEmpty
                ? Colors.black
                : Theme.of(context).colorScheme.onSurfaceVariant,
            size: TimeInputRowStyles.suffixIconSize,
          ),
        ),
        readOnly: true,
        textInputAction: widget.textInputAction ?? TextInputAction.done,
        onTap: () async {
          final selectedTime = await _selectTime(context);
          if (selectedTime != null) {
            widget.onSelectTime?.call(selectedTime);
          }
        },
      ),
    );
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        final selectedHour = selectedTime.hour.toString().padLeft(2, '0');
        final selectedMinute = selectedTime.minute.toString().padLeft(2, '0');
        _controller.text = '$selectedHour:$selectedMinute';
      });
    }

    return selectedTime;
  }
}
