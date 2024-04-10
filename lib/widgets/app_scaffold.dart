import 'package:flutter/material.dart';

import 'package:mon_frigo/extension/build_context.dart';
import 'package:mon_frigo/widgets/app_navigation_bar.dart';
import 'package:mon_frigo/widgets/app_navigation_rail.dart';

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
      bottomNavigationBar: context.isOnRatioDesktop
          ? null
          : AppNavigationBar(
              key: ValueKey(index),
              index: index,
            ),
      body: context.isOnRatioDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppNavigationRail(
                  key: ValueKey(index),
                  index: index,
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: body,
                ),
              ],
            )
          : SafeArea(
              child: body,
            ),
    );
  }
}
