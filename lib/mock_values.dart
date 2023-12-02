import 'dart:math';

import 'models/alert.dart';
import 'models/group.dart';

final groupsMock = [
  const Group(
    uuid: '23f1ace7-f985-44ae-a575-49fd9af50e1c',
    name: 'Les boloss',
    usersUuid: [
      'XL2kMULSzGdcz7Szaembf58hf2F3',
      'E8PcQIlN4oMGALFV6fuDrG2GZq22',
    ],
  ),
];

final alertsMock = [
  Alert(
    uuid: 'b32c3d7b-f46a-49c5-93ab-1d7b12bb2629',
    label: 'Il ne vous reste plus que 2 oeufs',
    dateTime: DateTime.parse('2023-11-06 20:43:10'),
    isRead: Random().nextBool(),
    expirationDate:
        DateTime.parse('2023-11-06 20:43:10').add(const Duration(days: 30)),
  ),
  Alert(
    uuid: '8b329d20-1403-48c0-b828-5bc884702bb8',
    label: 'Jambon va périmer dans deux jours',
    dateTime: DateTime.parse('2023-10-12 06:46:13'),
    isRead: Random().nextBool(),
    expirationDate:
        DateTime.parse('2023-10-12 06:46:13').add(const Duration(days: 30)),
  ),
  Alert(
    uuid: 'b8fdf9c9-3e33-4e11-a2ea-d5900cb7ff92',
    label: 'Crème fraiche va périmer dans deux jours',
    dateTime: DateTime.parse('2023-09-03 07:09:16'),
    isRead: Random().nextBool(),
    expirationDate:
        DateTime.parse('2023-09-03 07:09:16').add(const Duration(days: 30)),
  ),
  Alert(
    uuid: 'f7fb50db-d8d5-4096-926a-051f08d4d7ae',
    label: 'Crème fraiche a dépassé sa date de péremption',
    dateTime: DateTime.parse('2023-09-11 02:29:13'),
    isRead: Random().nextBool(),
    expirationDate:
        DateTime.parse('2023-09-11 02:29:13').add(const Duration(days: 30)),
  ),
  Alert(
    uuid: 'b20b2a8a-2500-49d3-b7c8-c22eadbfc8b8',
    label: "Confiture de lait est périmée depuis plus d'une semaine",
    dateTime: DateTime.parse('2023-09-18 16:24:33'),
    isRead: Random().nextBool(),
    expirationDate:
        DateTime.parse('2023-09-18 16:24:33').add(const Duration(days: 30)),
  ),
  Alert(
    uuid: '92a83862-7a49-4df8-8567-ff57f33d1c7a',
    label: 'Confiture de coing va périmer dans deux jours',
    dateTime: DateTime.parse('2023-10-11 05:47:35'),
    isRead: Random().nextBool(),
    expirationDate:
        DateTime.parse('2023-10-11 05:47:35').add(const Duration(days: 30)),
  ),
  Alert(
    uuid: '3bf445c1-247a-4d9e-9a46-136fb79442d5',
    label: 'Confiture de coing a dépassé sa date de péremption',
    dateTime: DateTime.parse('2023-09-19 10:09:11'),
    isRead: Random().nextBool(),
    expirationDate:
        DateTime.parse('2023-09-19 10:09:11').add(const Duration(days: 30)),
  ),
  Alert(
    uuid: '12819e90-d40c-4852-bb38-79036627d92e',
    label: "Confiture de coing est périmée depuis plus d'une semaine",
    dateTime: DateTime.parse('2023-09-15 20:24:42'),
    isRead: Random().nextBool(),
    expirationDate:
        DateTime.parse('2023-09-15 20:24:42').add(const Duration(days: 30)),
  ),
  Alert(
    uuid: '3d8c525d-880c-4c4b-8636-4d3a26b85c4d',
    label: 'Yaourt nature va périmer dans deux jours',
    dateTime: DateTime.parse('2023-11-07 15:05:15'),
    isRead: Random().nextBool(),
    expirationDate:
        DateTime.parse('2023-11-07 15:05:15').add(const Duration(days: 30)),
  ),
  Alert(
    uuid: '373d6722-d77d-4bf6-93c6-ecd9207d6dc0',
    label: 'Yaourt nature a dépassé sa date de péremption',
    dateTime: DateTime.parse('2023-10-01 12:45:35'),
    isRead: Random().nextBool(),
    expirationDate:
        DateTime.parse('2023-10-01 12:45:35').add(const Duration(days: 30)),
  ),
  Alert(
    uuid: '5867156c-7c11-4da7-ad89-6114c859bc1a',
    label: "Yaourt nature est périmée depuis plus d'une semaine",
    dateTime: DateTime.parse('2023-10-05 19:52:35'),
    isRead: Random().nextBool(),
    expirationDate:
        DateTime.parse('2023-10-05 19:52:35').add(const Duration(days: 30)),
  ),
];
