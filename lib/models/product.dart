import 'package:equatable/equatable.dart';

enum ProductUnit {
  unit('unité(s)'),
  gram('gr'),
  kilogram('kg'),
  liter('L'),
  centiliter('cL'),
  milliliter('mL');

  const ProductUnit(this.label);

  final String label;
}

class Product extends Equatable {
  const Product({
    required this.uuid,
    required this.name,
    required this.purchaseDate,
    required this.number,
    required this.quantity,
    required this.unit,
    required this.isMark,
    required this.expirationDuration,
    required this.notifExpireInTwoDays,
    required this.notifExpireToday,
    required this.notifExpiredOverWeek,
  });
  // Common
  final String uuid;
  final String name;
  final DateTime purchaseDate;
  final int number;
  final double quantity;
  final ProductUnit unit;

  // List
  final bool isMark;

  // Fridge

  // Expiration
  final Duration expirationDuration;
  DateTime get expirationDate => purchaseDate.add(expirationDuration);
  final bool notifExpireInTwoDays;
  final bool notifExpireToday;
  final bool notifExpiredOverWeek;

  Product copyWith({
    String? uuid,
    String? name,
    DateTime? purchaseDate,
    int? number,
    double? quantity,
    ProductUnit? unit,
    bool? isMark,
    Duration? expirationDuration,
    bool? notifExpireInTwoDays,
    bool? notifExpireToday,
    bool? notifExpiredOverWeek,
  }) {
    return Product(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      number: number ?? this.number,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      isMark: isMark ?? this.isMark,
      expirationDuration: expirationDuration ?? this.expirationDuration,
      notifExpireInTwoDays: notifExpireInTwoDays ?? this.notifExpireInTwoDays,
      notifExpireToday: notifExpireToday ?? this.notifExpireToday,
      notifExpiredOverWeek: notifExpiredOverWeek ?? this.notifExpiredOverWeek,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      uuid,
      name,
      purchaseDate,
      number,
      quantity,
      unit,
      isMark,
      expirationDuration,
      notifExpireInTwoDays,
      notifExpireToday,
      notifExpiredOverWeek,
    ];
  }
}
