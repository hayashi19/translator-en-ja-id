import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator_en_jp_id/history/history_page.dart';
import 'package:translator_en_jp_id/settings/settings_page.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.greenAccent.shade700,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.person_rounded,
                    size: 104,
                  ),
                  Text("hayashi19"),
                ],
              ),
            ),
            TextButton(
              onPressed: () => Get.to(const HistoryPage()),
              style: const ButtonStyle(alignment: Alignment.centerLeft),
              child: const Text("History"),
            ),
            TextButton(
              onPressed: () => Get.to(const SettingsPage()),
              style: const ButtonStyle(alignment: Alignment.centerLeft),
              child: const Text("Settings"),
            ),
            const Divider(height: 16, thickness: 4),
            TextButton(
              onPressed: () => debugPrint("Share"),
              style: const ButtonStyle(alignment: Alignment.centerLeft),
              child: const Text("Share"),
            ),
            TextButton(
              onPressed: () => debugPrint("Rate This App"),
              style: const ButtonStyle(alignment: Alignment.centerLeft),
              child: const Text("Rate This App"),
            ),
            TextButton(
              onPressed: () => debugPrint("Privacy Policy"),
              style: const ButtonStyle(alignment: Alignment.centerLeft),
              child: const Text("Privacy Policy"),
            ),
          ],
        ),
      ),
    );
  }
}
