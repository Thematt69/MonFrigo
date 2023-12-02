import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/alert.dart';

class AlertTile extends StatelessWidget {
  const AlertTile({
    super.key,
    required this.alert,
  });

  final Alert alert;

  static final _dateFormatter = DateFormat('dd MMM. yy');
  static final _timeFormatter = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(alert.label),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!alert.isRead) ...[
            const Badge(label: Text('Non-lu')),
          ],
          Text(_dateFormatter.format(alert.dateTime)),
          Text(_timeFormatter.format(alert.dateTime)),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
