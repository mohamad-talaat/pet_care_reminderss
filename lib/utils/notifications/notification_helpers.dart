import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:pet_reminder/models/task_model.dart';

class NotificationHelpers {
   static NotificationDetails getNotificationDetails() {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'pet_reminder_channel',
      'Pet Reminder Notifications',
      channelDescription: 'Notifications for pet care reminders',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
      playSound: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      enableLights: true,
      color: Color(0xFF6C63FF),
      ledColor: Color(0xFF6C63FF),
      ledOnMs: 1000,
      ledOffMs: 500,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'notification_sound.mp3',
    );

    return const NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
  }

  static String getTaskTitle(String taskType) {
    switch (taskType) {
      case 'feeding':
        return 'تذكير بموعد الطعام';
      case 'walking':
        return 'تذكير بموعد المشي';
      case 'vet':
        return 'تذكير بزيارة الطبيب البيطري';
      case 'medicine':
        return 'تذكير بموعد الدواء';
      case 'bathing':
        return 'تذكير بموعد الاستحمام';
      case 'shopping':
        return 'تذكير بشراء الطعام';
      default:
        return 'تذكير بمهمة';
    }
  }

  static String getTaskBody(Task task) {
    final timeFormat = DateFormat.jm('ar');
    return 'حان الآن موعد ${_getTaskTypeName(task.type)} (${timeFormat.format(task.date)})';
  }

  static String _getTaskTypeName(String type) {
    switch (type) {
      case 'feeding':
        return 'موعد الطعام';
      case 'walking':
        return 'موعد المشي';
      case 'vet':
        return 'زيارة الطبيب البيطري';
      case 'medicine':
        return 'موعد الدواء';
      case 'bathing':
        return 'موعد الاستحمام';
      case 'shopping':
        return 'شراء الطعام';
      default:
        return 'مهمة';
    }
  }
}
