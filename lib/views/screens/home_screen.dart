
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_reminder/controllers/task_controller.dart';
import 'package:pet_reminder/views/widgets/common/empty_state.dart';
import 'package:pet_reminder/views/widgets/tasks/task_list.dart';
import 'package:pet_reminder/views/widgets/tasks/task_header.dart';
import 'package:pet_reminder/views/widgets/tasks/task_fab.dart';
 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController controller = Get.find<TaskController>();

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Get.theme.scaffoldBackgroundColor,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                TaskHeader(controller: controller),
                Expanded(
                  child: Obx(() {
                    if (controller.tasks.isEmpty) {
                      return const EmptyState(
                        icon: Icons.pets,
                        title: 'لا توجد تذكيرات للحيوانات الأليفة!',
                        subtitle: 'قم بإضافة تذكير جديد للبدء',
                      );
                    } else {
                      return TaskList(controller: controller);
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: TaskFAB(controller: controller),
    );
  }
}
 