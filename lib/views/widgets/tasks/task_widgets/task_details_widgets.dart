import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_reminder/models/task_model.dart';
 
Widget buildTaskDetails(BuildContext context, Task task) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Get.theme.primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        buildDetailItem(context, 'نوع المهمة', getTaskTypeName(task.type)),
        const SizedBox(height: 16),
        buildDetailItem(
            context, 'التاريخ', DateFormat.yMMMMd('ar').format(task.date)),
        const SizedBox(height: 16),
        buildDetailItem(
            context, 'الوقت', DateFormat.jm('ar').format(task.date)),
        const SizedBox(height: 16),
        buildDetailItem(context, 'التكرار', getRepeatText(task)),
        if (task.notes != null && task.notes!.isNotEmpty) ...[
          const SizedBox(height: 16),
          buildDetailItem(context, 'ملاحظات', task.notes!),
        ],
      ],
    ),
  );
}

Widget buildDetailItem(BuildContext context, String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      const SizedBox(height: 6),
      Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

String getTaskTypeName(String type) {
  switch (type) {
    case 'feeding':
      return 'موعد الطعام';
    case 'walking':
      return 'موعد المشي';
    case 'vet':
      return 'زيارة الطبيب البيطري';
    case 'medicine':
      return 'موعد الدواء';
    case 'bathing':
      return 'موعد الاستحمام';
    case 'shopping':
      return 'شراء الطعام';
    default:
      return 'مهمة';
  }
}

String getRepeatText(Task task) {
  switch (task.repeatType) {
    case 'daily':
      return 'يومياً';
    case 'weekly':
      return 'أسبوعياً';
    case 'monthly':
      return 'شهرياً';
    case 'custom':
      return 'كل ${task.customDays} أيام';
    default:
      return '';
  }
}
