import 'package:flutter/material.dart';
import 'package:mon_frigo/pages/profile/group_section.dart';
import 'package:mon_frigo/pages/profile/setting_section.dart';
import 'package:mon_frigo/widgets/app_scaffold.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      index: 3,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GroupSection(),
            SizedBox(height: 16),
            SettingSection(),
          ],
        ),
      ),
    );
  }
}
