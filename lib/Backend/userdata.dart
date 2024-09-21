import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class UserDataProvider extends ChangeNotifier {
  Map<String, dynamic> _userData = {
    'name': 'CLAP USER',
    'email': 'clapuser@claporg.com.ng',
    'balance': 0.00,
    'coins': 0.00,
    'freecoins': false,
    'lastClaimedDate': null,
  };

  // New fields for the exchange rates
  double _coinExchangeRate = 0.0;
  double _nairaExchangeRate = 0.0;
  double _freeCoinAmount = 10.0;

  // Getter for userData
  Map<String, dynamic> get userData => _userData;

  // Getters for exchange rates
  double get coinExchangeRate => _coinExchangeRate;
  double get nairaExchangeRate => _nairaExchangeRate;
  double get freeCoinAmount => _freeCoinAmount;

  StreamSubscription<DocumentSnapshot>? _userSubscription;
  StreamSubscription<DocumentSnapshot>? _exchangeRatesSubscription;

  UserDataProvider() {
    _initializeUser(); // Fetch user data when the provider initializes
    _initializeExchangeRates(); // Fetch exchange rates when the provider initializes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _initializeUser();
    });
  }

  void _initializeUser() {
    _userSubscription?.cancel(); // Cancel any existing subscription
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _userSubscription = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .listen(
        (snapshot) {
          if (snapshot.exists) {
            _userData = snapshot.data() as Map<String, dynamic>;
            notifyListeners(); // Notify listeners after updating user data
          }
        },
        onError: (error) {
          _resetUserData(); // Reset user data on error
          notifyListeners();
        },
      );
    } else {
      _resetUserData(); // Reset user data if no user is logged in
      notifyListeners();
    }
  }

  // Method to initialize and subscribe to exchange rates updates from Firestore
  void _initializeExchangeRates() {
    _exchangeRatesSubscription?.cancel(); // Cancel any existing subscription

    _exchangeRatesSubscription = FirebaseFirestore.instance
        .collection('AppData')
        .doc('updates')
        .snapshots()
        .listen(
      (snapshot) {
        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>;
          _coinExchangeRate = data['coinsexchangerate']?.toDouble() ?? 0.0;
          _nairaExchangeRate = data['nairaexchangerate']?.toDouble() ?? 0.0;
          _freeCoinAmount = data['freecoinamount']?.toDouble() ?? 0.0;
          notifyListeners(); // Notify listeners after updating exchange rates
        }
      },
      onError: (error) {
        print('Error fetching exchange rates: $error');
      },
    );
  }

  void _resetUserData() {
    _userData = {
      'name': 'CLAP USER',
      'email': 'clapuser@claporg.com.ng',
      'balance': 0.00,
      'coins': 0.00,
      'freecoins': false,
      'lastClaimedDate': null,
    };
  }

  void setUserData(Map<String, dynamic> newUserData) {
    _userData = newUserData;
    notifyListeners();
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    _exchangeRatesSubscription?.cancel();
    super.dispose();
  }
}
