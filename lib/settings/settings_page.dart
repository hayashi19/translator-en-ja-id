import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: const Column(
        children: <Widget>[
          ChangeLangButton(),
          ChangeFontSize(),
          ChangeFontFamily()
        ],
      ),
    );
  }
}

class ChangeLangButton extends StatelessWidget {
  const ChangeLangButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ChangeFontSize extends StatelessWidget {
  const ChangeFontSize({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ChangeFontFamily extends StatelessWidget {
  const ChangeFontFamily({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
