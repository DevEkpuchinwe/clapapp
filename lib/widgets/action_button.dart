import 'package:clapapp/navigation/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import '../pages/transfer_money.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        height: 90,
        decoration:
             BoxDecoration(color:  Colors.black, borderRadius: BorderRadius.circular(15)),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionButton(
              icon: Icons.account_balance,
              label: 'Deposit',
              onPressed: (){
                 showDialog<void>(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (BuildContext context) {
                            return  CupertinoAlertDialog(
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
                                        Text(
                                            'UPDATE',
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
                                        'Automatic funding is currently unavailable due to CBN policies. You can fund your account manually with our customer chat specialist. We apologize for the inconvenience and appreciate your understanding. Automatic funding will be available soon.'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton.icon(
                                    onPressed: () {
                                      goToCustomerSupportScreen(context);
                                    },
                                    icon: const Icon(Icons.check_circle_outline),
                                    label: const Text('OK,Fund')),
                                TextButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(Icons.cancel_outlined),
                                    label: const Text('NO,Cancel')),
                              ],
                            );
                          });
              },
            ),
            ActionButton(
              icon: Icons.swap_horiz,
              label: 'Transfer',
              onPressed: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context)=> const TransferMoney()));
              },
            ),
            ActionButton(
              icon: Icons.attach_money,
              label: 'Withdraw',
              onPressed: (){
                showDialog<void>(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (BuildContext context) {
                            return  CupertinoAlertDialog(
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
                                        Text(
                                            'UPDATE',
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
                                        'Automatic withdrawal is currently unavailable due to CBN policies. You can withdraw your money from your account manually with our customer chat specialist. We apologize for the inconvenience and appreciate your understanding. Automatic withdrawal will be available soon.'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton.icon(
                                    onPressed: () {
                                      goToCustomerSupportScreen(context);
                                    },
                                    icon: const Icon(Icons.check_circle_outline),
                                    label: const Text('OK,Proceed')),
                                TextButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(Icons.cancel_outlined),
                                    label: const Text('NO,Cancel')),
                              ],
                            );
                          });
              },
            ),
            ActionButton(
              icon: Icons.apps_sharp,
              label: 'More',
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({super.key, required this.icon, required this.label, this.onPressed});

  final IconData icon;
  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.outlined(
          onPressed:onPressed,
          icon: Icon(
            icon,
            color: Colors.deepOrangeAccent//fromARGB(255, 16, 80, 98),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.deepOrangeAccent,fontSize:  15, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}