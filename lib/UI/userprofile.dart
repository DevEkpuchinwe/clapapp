import 'package:clapapp/Backend/userdata.dart';
import 'package:clapapp/Backend/AUTH/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigation/routes.dart';

class ProfileScree extends StatefulWidget {
  const ProfileScree({super.key});
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CLAP',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      //darkTheme: ThemeData.dark(),
      //themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const ProfileScree(),
    );
  }

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScree> {
  bool _isOn = false;
  void _toggle() {
    setState(() {
      _isOn = !_isOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserDataProvider>().userData;
    final formattedName = (userData['name'] ?? '0.00').toUpperCase();
    final formattedEmail = (userData['email'] ?? '0.00').toLowerCase();

    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Text(
              'SETTINGS',
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrangeAccent),
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                  'Your CLAP Profile is your personal gateway to managing your account information'),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              const CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.deepOrange,
                child: Icon(
                  Icons.account_circle,
                  size: 70.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '$formattedName',
                        overflow: TextOverflow.visible,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  const SizedBox(width: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.email),
                      const SizedBox(
                        height: 10,
                      ),
                      // ignore: unnecessary_string_interpolations
                      SizedBox(
                          width: 170,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '$formattedEmail',
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'General Settings',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Column(children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            IconButton.outlined(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.manage_accounts,
                                color: Colors.deepOrangeAccent,
                                size: 35,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Personal Information',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text('Edit your information and settings'),
                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.navigate_next_rounded),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            IconButton.outlined(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.remove_red_eye,
                                color: Colors.deepOrangeAccent,
                                size: 35,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            const Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'App Display Mode',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text('Switch view mode'),
                                ],
                              ),
                            ),
                            const Spacer(),
                            //const Icon(Icons.navigate_next_rounded),
                            GestureDetector(
                              onTap: _toggle,
                              child: Container(
                                width: 60,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: _isOn
                                      ? Colors.deepOrangeAccent
                                      : Colors.grey,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Align(
                                  alignment: _isOn
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                    width: 30,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            IconButton.outlined(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.privacy_tip,
                                color: Colors.deepOrangeAccent,
                                size: 35,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            const Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Help,Support and Legal',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text('Customer care, User Data'),
                                ],
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.navigate_next_rounded),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      GestureDetector(
                        onTap: () {
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.info_rounded,
                                                color: Colors.deepOrangeAccent),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text('LOGOUT ?',
                                                style: TextStyle(
                                                    color:
                                                        Colors.deepOrangeAccent,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Text(
                                            'Please confirm if you want to sign  out of your account.This action will log you out and you need to sign in again to access your account.'),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton.icon(
                                        onPressed: () async {
                                          await AuthService().signout();
                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context).pop();
                                          final prefs = await SharedPreferences.getInstance();
                                          await prefs.remove('user_pin');
                                          // ignore: use_build_context_synchronously
                                          goToLoginScreen(context);
                                          //SystemChannels.platform
                                          //   .invokeMethod('SystemNavigator.pop');
                                        },

                                        
                                        icon: const Icon(Icons.check_circle_outline),
                                        label: const Text('YES,LogOut')),
                                    //const SizedBox(
                                    // width: 50,
                                    // ),
                                    TextButton.icon(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(Icons.cancel_outlined),
                                        label: const Text('NO,Cancel'))
                                  ],
                                );
                              });
                        },
                        child: Row(
                          children: [
                            IconButton.outlined(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.deepOrangeAccent,
                                size: 35,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            const Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sign Out Account',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text('Remove your account from device'),
                                ],
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.navigate_next_rounded),
                          ],
                        ),
                      ),
                    ]),
              ),
            ]),
          ],
        ),
      ),
    ));
  }
}
