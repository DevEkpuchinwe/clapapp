import 'package:clapapp/Backend/AUTH/auth_service.dart';
import 'package:clapapp/Backend/AUTH/signup_screen.dart';
import 'package:clapapp/Backend/PIN/pin_setup_screen.dart';
import 'package:clapapp/widgets/button.dart';
import 'package:clapapp/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../navigation/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const Spacer(),
            const Text("Welcome Back",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
            const SizedBox(height: 50),
            CustomTextField(
              hint: "Enter Email",
              label: "Email",
              controller: _email,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hint: "Enter Password",
              label: "Password",
              controller: _password,
            ),
            const SizedBox(height: 30),
            CustomButton(
              label: "Login",
              onPressed: () async {
                await _login(context);
              },
            ),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 5,
              ),
              const Text("Forgot Your Password ? "),
              InkWell(
                onTap: () => goToPasswordReset(context),
                child: const Text("Reset", style: TextStyle(color: Colors.red)),
              )
            ]),
            // const SizedBox(height: 5,),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Don't Have An Account ? "),
              InkWell(
                onTap: () => goToSignup(context),
                child:
                    const Text("Signup", style: TextStyle(color: Colors.red)),
              )
            ]),
            const Spacer()
          ],
        ),
      ),
    );
  }

  goToSignup(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignupScreen()),
      );

  goToPinSetupScreen(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PinSetupScreen()),
      );

  Future _login(BuildContext context) async {
    String result =
        await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);

    if (result == "success") {
      //log("User Logged In");
      showDialog<void>(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              //icon: const Icon(Icons.info_rounded, color: Colors.green),
              //title: const Text('SUCCESSFUL',
              //    style: TextStyle(color: Colors.green)),
              content: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.info_rounded, color: Colors.green),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text('SUCCESSFUL',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text('You Have Successfully logged In'),
                  ],
                ),
              ),
              actions: [
                TextButton.icon(
                    onPressed: () {
                     // goToPinSetupScreen(context);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.done_all_rounded),
                    label: const Text('OK'))
              ],
            );
          });
      // ignore: use_build_context_synchronously
      goToPinSetupScreen(context);
      //if (context.mounted) {
      //return goToNavigator(context);
      // }
    } else {
      //log("user not logged in")
      showDialog<void>(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              //icon: const Icon(Icons.info_rounded, color: Colors.red),
              //title: const Text('ERROR', style: TextStyle(color: Colors.red)),
              // ignore: avoid_unnecessary_containers
              content: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.info_rounded, color: Colors.red),
                        SizedBox(
                          width: 10,
                        ),
                        Text('ERROR',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(result),
                  ],
                ),
              ),
              actions: [
                TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close_rounded),
                    label: const Text('Try Again')),
              ],
            );
          });
    }
  }
}
