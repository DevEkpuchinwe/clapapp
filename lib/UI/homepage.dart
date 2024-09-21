import 'package:clapapp/Backend/userdata.dart';
import 'package:clapapp/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/action_button.dart';
import '../widgets/credit_card.dart';
import '../widgets/vtu_list.dart';
//import '../widgets/vtubottons.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3092939428.
    final userData = context.watch<UserDataProvider>().userData;
    final formattedName = (userData['name'] ?? '0.00').toUpperCase();
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent, //fromARGB(255, 16, 80, 98),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome back! 👋",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 240,
                        child: Text(
                          "$formattedName",
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  //const Spacer(),
                  const SizedBox(
                    width: 1,
                  ),
                  IconButton.outlined(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                  ),
                  //const Spacer(),
                  const SizedBox(
                    width: 8,
                  ),
                  IconButton.outlined(
                    onPressed: () {
                      goToCustomerSupportScreen(context);
                    },
                    icon: const Icon(
                      Icons.support_agent_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 167),
                    color: Colors.white,
                    child: const Column(
                      children: [
                        SizedBox(height: 90),
                        //   ActionButtons
                        ActionButtons(),
                        SizedBox(height: 25),
                        //   TransactionList
                        TransactionList()
                      ],
                    ),
                  ),
                  const Positioned(
                    top: 20,
                    left: 25,
                    right: 25,
                    child: CreditCard(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
