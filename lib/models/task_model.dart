class Task {
  int? id;
  String type;
  DateTime date;
  String repeatType;
  int customDays;
  String? notes;
  DateTime createdAt;

  Task({
    this.id,
    required this.type,
    required this.date,
    required this.repeatType,
    this.customDays = 1,
    this.notes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'date': date.toIso8601String(),
      'repeatType': repeatType,
      'customDays': customDays,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      type: map['type'],
      date: DateTime.parse(map['date']),
      repeatType: map['repeatType'],
      customDays: map['customDays'],
      notes: map['notes'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Task copyWith({
    int? id,
    String? type,
    DateTime? date,
    String? repeatType,
    int? customDays,
    String? notes,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      type: type ?? this.type,
      date: date ?? this.date,
      repeatType: repeatType ?? this.repeatType,
      customDays: customDays ?? this.customDays,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

 