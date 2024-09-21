import 'package:flutter/material.dart';

import '../navigation/routes.dart';

void main() => runApp(const TransferScreen());

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: ('clap'),
      debugShowCheckedModeBanner: false,
      home: TransferPage(),
    );
  }
}

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});
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
            const Text('Coming Soon.We are fixing this feature',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('Stay Tune for updates'),
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