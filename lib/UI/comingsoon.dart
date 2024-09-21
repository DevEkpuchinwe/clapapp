import 'package:flutter/material.dart';

import '../navigation/routes.dart';

void main() => runApp(const ComingScreen());

class ComingScreen extends StatelessWidget {
  const ComingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: ('clap'),
      debugShowCheckedModeBanner: false,
      home: ComingPage(),
    );
  }
}

class ComingPage extends StatelessWidget {
  const ComingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: const Text('clap'),
      //),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.work,
                size: 80,
                color: Colors.deepOrangeAccent,
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
                  goToMainScreen(context);
                },
                child: const Text('Back To Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}