import 'package:clapapp/UI/comingsoon.dart';
import 'package:flutter/material.dart';

void main() => runApp(const SettingScreen());

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: ('clap'),
      debugShowCheckedModeBanner: false,
      home: SettingPage(),
    );
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ComingScreen(),
    );
  }
}