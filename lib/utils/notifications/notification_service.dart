import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pet_reminder/utils/notifications/notification_helpers.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:pet_reminder/models/task_model.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../views/screens/home_screen.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'pet_reminder_channel',
    'Pet Reminder Notifications',
    description: 'Notifications for pet care reminders',
    importance: Importance.max,
    playSound: true,
    enableVibration: true,
    enableLights: true,
  );

  Future<void> initNotification() async {
    requestPermissions();
    await _configureLocalTimeZone();
    await _setupNotifications();
    showInstantNotification();
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    try {
      tz.setLocalLocation(tz.local);
      debugPrint('Successfully set timezone to local: ${tz.local.name}');
    } catch (e) {
      debugPrint('Error setting local timezone: $e');
      _setFallbackTimezone();
    }
  }

  void _setFallbackTimezone() {
    try {
      if (Intl.defaultLocale?.startsWith('ar_EG') == true) {
        tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
        debugPrint('Fallback to Cairo timezone');
      } else {
        tz.setLocalLocation(tz.UTC);
        debugPrint('Fallback to UTC timezone');
      }
    } catch (e) {
      debugPrint('Error setting fallback timezone: $e');
      tz.setLocalLocation(tz.UTC);
    }
  }

  Future<void> _setupNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Notification clicked: ${response.payload}');
    Get.to(const HomeScreen());
  }
  Future<void> requestPermissions() async {
    if (!await Permission.notification.isGranted) {
      await Permission.notification.request();
    }

    if (!await Permission.scheduleExactAlarm.isGranted) {
      await Permission.scheduleExactAlarm.request();
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
  }

  // Future<void> requestPermissions() async {
  //   // إذن الإشعارات
  //   var notificationStatus = await Permission.notification.status;
  //   debugPrint('Notification permission status: $notificationStatus');
  //
  //   if (await Permission.notification.isDenied) {
  //     await Permission.notification.request();
  //   }
  //
  //   // إذن iOS
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           IOSFlutterLocalNotificationsPlugin>()
  //       ?.requestPermissions(
  //         alert: true,
  //         badge: true,
  //         sound: true,
  //       );
  //
  //   // إذن المنبهات الدقيقة
  //   var alarmStatus = await Permission.scheduleExactAlarm.status;
  //   debugPrint('Exact alarm permission status: $alarmStatus');
  //
  //   if (await Permission.scheduleExactAlarm.isDenied) {
  //     await Permission.scheduleExactAlarm.request();
  //   }
  //
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.requestExactAlarmsPermission();
  // }

  /// إرسال notif. فوري للاختبار
  Future<void> showInstantNotification() async {
    final notificationDetails = NotificationHelpers.getNotificationDetails();

    await flutterLocalNotificationsPlugin.show(
      0,
      'تم تفعيل الإشعارات',
      'سيتم تذكيرك بمواعيد الحيوانات الأليفة في الوقت المحدد',
      notificationDetails,
    );

    debugPrint('Instant notification sent');
  }

  Future<void> scheduleNotification(Task task) async {
    try {
      final notificationDetails = NotificationHelpers.getNotificationDetails();
      final scheduledTime = _nextValidTime(task.date);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!,
        NotificationHelpers.getTaskTitle(task.type),
        NotificationHelpers.getTaskBody(task),
        scheduledTime,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: _getDateTimeComponents(task.repeatType),
      );

      debugPrint('Notification scheduled for ${task.id} at $scheduledTime');
    } catch (e, stacktrace) {
      debugPrint('Error scheduling notification: $e');
      debugPrint(stacktrace.toString());
    }
  }

  tz.TZDateTime _nextValidTime(DateTime dateTime) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(dateTime, tz.local);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }


  DateTimeComponents? _getDateTimeComponents(String repeatType) {
    switch (repeatType) {
      case 'daily':
        return DateTimeComponents.time;
      case 'weekly':
        return DateTimeComponents.dayOfWeekAndTime;
      case 'monthly':
        return DateTimeComponents.dayOfMonthAndTime;
      default:
        return null;
    }
  }

  Future<void> _scheduleNextOccurrence(Task task) async {
    final nextTask = _createNextTask(task);
    await scheduleNotification(nextTask);
  }

  Task _createNextTask(Task task) {
    DateTime nextDate = task.date;

    switch (task.repeatType) {
      case 'daily':
        nextDate = nextDate.add(const Duration(days: 1));
        break;
      case 'weekly':
        nextDate = nextDate.add(const Duration(days: 7));
        break;
      case 'monthly':
        nextDate = DateTime(
          nextDate.year,
          nextDate.month + 1,
          nextDate.day,
          nextDate.hour,
          nextDate.minute,
        );
        break;
      case 'custom':
        nextDate = nextDate.add(Duration(days: task.customDays));
        break;
    }

    return task.copyWith(date: nextDate);
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
