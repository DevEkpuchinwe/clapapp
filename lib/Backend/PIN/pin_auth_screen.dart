// ignore_for_file: library_private_types_in_public_api

import 'package:clapapp/Backend/AUTH/login_screen.dart';
import 'package:clapapp/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AUTH/auth_service.dart';

class PinAuthScreen extends StatefulWidget {
  const PinAuthScreen({super.key});

  @override
  _PinAuthScreenState createState() => _PinAuthScreenState();
}

class _PinAuthScreenState extends State<PinAuthScreen> {
  final int pinLength = 4;
  final List<String> pin = List.filled(4, '');
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  String errorMessage = '';
  int remainingAttempts = 4;

  void _onPinChanged(int index, String value) {
    setState(() {
      errorMessage = '';
      pin[index] = value;
    });

    if (value.length == 1) {
      if (index < pinLength - 1) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus();
        _authenticatePin();
      }
    }
  }

  void _authenticatePin() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPin = prefs.getString('user_pin');

    if (pin.join() == savedPin) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          shape: RoundedRectangleBorder(),
          content: Text(
            'Authentication successful',
            style: TextStyle(color: Colors.deepOrangeAccent),
          )));
      // ignore: use_build_context_synchronously
      goToMainScreen(context);
    } else {
      setState(() async {
        remainingAttempts--;
        if (remainingAttempts > 0) {
          errorMessage = 'Incorrect PIN. $remainingAttempts attempts remaining.';
          _resetPinFields();
        } else {
          await AuthService().signout();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          });
        }
      });
    }
  }

  void _resetPinFields() {
    for (var controller in _controllers) {
      controller.clear();
    }
    pin.fillRange(0, pinLength, '');
    FocusScope.of(context).requestFocus(_focusNodes[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter PIN'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please enter your 4-digit PIN',
              style: TextStyle(fontSize: 16, color: Colors.deepOrangeAccent),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(pinLength, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    obscureText: true,
                    style: const TextStyle(color: Colors.deepOrange),
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrangeAccent),
                      ),
                    ),
                    onChanged: (value) => _onPinChanged(index, value),
                  ),
                );
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Forgot Your PIN ? "),
              InkWell(
                onTap: () => goToLogin(context),
                child: const Text("RESET", style: TextStyle(color: Colors.red)),
              )
            ]),
            const SizedBox(height: 20),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
}
