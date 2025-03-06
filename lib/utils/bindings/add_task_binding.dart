import 'package:get/get.dart';
import 'package:pet_reminder/controllers/add_task_controller.dart';

class AddTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddTaskController());
    
  }
}
