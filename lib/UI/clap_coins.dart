import 'package:clapapp/UI/coins.dart/lucky_box.dart';
import 'package:flutter/material.dart';


void main() => runApp(const CoinsScreen());

class CoinsScreen extends StatelessWidget {
  const CoinsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: ('clap'),
      debugShowCheckedModeBanner: false,
      home: CoinsPage(),
    );
  }
}

class CoinsPage extends StatelessWidget {
  const CoinsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('clap'),
      ),
      body: const LuckyBox(), //const Center(
        //child: Column(
         // mainAxisAlignment: MainAxisAlignment.center,
         // children: [
         //  LuckyBox(),
         // ],
      //  ),
     // ),
    );
  }
}