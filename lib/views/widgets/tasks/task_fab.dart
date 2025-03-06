import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_reminder/controllers/add_task_controller.dart';
import 'package:pet_reminder/controllers/task_controller.dart';
import 'package:pet_reminder/views/screens/add_task_screen.dart';
import 'package:pet_reminder/views/widgets/common/custom_dialog.dart';

class TaskFAB extends StatelessWidget {
  final TaskController controller;

  const TaskFAB({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(AddTaskController());
    return Obx(
      () => controller.selectMode ? _buildDeleteButton() : _buildAddButton(),
    );
  }

  Widget _buildDeleteButton() {
    return FloatingActionButton(
      backgroundColor: Colors.red,
      onPressed: _handleDelete,
      child: const Icon(Icons.delete),
    );
  }

  Widget _buildAddButton() {
    return FloatingActionButton(
      onPressed: () => Get.to(() => const AddTaskScreen()),
      backgroundColor: Get.theme.primaryColor,
      child: const Icon(Icons.add),
    );
  }

  void _handleDelete() async {
    if (controller.selectedTaskIds.isEmpty) {
      controller.toggleSelectMode();
      return;
    }

    final confirmed = await CustomDialog.showDeleteConfirmation(
      title: 'تأكيد الحذف',
      message:
          'هل أنت متأكد من رغبتك في حذف ${controller.selectedTaskIds.length} تذكير؟',
    );

    if (confirmed == true) {
      await controller.deleteSelectedTasks();
      CustomDialog.showSuccessSnackbar(
        title: 'تم بنجاح',
        message: 'تم حذف التذكيرات بنجاح!',
      );
    }
  }
}
