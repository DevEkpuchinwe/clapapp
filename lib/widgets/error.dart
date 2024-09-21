import 'package:flutter/material.dart';

import '../navigation/routes.dart';

void main() => runApp(const ErrorScreen());

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: ('clap'),
      debugShowCheckedModeBanner: false,
      home: ErrorPage(),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('clap'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.dangerous_rounded,
              size: 80,
              color: Colors.red,
            ),
            const Text('An Unexpected Error Occurred.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('We Recomend you check your internet connection'),
            const Text('While we fix the issue'),
            const Spacer(),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                goToHomeScreen(context);
              },
              child: const Text('Back To Home'),
            ),
          ],
        ),
      ),
    );
  }
}