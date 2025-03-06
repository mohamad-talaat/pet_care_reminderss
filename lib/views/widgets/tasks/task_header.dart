import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:pet_reminder/controllers/task_controller.dart';
import 'package:pet_reminder/views/widgets/tasks/task_widgets/task_widgets.dart';
 
class TaskHeader extends StatelessWidget {
  final TaskController controller;

  const TaskHeader({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateFormat = DateFormat.yMMMMEEEEd('ar');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: buildLeadingSection(controller),
          ),
          Flexible(
            child: buildDateSection(dateFormat, now),
          ),
          buildSelectAllButton(controller),
        ],
      ),
    );
  }

  Widget buildSelectAllButton(TaskController controller) {
    return Obx(() {
       if (controller.selectMode) {
        return IconButton(
          icon: Icon(
            controller.selectedTaskIds.length == controller.tasks.length
                ? Icons.check_circle
                : Icons.circle_outlined,
            color: Get.theme.primaryColor,
            size: 22,
          ),
          onPressed: () => controller.selectAllTasks(),
          tooltip: 'تحديد الكل',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(
            minWidth: 36,
            minHeight: 36,
          ),
        );
      } else {
         return IconButton( 
          icon: const Icon(Icons.select_all, size: 22),
          onPressed: () => controller.toggleSelectMode(),
          tooltip: 'تحديد المهام',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(
            minWidth: 36,
            minHeight: 36,
          ),
        );
      }
    });
  }
}
