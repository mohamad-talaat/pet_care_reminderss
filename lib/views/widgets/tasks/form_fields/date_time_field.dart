import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimeField extends StatelessWidget {
  final DateTime taskDate;
  final Function(DateTime) onDateChanged;

  const DateTimeField({
    super.key,
    required this.taskDate,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showCupertinoDateTimePicker(context),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'التاريخ والوقت',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDateTime(taskDate),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.calendar_today,
              color: Get.theme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final dateFormat = DateFormat.yMMMMd('ar');
    final timeFormat = DateFormat.jm('ar');
    return '${dateFormat.format(dateTime)} - ${timeFormat.format(dateTime)}';
  }

  void _showCupertinoDateTimePicker(BuildContext context) {
    DateTime selectedDateTime = taskDate;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            children: [
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'اختر التاريخ والوقت',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CupertinoButton(
                      child: Text(
                        'تم',
                        style: TextStyle(
                          color: Get.theme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onDateChanged(selectedDateTime);
                      },
                    ),
                  ],
                ),
              ),
               Expanded(
                child: CupertinoTheme(
                  data: const CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        fontFamily: 'Cairo', // Arabic compatible font
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: taskDate.isBefore(DateTime.now()) ? DateTime.now() : taskDate,

                    minimumDate: DateTime.now(),
                    maximumDate: DateTime.now().add(const Duration(days: 365)),
                    minuteInterval: 1,
                    use24hFormat: false,
                    backgroundColor: Colors.white,
                    onDateTimeChanged: (DateTime newDateTime) {
                      selectedDateTime = newDateTime;
                    },
                  ),

                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
