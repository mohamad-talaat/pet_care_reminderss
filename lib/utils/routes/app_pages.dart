import 'package:get/get.dart';
import 'package:pet_reminder/utils/bindings/add_task_binding.dart';
import 'package:pet_reminder/views/screens/add_task_screen.dart';
import 'package:pet_reminder/views/screens/home_screen.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/home',
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: '/add-task',
      page: () => const AddTaskScreen(),
      binding: AddTaskBinding(),
    ),
  ];
}
