import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_reminder/controllers/add_task_controller.dart';
import 'package:pet_reminder/views/widgets/common/custom_app_bar.dart';
import 'package:pet_reminder/views/widgets/tasks/task_form_fields.dart';

class AddTaskScreen extends GetView<AddTaskController> {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title:
            controller.isEditMode.value ? 'تعديل التذكير' : 'إضافة تذكير جديد',
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Obx(() => TaskFormFields(
                  taskType: controller.taskType.value,
                  taskDate: controller.taskDate.value,
                  repeatType: controller.repeatType.value,
                  customDays: controller.customDays.value,
                  notesController: controller.notesController,
                  onTaskTypeChanged: controller.onTaskTypeChanged,
                  onDateChanged: controller.onDateChanged,
                  onRepeatTypeChanged: controller.onRepeatTypeChanged,
                  onCustomDaysChanged: controller.onCustomDaysChanged,
                  showCustomDays: controller.showCustomDays.value,
                )),
            const SizedBox(height: 24),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: controller.saveTask,
      style: ElevatedButton.styleFrom(
        backgroundColor: Get.theme.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        'حفظ التذكير',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
