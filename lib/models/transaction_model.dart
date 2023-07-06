import 'package:bolso_organizado/commons/extensions/extensions.dart';
import 'package:uuid/uuid.dart';

class TransactionModel {
  TransactionModel({
    required this.localization,
    required this.category,
    required this.description,
    required this.value,
    required this.date,
    required this.createdAt,
    this.id,
    this.userId,
  });

  final String localization;
  final String description;
  final String category;
  final double value;
  final int date;
  final int createdAt;
  final String? id;
  final String? userId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'localization': localization,
      'description': description,
      'category': category,
      'value': value,
      'date': DateTime.fromMillisecondsSinceEpoch(date).formatISOTime,
      'created_at':
          DateTime.fromMillisecondsSinceEpoch(createdAt).formatISOTime,
      'id': id ?? const Uuid().v4(),
      'user_id': userId,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      localization: map['localization'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      value: double.tryParse(map['value'].toString()) ?? 0,
      date: DateTime.parse(map['date'] as String).millisecondsSinceEpoch,
      createdAt:
          DateTime.parse(map['created_at'] as String).millisecondsSinceEpoch,
      id: map['id'] as String?,
      userId: map['user_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'localization': localization,
    'description': description,
    'category': category,
    'value': value,
    'date': DateTime.fromMillisecondsSinceEpoch(date).formatISOTime,
    'created_at':
    DateTime.fromMillisecondsSinceEpoch(createdAt).formatISOTime,
    'id': id ?? const Uuid().v4(),
    'user_id': userId,
  };

  TransactionModel.fromJson(String this.id, Map<String, dynamic> json)
      : localization = json['localization'],
        description = json['description'],
        category = json['category'],
        value = json['value'],
        date = DateTime.parse(json['date'].split(".").first).millisecondsSinceEpoch,
        createdAt = DateTime.parse(json['created_at'].split(".").first).millisecondsSinceEpoch,
        userId = json['user_id'];

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;

    return other.localization == localization &&
        other.description == description &&
        other.category == category &&
        other.value == value &&
        other.date == date &&
        other.id == id &&
        other.userId == userId &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return localization.hashCode ^
        description.hashCode ^
        category.hashCode ^
        value.hashCode ^
        date.hashCode ^
        createdAt.hashCode ^
        id.hashCode ^
        userId.hashCode;
  }

  TransactionModel copyWith({
    String? localization,
    String? description,
    String? category,
    double? value,
    int? date,
    bool? status,
    int? createdAt,
    String? id,
    String? userId,
  }) {
    return TransactionModel(
      localization: localization ?? this.localization,
      description: description ?? this.description,
      category: category ?? this.category,
      value: value ?? this.value,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id ?? const Uuid().v4(),
      userId: userId ?? this.userId,
    );
  }
}
