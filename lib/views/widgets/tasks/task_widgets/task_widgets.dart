import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_reminder/controllers/task_controller.dart';
import 'package:pet_reminder/models/task_model.dart';

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

Widget buildLeadingSection(TaskController controller) {
  return Obx(() {
    return Row(
      children: [
        if (controller.selectMode) ...[
          buildSelectAllButton(controller),
        ] else ...[
          buildAppLogo(),
          const SizedBox(width: 12),
          buildAppTitle(),
        ],
      ],
    );
  });
}

Widget buildSelectAllButton(TaskController controller) {
  return Obx(() {
    return IconButton(
      icon: Icon(
        controller.selectedTaskIds.length == controller.tasks.length
            ? Icons.check_circle
            : Icons.circle_outlined,
        color: Get.theme.primaryColor,
      ),
      onPressed: () => controller.selectAllTasks(),
    );
  });
}

Widget buildAppLogo() {
  return Container(
    width: 30,
    height: 30,
    decoration: BoxDecoration(
      color: Get.theme.primaryColor.withOpacity(0.1),
      shape: BoxShape.circle,
    ),
    child: Icon(
      Icons.pets,
      color: Get.theme.primaryColor,
    ),
  );
}

Widget buildAppTitle() {
  return Flexible(
    child: Text(
      'Pet Reminder',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Get.theme.primaryColor,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    ),
  );
}

Widget buildDateSection(DateFormat dateFormat, DateTime now) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: Get.theme.primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      dateFormat.format(now),
      style: TextStyle(
        fontSize: 11,
        color: Get.theme.primaryColor,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    ),
  );
}
