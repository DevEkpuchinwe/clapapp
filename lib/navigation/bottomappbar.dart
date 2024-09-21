import 'package:clapapp/UI/coins.dart/coins_board.dart';
import 'package:clapapp/UI/comingsoon.dart';
import 'package:flutter/material.dart';
import 'package:clapapp/UI/homepage.dart';

import '../UI/userprofile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 2;

  final List<Widget> pages = [
    const DashboardScreen(),
    const ComingScreen(),
    const Home(),
    const ComingScreen(),
    const ProfileScree()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            tabItem(Icons.rocket_launch, "Coins", 0),
            tabItem(Icons.credit_card, "Wallet", 1),
            FloatingActionButton(
              onPressed: () => onTabTapped(2),
              backgroundColor:
                  Colors.deepOrangeAccent, //fromARGB(255, 16, 80, 98),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: const Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
              ),
            ),
            tabItem(Icons.bar_chart, "Payment", 3),
            tabItem(Icons.person, "Profile", 4),
          ],
        ),
      ),
    );
  }

  Widget tabItem(IconData icon, String label, int index) {
    return IconButton(
      onPressed: () => onTabTapped(index),
      icon: Column(
        children: [
          Icon(
            icon,
            color:
                currentIndex == index ? Colors.deepOrangeAccent : Colors.black,
          ),
          Text(
            label,
            style: TextStyle(
                fontSize: 10,
                color: currentIndex == index
                    ? Theme.of(context).primaryColor
                    : Colors.black),
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
