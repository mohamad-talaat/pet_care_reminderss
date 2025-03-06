import 'package:flutter/material.dart';
import 'package:pet_reminder/models/task_model.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:pet_reminder/views/widgets/tasks/task_widgets/get_task_color_Icon.dart';
import 'package:pet_reminder/views/widgets/tasks/task_widgets/task_widgets.dart';
class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final bool selectMode;
  final bool isSelected;
  final VoidCallback? onSelect;
  final VoidCallback? onDismiss;
  
  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    this.selectMode = false,
    this.isSelected = false,
    this.onSelect,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('task-dismissible-${task.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        if (onDismiss != null) {
          onDismiss!();
        }
      },
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('تأكيد الحذف'),
              content: const Text('هل أنت متأكد من رغبتك في حذف هذا التذكير؟'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('إلغاء'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('حذف', style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        );
      },
      child: GestureDetector(
        onTap: selectMode ? (onSelect ?? () {}) : onTap,
        child: Hero(
          tag: 'task-${task.id}',
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border(
                  right: BorderSide(
                    width: 4,
                    color: getTaskColor(task.type),
                  ),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (selectMode) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        isSelected 
                            ? Icons.check_circle 
                            : Icons.circle_outlined,
                        color: isSelected 
                            ? Get.theme.primaryColor 
                            : Colors.grey,
                      ),
                    ),
                  ],
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: getTaskColor(task.type).withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                     getTaskIcon(task.type),
                                    size: 16,
                                    color:  getTaskColor(task.type),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                   getTaskTypeName(task.type),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              DateFormat.jm('ar').format(task.date),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${DateFormat.yMMMd('ar').format(task.date)} - ${ getRepeatText(task)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}