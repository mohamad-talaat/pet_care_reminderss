import 'package:get/get.dart';
import 'package:pet_reminder/controllers/add_task_controller.dart';
import 'package:pet_reminder/controllers/task_controller.dart';
 import 'package:pet_reminder/utils/notifications/notification_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
     final notificationService = NotificationService();
    notificationService.initNotification();
  Get.lazyPut(() => AddTaskController());
     Get.put(TaskController());
  }
}
