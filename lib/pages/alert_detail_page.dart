import 'package:flutter/material.dart';

import '../extension/build_context.dart';
import '../widgets/app_scaffold.dart';

class AlertDetailPage extends StatelessWidget {
  const AlertDetailPage({
    super.key,
    required this.uuid,
  });

  final String uuid;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      index: 2,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            uuid,
            style: context.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
