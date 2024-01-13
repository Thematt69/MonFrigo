import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class GenericProduct extends Equatable {
  static const collectionName = 'genericProducts';
  static const entryUid = 'uid';
  static const entryName = 'name';
  static const entryDescription = 'description';
  static const entryIcon = 'icon';

  final String uid;
  final String name;
  final String? description;
  final IconData icon;

  const GenericProduct({
    required this.uid,
    required this.name,
    required this.description,
    required this.icon,
  });

  factory GenericProduct.fromFirestore(Map<String, dynamic> json) {
    return GenericProduct(
      uid: json[entryUid] as String,
      name: json[entryName] as String,
      description: json[entryDescription] as String?,
      icon: json[entryIcon] is int
          ? IconData(json[entryIcon] as int, fontFamily: 'MaterialIcons')
          : Icons.category_outlined,
    );
  }

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      entryUid: uid,
      entryName: name,
      entryDescription: description,
      entryIcon: icon.codePoint,
    };
  }

  GenericProduct copyWith({
    String? uid,
    String? name,
    String? description,
    IconData? icon,
  }) {
    return GenericProduct(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [uid, name, description, icon];
}
