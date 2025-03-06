// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pet_reminder/controllers/task_controller.dart';
// import 'package:pet_reminder/views/widgets/animated_task_card.dart';
// import 'package:intl/intl.dart';

// class CompletedTasksScreen extends StatelessWidget {
//   const CompletedTasksScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final TaskController controller = Get.find<TaskController>();
    
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('المهام المكتملة'),
//           centerTitle: true,
//           backgroundColor: Colors.white,
//           foregroundColor: Get.theme.primaryColor,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () => Get.back(),
//           ),
//           actions: [
//             Obx(() => controller.selectMode
//               ? IconButton(
//                   icon: const Icon(Icons.select_all),
//                   onPressed: () => controller.selectAllTasks(true),
//                 )
//               : IconButton(
//                   icon: const Icon(Icons.more_vert),
//                   onPressed: controller.toggleSelectMode,
//                 ),
//             ),
//           ],
//         ),
//         body: Container(
//           color: Get.theme.scaffoldBackgroundColor,
//           child: Container(
//             constraints: const BoxConstraints(maxWidth: 480),
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Obx(() {
//               if (controller.completedTasks.isEmpty) {
//                 return _buildEmptyState();
//               } else {
//                 return _buildTasksList(controller);
//               }
//             }),
//           ),
//         ),
//         floatingActionButton: Obx(() => controller.selectMode 
//           ? Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 FloatingActionButton(
//                   heroTag: 'delete',
//                   onPressed: () {
//                     Get.defaultDialog(
//                       title: 'تأكيد الحذف',
//                       middleText: 'هل أنت متأكد من رغبتك في حذف التذكيرات المحددة؟',
//                       textConfirm: 'حذف',
//                       textCancel: 'إلغاء',
//                       confirmTextColor: Colors.white,
//                       cancelTextColor: Colors.grey,
//                       buttonColor: Colors.red,
//                       onConfirm: () {
//                         controller.deleteSelectedTasks();
//                         Get.back();
//                         Get.snackbar(
//                           'تم بنجاح', 
//                           'تم حذف التذكيرات المحددة بنجاح!',
//                           snackPosition: SnackPosition.BOTTOM,
//                         );
//                       }
//                     );
//                   },
//                   backgroundColor: Colors.red,
//                   child: const Icon(Icons.delete),
//                 ),
//                 const SizedBox(width: 16),
//                 FloatingActionButton(
//                   heroTag: 'cancel',
//                   onPressed: controller.toggleSelectMode,
//                   backgroundColor: Colors.grey,
//                   child: const Icon(Icons.close),
//                 ),
//               ],
//             )
//           : null
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.task_alt,
//             size: 80,
//             color: Theme.of(Get.context).primaryColor.withOpacity(0.3),
//           ),
//           const SizedBox(height: 16),
//           const Text(
//             'لا توجد مهام مكتملة!',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             'عندما تكمل المهام ستظهر هنا',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTasksList(TaskController controller) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: controller.completedTasks.length,
//       itemBuilder: (context, index) {
//         final task = controller.completedTasks[index];
//         return Dismissible(
//           key: Key('task-${task.id}'),
//           direction: DismissDirection.endToStart,
//           background: Container(
//             alignment: Alignment.centerRight,
//             padding: const EdgeInsets.only(right: 20.0),
//             color: Colors.blue,
//             child: const Icon(
//               Icons.restore,
//               color: Colors.white,
//             ),
//           ),
//           onDismissed: (direction) {
//             controller.markTaskAsCompleted(task.id!, false);
//             Get.snackbar(
//               'تمت الاستعادة', 
//               'تم نقل المهمة إلى قائمة المهام النشطة',
//               snackPosition: SnackPosition.BOTTOM,
//               backgroundColor: Colors.blue.withOpacity(0.7),
//               colorText: Colors.white,
//             );
//           },
//           child: AnimatedTaskCard(
//             task: task,
//             index: index,
//             isSelected: controller.selectedTasks.contains(task),
//             selectMode: controller.selectMode,
//             onLongPress: () {
//               if (!controller.selectMode) {
//                 controller.toggleSelectMode();
//                 controller.toggleTaskSelection(task);
//               }
//             },
//             onTap: () {
//               if (controller.selectMode) {
//                 controller.toggleTaskSelection(task);
//               }
//             },
//           ),
//         );
//       },
//     );
//   }
// }
