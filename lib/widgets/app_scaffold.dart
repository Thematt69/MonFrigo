import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_navigation_bar.dart';
import 'app_navigation_rail.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    required this.index,
  });

  final Widget body;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: kIsWeb
          ? null
          : AppNavigationBar(
              key: ValueKey(index),
              index: index,
            ),
      body: kIsWeb
          ? Row(
              children: [
                AppNavigationRail(
                  key: ValueKey(index),
                  index: index,
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: body,
                  ),
                ),
              ],
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: body,
              ),
            ),
    );
  }
}
