import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_reminder/controllers/task_controller.dart';
import 'package:pet_reminder/models/task_model.dart';
import 'package:pet_reminder/views/widgets/common/custom_dialog.dart';
import 'package:pet_reminder/views/screens/home_screen.dart';

class AddTaskController extends GetxController {
  final TaskController taskController = Get.find<TaskController>();
  final formKey = GlobalKey<FormState>();

  final RxString taskType = 'feeding'.obs;
  final Rx<DateTime> taskDate =
      DateTime.now().add(const Duration(minutes: 1)).obs;
  final RxString repeatType = 'daily'.obs;
  final RxInt customDays = 1.obs;
  final notesController = TextEditingController();

  final RxBool showCustomDays = false.obs;
  final RxBool isEditMode = false.obs;

  Task? taskToEdit;

  @override
  void onInit() {
    super.onInit();
    taskToEdit = Get.arguments as Task?;
    _initializeValues();
  }

  void _initializeValues() {
    if (taskToEdit != null) {
      isEditMode.value = true;
      taskType.value = taskToEdit!.type;
      taskDate.value = taskToEdit!.date;
      repeatType.value = taskToEdit!.repeatType;
      customDays.value = taskToEdit!.customDays;
      notesController.text = taskToEdit!.notes ?? '';
      showCustomDays.value = taskToEdit!.repeatType == 'custom';
    }
  }

  void onTaskTypeChanged(String? value) {
    if (value != null) {
      taskType.value = value;
    }
  }

  void onDateChanged(DateTime value) {
    taskDate.value = value;
  }

  void onRepeatTypeChanged(String? value) {
    if (value != null) {
      repeatType.value = value;
      showCustomDays.value = value == 'custom';
    }
  }

  void onCustomDaysChanged(String value) {
    if (value.isNotEmpty) {
      customDays.value = int.parse(value);
    }
  }

  Future<void> saveTask() async {
    if (!formKey.currentState!.validate()) return;

    try {
      if (isEditMode.value) {
        await _updateTask();
      } else {
        await _addTask();
      }
    } catch (e) {
      CustomDialog.showSuccessSnackbar(
        title: 'خطأ',
        message: 'حدث خطأ أثناء حفظ التذكير',
      );
    }
  }

  Future<void> _updateTask() async {
    final updatedTask = taskToEdit!.copyWith(
      type: taskType.value,
      date: taskDate.value,
      repeatType: repeatType.value,
      customDays: customDays.value,
      notes: notesController.text.isEmpty ? null : notesController.text,
    );
    notesController.dispose;
    notesController.clear();
    await taskController.updateTask(updatedTask);
    Get.back();
    CustomDialog.showSuccessSnackbar(
      title: 'تم بنجاح',
      message: 'تم تحديث التذكير بنجاح!',
    );
  }

  Future<void> _addTask() async {
    final task = Task(
      type: taskType.value,
      date: taskDate.value,
      repeatType: repeatType.value,
      customDays: customDays.value,
      notes: notesController.text.isEmpty ? null : notesController.text,
    );

    await taskController.addTask(task);
    Get.offAll(() => const HomeScreen());
    CustomDialog.showSuccessSnackbar(
      title: 'تم بنجاح',
      message: 'تم حفظ التذكير بنجاح!',
    );
  }

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }
}
