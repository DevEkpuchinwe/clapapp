import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../navigation/routes.dart';
import '../Backend/api.dart';
// ignore: library_prefixes
import '../Backend/api.dart' as User;

void main() => runApp(const WalletScreen());

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CLAP',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const WalletScreen(),
    );
  }

  @override
  WalletScreenState createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen> {
  final UserService _userService = UserService();
  StreamSubscription<User.User>? _userSubscription;
  String _username = "Esteem User";
  double _balance = 00.00;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
    _initializeUserStream();
  }

  void _initializeUserStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userSubscription = _userService.getUserStream(uid).listen((userData) {
        setState(() {
          _username = userData.username;
          _balance = userData.balance;
        });
      }, onError: (error) {
        setState(() {
          _username = "Esteem User";
          _balance = 00.00;
        });
      });
    }
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      //appBar: AppBar(
       // title: const Text('clap'),
      //),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(2.0),
            height: 200.0,
            width: 600.0,
            child: Card(
              color: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(_username),
                      const Text('Total Balance',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 20.0,
                          )),
                      Text(
                        'NGN $_balance',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                    ],
                  ),
                  Row(children: <Widget>[
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Card(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.add_circle_outline_rounded,
                              color: Colors.deepOrangeAccent,
                              size: 25,
                            ),
                            onPressed: () {
                              goToFundScreen(context);
                            },
                            label: const Text(
                              'FUND    .',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Card(
                          color: Colors.orange[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.send_rounded,
                              color: Colors.deepOrange,
                              size: 25,
                            ),
                            onPressed: () {
                              goToTransferScreen(context);
                            },
                            label: const Text(
                              'TRANSFER',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          )),
                    ),
                  ]),
                ],
              ),
            ),
          ),
          //const RewardButton(),
        ],
      ),
    ));
  }
}