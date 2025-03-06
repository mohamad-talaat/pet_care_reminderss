import 'package:flutter/material.dart';

class RepeatTypeField extends StatelessWidget {
  final String repeatType;
  final Function(String?) onRepeatTypeChanged;

  const RepeatTypeField({
    super.key,
    required this.repeatType,
    required this.onRepeatTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: repeatType,
      decoration: InputDecoration(
        labelText: 'التكرار',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      items: const [
        DropdownMenuItem(
          value: 'once',
          child: Text('مرة واحدة'),
        ),
        DropdownMenuItem(
          value: 'daily',
          child: Text('يومياً'),
        ),
        DropdownMenuItem(
          value: 'weekly',
          child: Text('أسبوعياً'),
        ),
        DropdownMenuItem(
          value: 'monthly',
          child: Text('شهرياً'),
        ),
        DropdownMenuItem(
          value: 'custom',
          child: Text('مخصص'),
        ),
      ],
      onChanged: onRepeatTypeChanged,
    );
  }
}
