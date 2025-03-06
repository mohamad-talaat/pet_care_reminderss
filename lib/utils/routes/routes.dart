import 'package:get/get.dart';
import 'package:pet_reminder/views/screens/home_screen.dart';
import 'package:pet_reminder/views/screens/add_task_screen.dart';
import 'package:pet_reminder/views/screens/task_details_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const HomeScreen()),
    GetPage(name: '/add_task', page: () => const AddTaskScreen()),
    GetPage(name: '/task_details', page: () => const TaskDetailsScreen()),
  ];
}
