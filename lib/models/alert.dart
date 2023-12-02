import 'package:equatable/equatable.dart';

class Alert extends Equatable {
  static const String tableName = 'alerts';

  final String uuid;
  final String label;
  final DateTime dateTime;
  final bool isRead;
  final DateTime expirationDate;

  const Alert({
    required this.uuid,
    required this.label,
    required this.dateTime,
    required this.isRead,
    required this.expirationDate,
  });

  Alert copyWith({
    String? uuid,
    String? title,
    DateTime? dateTime,
    bool? isRead,
    DateTime? expirationDate,
  }) {
    return Alert(
      uuid: uuid ?? this.uuid,
      label: title ?? label,
      dateTime: dateTime ?? this.dateTime,
      isRead: isRead ?? this.isRead,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      uuid,
      label,
      dateTime,
      isRead,
      expirationDate,
    ];
  }
}
