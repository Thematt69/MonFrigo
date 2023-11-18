import 'package:firebase_messaging/firebase_messaging.dart';

extension RemoteNotificationExtension on RemoteNotification {
  String displayString() => 'RemoteNotification(title: $title, body: $body)';
}
