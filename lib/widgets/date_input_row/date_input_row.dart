import 'package:ecoparking_management/widgets/date_input_row/date_input_row_styles.dart';
import 'package:flutter/material.dart';

class DateInputRow extends StatefulWidget {
  final DateTime? initialDate;
  final void Function(DateTime?)? onDateSelected;

  const DateInputRow({
    super.key,
    this.initialDate,
    this.onDateSelected,
  });

  @override
  State<DateInputRow> createState() => _DateInputRowState();
}

class _DateInputRowState extends State<DateInputRow> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final initialDate = widget.initialDate;
    if (initialDate != null) {
      final initialDay = initialDate.day.toString().padLeft(2, '0');
      final initialMonth = initialDate.month;
      final initialYear = initialDate.year;
      _controller = TextEditingController(
        text: '$initialDay/$initialMonth/$initialYear',
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
      width: DateInputRowStyles.width,
      child: TextField(
        controller: _controller,
        style: DateInputRowStyles.inputtedTextStyle(context),
        decoration: InputDecoration(
          hintText: 'Date of Birth',
          hintStyle: DateInputRowStyles.hintTextStyle(context),
          suffixIcon: Icon(
            Icons.calendar_today_rounded,
            color: _controller.text.isNotEmpty
                ? Colors.black
                : Theme.of(context).colorScheme.onSurfaceVariant,
            size: DateInputRowStyles.suffixIconSize,
          ),
        ),
        readOnly: true,
        textInputAction: TextInputAction.done,
        onTap: () async {
          final DateTime? picked = await _selectDate();
          if (widget.onDateSelected != null) {
            widget.onDateSelected!(picked);
          }
        },
      ),
    );
  }

  Future<DateTime?> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _controller.text =
            '${picked.day.toString().padLeft(2, '0')}/${picked.month}/${picked.year}';
      });
    }

    return picked;
  }
}
