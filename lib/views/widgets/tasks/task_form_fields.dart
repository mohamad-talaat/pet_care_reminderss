import 'package:flutter/material.dart';
import 'package:pet_reminder/views/widgets/tasks/form_fields/task_type_field.dart';
import 'package:pet_reminder/views/widgets/tasks/form_fields/date_time_field.dart';
import 'package:pet_reminder/views/widgets/tasks/form_fields/repeat_type_field.dart';
import 'package:pet_reminder/views/widgets/tasks/form_fields/custom_days_field.dart';
import 'package:pet_reminder/views/widgets/tasks/form_fields/notes_field.dart';

class TaskFormFields extends StatelessWidget {
  final String taskType;
  final DateTime taskDate;
  final String repeatType;
  final int customDays;
  final TextEditingController notesController;
  final Function(String?) onTaskTypeChanged;
  final Function(DateTime) onDateChanged;
  final Function(String?) onRepeatTypeChanged;
  final Function(String) onCustomDaysChanged;
  final bool showCustomDays;

  const TaskFormFields({
    super.key,
    required this.taskType,
    required this.taskDate,
    required this.repeatType,
    required this.customDays,
    required this.notesController,
    required this.onTaskTypeChanged,
    required this.onDateChanged,
    required this.onRepeatTypeChanged,
    required this.onCustomDaysChanged,
    required this.showCustomDays,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TaskTypeField(
          taskType: taskType,
          onTaskTypeChanged: onTaskTypeChanged,
        ),
        const SizedBox(height: 16),
        DateTimeField(
          taskDate: taskDate,
          onDateChanged: onDateChanged,
        ),
        const SizedBox(height: 16),
        RepeatTypeField(
          repeatType: repeatType,
          onRepeatTypeChanged: onRepeatTypeChanged,
        ),
        if (showCustomDays) ...[
          const SizedBox(height: 16),
          CustomDaysField(
            customDays: customDays,
            onCustomDaysChanged: onCustomDaysChanged,
          ),
        ],
        const SizedBox(height: 16),
        NotesField(
          notesController: notesController,
        ),
      ],
    );
  }
}
