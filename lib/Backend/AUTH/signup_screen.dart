import 'package:clapapp/Backend/AUTH/auth_service.dart';
import 'package:clapapp/Backend/AUTH/login_screen.dart';
import 'package:clapapp/Backend/PIN/pin_setup_screen.dart';
import 'package:clapapp/widgets/button.dart';
import 'package:clapapp/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = AuthService();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
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
            const Text("Signup",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 50,
            ),
            CustomTextField(
              hint: "Enter Name",
              label: "Name",
              controller: _name,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hint: "Enter Email",
              label: "Email",
              controller: _email,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hint: "Enter Password",
              label: "Password",
              isPassword: true,
              controller: _password,
            ),
            const SizedBox(height: 30),
            CustomButton(
              label: "Signup",
              onPressed: () async {
                await _signup(context);
              },
            ),
            //const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Already have an account? "),
              InkWell(
                onTap: () => goToLogin(context),
                child: const Text("Login", style: TextStyle(color: Colors.red)),
              )
            ]),
            const Spacer()
          ],
        ),
      ),
    );
  }

  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );

  goToPinSetupScreen(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PinSetupScreen()),
      );

  Future _signup(BuildContext context) async {
    String result = await _auth.createUserAndDatabase(
        _email.text, _password.text, _name.text);
    if (result == "success") {
      //log("account created successfully");
      showDialog<void>(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              //icon: const Icon(Icons.info_rounded),
              //title: const Text('SUCCESS'),
              content: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_rounded,
                          color: Colors.green,
                        ),
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
                    Text('Account Created Succesfully'),
                  ],
                ),
              ),
              actions: [
                TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.done_all_rounded),
                    label: const Text('OK'))
              ],
            );
          });
      // ignore: use_build_context_synchronously
      goToPinSetupScreen(context);
    } else {
      //log("account not created");
      showDialog<void>(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              //icon: const Icon(Icons.info_rounded),
              //title: const Text('ERROR'),
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
                        Icon(
                          Icons.info_rounded,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10.0,
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
                    label: const Text('Try Again'))
              ],
            );
          });
    }
  }
}
