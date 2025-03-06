import 'package:flutter/material.dart';

class TaskTypeField extends StatelessWidget {
  final String taskType;
  final Function(String?) onTaskTypeChanged;

  const TaskTypeField({
    super.key,
    required this.taskType,
    required this.onTaskTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: taskType,
      decoration: InputDecoration(
        labelText: 'نوع المهمة',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      items: const [
        DropdownMenuItem(
          value: 'feeding',
          child: Text('موعد الطعام'),
        ),
        DropdownMenuItem(
          value: 'walking',
          child: Text('موعد المشي'),
        ),
        DropdownMenuItem(
          value: 'vet',
          child: Text('زيارة الطبيب البيطري'),
        ),
        DropdownMenuItem(
          value: 'medicine',
          child: Text('موعد الدواء'),
        ),
        DropdownMenuItem(
          value: 'bathing',
          child: Text('موعد الاستحمام'),
        ),
        DropdownMenuItem(
          value: 'shopping',
          child: Text('شراء الطعام'),
        ),
      ],
      onChanged: onTaskTypeChanged,
    );
  }
}
