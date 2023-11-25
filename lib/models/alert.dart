import 'package:equatable/equatable.dart';

class Alert extends Equatable {
  final String uuid;
  final String title;
  final String description;
  final DateTime dateTime;
  final bool isRead;

  const Alert({
    required this.uuid,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.isRead,
  });

  Alert copyWith({
    String? uuid,
    String? title,
    String? description,
    DateTime? dateTime,
    bool? isRead,
  }) {
    return Alert(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      uuid,
      title,
      description,
      dateTime,
      isRead,
    ];
  }
}
