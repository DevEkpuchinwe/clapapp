import 'dart:async';
import 'package:clapapp/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../Backend/userdata.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _freeCoinsAvailable = false;
  String? _errorMessage;
  Timer? _messageTimer;
  bool _isLoadingExchangeRates = true;

  @override
  void initState() {
    super.initState();
    _checkFreeCoinsAvailability();
    _showLoadingState();
  }

  Future<void> _showLoadingState() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoadingExchangeRates = false;
    });
  }

  Future<void> _checkFreeCoinsAvailability() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        _errorMessage = 'User not logged in';
      });
      return;
    }

    final userData = context.read<UserDataProvider>().userData;
    final lastClaimDate = (userData['lastClaimDate'] as Timestamp?)?.toDate();
    final currentTime = DateTime.now();

    if (lastClaimDate != null) {
      final difference = currentTime.difference(lastClaimDate);
      if (difference.inHours < 12) {
        setState(() {
          _freeCoinsAvailable = false;
          _errorMessage = 'You have already claimed your free coins today';
          _startMessageTimer();
        });
        return;
      }
    }

    setState(() {
      _freeCoinsAvailable = true;
      _errorMessage = null;
    });
  }

Future<void> _claimFreeCoins() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  // Retrieve the dynamic freeCoinAmount from the UserDataProvider
  final freeCoinAmount = context.read<UserDataProvider>().freeCoinAmount;
  
  final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);

  await userDoc.update({
    'coins': FieldValue.increment(freeCoinAmount), // Use the dynamic freeCoinAmount
    'freecoins': true,
    'lastClaimDate': FieldValue.serverTimestamp(), // Save the current timestamp
  });

  final updatedUserData = (await userDoc.get()).data()!;
  context.read<UserDataProvider>().setUserData(updatedUserData);
  
  setState(() {
    _freeCoinsAvailable = false;
    _errorMessage = 'You have claimed your free $freeCoinAmount Clap Coins today';
  });

  _startMessageTimer();
}

  Future<void> _convertCoinsToCash() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final userData = context.read<UserDataProvider>().userData;
    final coins = userData['coins'] as int;
    final nairaExchangeRate =
        context.read<UserDataProvider>().nairaExchangeRate;
    final coinExchangeRate = context.read<UserDataProvider>().coinExchangeRate;

    if (coins < coinExchangeRate) {
      setState(() {
        _errorMessage =
            'You need at least ${coinExchangeRate.toStringAsFixed(0)}  coins to convert.';
      });
      //_startMessageTimer();
      //return;
    }

    final roundedCoins = (coins ~/ coinExchangeRate);
    final remainingCoins = coins - roundedCoins * coinExchangeRate;
    final convertedAmount = roundedCoins * nairaExchangeRate;
    final value = roundedCoins * coinExchangeRate;

    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    await userDoc.update({
      'coins': remainingCoins,
      'balance': FieldValue.increment(convertedAmount),
    });

    final updatedUserData = (await userDoc.get()).data()!;
    // ignore: use_build_context_synchronously
    context.read<UserDataProvider>().setUserData(updatedUserData);

    setState(() {
      _errorMessage =
          'Successfully converted $value coins to ₦$convertedAmount';
    });
    _startMessageTimer();
  }

  void _startMessageTimer() {
    _messageTimer?.cancel();
    _messageTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _errorMessage = null;
      });
    });
  }

  @override
  void dispose() {
    _messageTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserDataProvider>().userData;

    final coins = userData['coins'] is Map
        ? userData['coins']['balance'].toStringAsFixed(2)
        : double.tryParse(userData['coins'].toString())?.toStringAsFixed(0) ??
            '0.00';

    final coinExchangeRate = context.watch<UserDataProvider>().coinExchangeRate;
    final nairaExchangeRate =
        context.watch<UserDataProvider>().nairaExchangeRate;

    final formattedCoinExchangeRate = coinExchangeRate.toStringAsFixed(0);
    final formattedNairaExchangeRate = nairaExchangeRate.toStringAsFixed(0);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CLAP COINS'),
          automaticallyImplyLeading: false, // Remove back arrow
        ),
        body: Column(
          children: [
            const SizedBox(height: 5),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: const BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 90,
                          height: 90,
                          margin: const EdgeInsets.only(left: 16.0, top: 8.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.deepOrangeAccent,
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/images/coins-logo.png', // Replace with your asset path
                              fit: BoxFit.cover,
                              width: 90,
                              height: 90,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 50),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$coins',
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    '♛ MASTER',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    'CLAP COINS',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: ElevatedButton.icon(
                      onPressed: _convertCoinsToCash,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.deepOrangeAccent,
                        backgroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.currency_exchange),
                      label: const Text(
                        'Convert to Cash',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Card(
                color: Colors.white,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.black54),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _isLoadingExchangeRates
                            ? const Text(
                                'Loading exchange rates...',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(
                                'Exchange rate: $formattedCoinExchangeRate Clap Coin = ₦$formattedNairaExchangeRate',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'TASKS',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed:
                                  _freeCoinsAvailable ? _claimFreeCoins : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrangeAccent,
                              ),
                              child: const Text(
                                'Claim Free Coins',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add your action here for Task 1
                                goToLuckyBoxScreen(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrangeAccent,
                              ),
                              child: const Text(
                                'Lucky Box',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add your action here for Task 2
                                goToComingSoonScreen(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrangeAccent,
                              ),
                              child: const Text(
                                'Fastest Finger',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
