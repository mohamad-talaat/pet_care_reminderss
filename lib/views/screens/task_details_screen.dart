import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_reminder/controllers/task_controller.dart';
import 'package:pet_reminder/models/task_model.dart';
import 'package:pet_reminder/views/screens/add_task_screen.dart';
import 'package:pet_reminder/views/widgets/common/custom_app_bar.dart';
import 'package:pet_reminder/views/widgets/common/custom_dialog.dart';

import '../widgets/tasks/task_widgets/task_details_widgets.dart';

class TaskDetailsScreen extends GetView<TaskController> {
  const TaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'تفاصيل التذكير',
      ),
      body: Obx(() {
        if (controller.selectedTask == null) {
          return const Center(
            child: Text('لا توجد تفاصيل متاحة'),
          );
        }

        final task = controller.selectedTask!;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTaskDetails(context, task),
              const SizedBox(height: 24),
              buildActionButtons(context, task),
            ],
          ),
        );
      }),
    );
  }

  Widget buildActionButtons(BuildContext context, Task task) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              Get.to(
                () => const AddTaskScreen(),
                arguments: task,
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text('تعديل'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Get.theme.primaryColor,
              side: BorderSide(color: Get.theme.primaryColor),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () async {
              final confirmed = await CustomDialog.showDeleteConfirmation(
                title: 'تأكيد الحذف',
                message: 'هل أنت متأكد من رغبتك في حذف هذا التذكير؟',
              );

              if (confirmed == true) {
                await controller.deleteTask(task.id!);
                Get.back();
                CustomDialog.showSuccessSnackbar(
                  title: 'تم بنجاح',
                  message: 'تم حذف التذكير بنجاح!',
                );
              }
            },
            icon: const Icon(Icons.delete),
            label: const Text('حذف'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
