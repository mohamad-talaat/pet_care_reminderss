import 'package:flutter/material.dart';

class CustomDaysField extends StatelessWidget {
  final int customDays;
  final Function(String) onCustomDaysChanged;

  const CustomDaysField({
    super.key,
    required this.customDays,
    required this.onCustomDaysChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: customDays.toString(),
      decoration: InputDecoration(
        labelText: 'عدد الأيام',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'يرجى إدخال عدد الأيام';
        }
        final days = int.tryParse(value);
        if (days == null || days < 1) {
          return 'يرجى إدخال عدد صحيح أكبر من 0';
        }
        return null;
      },
      onChanged: onCustomDaysChanged,
    );
  }
}
