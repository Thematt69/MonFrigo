import 'package:equatable/equatable.dart';

class Group extends Equatable {
  static const String tableName = 'groups';

  final String uuid;
  final String name;
  final List<String> usersUuid;

  const Group({
    required this.uuid,
    required this.name,
    required this.usersUuid,
  });

  String get codeShare => uuid.substring(0, uuid.indexOf('-'));

  Group copyWith({
    String? uuid,
    String? name,
    List<String>? usersUuid,
  }) {
    return Group(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      usersUuid: usersUuid ?? this.usersUuid,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [uuid, name, usersUuid];
}
