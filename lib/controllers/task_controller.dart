import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_reminder/models/task_model.dart';
import 'package:pet_reminder/utils/database_helper.dart';
import 'package:pet_reminder/utils/notifications/notification_service.dart';
 
class TaskController extends GetxController {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final NotificationService _notificationService = NotificationService();

  final RxList<Task> _tasks = <Task>[].obs;
  final Rxn<Task> _selectedTask = Rxn<Task>();
  final RxList<int> _selectedTaskIds = <int>[].obs;
  final RxBool _selectMode = false.obs;

  List<Task> get tasks => _tasks;
  Task? get selectedTask => _selectedTask.value;
  List<int> get selectedTaskIds => _selectedTaskIds;
  bool get selectMode => _selectMode.value;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  Future<void> loadTasks() async {
    _tasks.value = await _databaseHelper.getTasks();
    _tasks.value.sort((a, b) => a.date.compareTo(b.date));
  }

  Future<void> addTask(Task task) async {
    try {
      final id = await _databaseHelper.insertTask(task);
      final newTask = task.copyWith(id: id);
      _tasks.add(newTask);

       _tasks.value.sort((a, b) => a.date.compareTo(b.date));

       await _notificationService.scheduleNotification(newTask);

      debugPrint('Task added with ID: $id');
      return Future.value();
    } catch (e) {
      debugPrint('Error adding task: $e');
      return Future.error(e);
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _databaseHelper.updateTask(task);

      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
        // Sort tasks by date
        _tasks.value.sort((a, b) => a.date.compareTo(b.date));
      }

       await _notificationService.cancelNotification(task.id!);
      await _notificationService.scheduleNotification(task);

      return Future.value();
    } catch (e) {
      debugPrint('Error updating task: $e');
      return Future.error(e);
    }
  }

  Future<void> deleteTask(int id) async {
    await _databaseHelper.deleteTask(id);

    _tasks.removeWhere((task) => task.id == id);

     await _notificationService.cancelNotification(id);
  }

  void selectTask(Task task) {
    _selectedTask.value = task;
  }

  void clearSelectedTask() {
    _selectedTask.value = null;
  }

  void toggleSelectMode() {
    _selectMode.value = !_selectMode.value;
    if (!_selectMode.value) {
      _selectedTaskIds.clear();
    }
  }

  void toggleTaskSelection(int taskId) {
    if (_selectedTaskIds.contains(taskId)) {
      _selectedTaskIds.remove(taskId);
    } else {
      _selectedTaskIds.add(taskId);
    }


    if (_selectedTaskIds.isEmpty && _selectMode.value) {
      toggleSelectMode();
    }
  }

  void selectAllTasks() {
    if (_selectedTaskIds.length == tasks.length) {
       _selectedTaskIds.clear();
    } else {
       _selectedTaskIds.clear();
      for (var task in tasks) {
        _selectedTaskIds.add(task.id!);
      }
    }
  }

  Future<void> deleteSelectedTasks() async {
    for (var id in _selectedTaskIds) {
      await deleteTask(id);
    }
    _selectedTaskIds.clear();
    toggleSelectMode();
  }

  Future<void> testNotifications() async {
     await _notificationService.showInstantNotification();

     final testTask = Task(
      id: 9999,
      type: 'feeding',
      date: DateTime.now().add(const Duration(seconds: 15)),
      repeatType: 'once',
    );

    await _notificationService.scheduleNotification(testTask);

    Get.snackbar(
      'اختبار الإشعارات',
      'تم إرسال إشعار فوري وإشعار آخر سيظهر بعد 15 ثانية',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue.withOpacity(0.7),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}
