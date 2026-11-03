import 'package:flutter/material.dart';

class DefaultDatePicker extends StatefulWidget {
  const DefaultDatePicker({super.key});

  @override
  State<DefaultDatePicker> createState() => _DefaultDatePickerState();
}

class _DefaultDatePickerState extends State<DefaultDatePicker> {
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: _dateController,
        decoration: const InputDecoration(
          hintText: "Enter your date",
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        readOnly: true,
        onTap: () => _selectDate(context),
      ),
    );
  }
}
