import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_reminder/controllers/task_controller.dart';
import 'package:pet_reminder/views/screens/task_details_screen.dart';
import 'package:intl/intl.dart';
import 'package:pet_reminder/views/widgets/tasks/task_widgets/task_widgets.dart';

import 'task_widgets/get_task_color_Icon.dart';

class TaskList extends StatelessWidget {
  final TaskController controller;

  const TaskList({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.tasks.length,
      itemBuilder: (context, index) {
        final task = controller.tasks[index];
        return Obx(() {
          final isSelected = controller.selectedTaskIds.contains(task.id);
          final isSelectMode = controller.selectMode;

          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: isSelectMode
                        ? Icon(
                            isSelected ? Icons.check_circle : Icons.circle_outlined,
                            color: Get.theme.primaryColor,
                          )
                        : CircleAvatar(
                            backgroundColor: getTaskColor(task.type).withOpacity(0.2),
                            child: Icon(
                              getTaskIcon(task.type),
                              color: getTaskColor(task.type),
                              size: 20,
                            ),
                          ),
                    title: Text(
                      getTaskTypeName(task.type),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd('ar').add_jm().format(task.date),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    onTap: () {
                      if (isSelectMode) {
                        controller.toggleTaskSelection(task.id!);
                      } else {
                        controller.selectTask(task);
                        Get.to(() => const TaskDetailsScreen());
                      }
                    },
                    onLongPress: () {
                      if (!isSelectMode) {
                        controller.toggleSelectMode();
                        controller.toggleTaskSelection(task.id!);
                      }
                    },
                  ),
                ),
                Container(
                  width: 4,
                  color: Colors.red,
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
