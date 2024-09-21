import 'package:clapapp/Backend/userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({super.key});
  
  get walletAddress => FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserDataProvider>().userData;
    
    return Container(
        height: 220,
        width: 350,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: const Color.fromARGB(255, 14, 19, 29),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Image.asset(
                          "assets/images/credit-card.png",
                          height: 40,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 70,
                        child: Image.asset(
                          "assets/images/wifi.png",
                          height: 50,
                          color: Colors.white,
                        ),
                      ),
                       Positioned(
                        bottom: 16,
                        left: 16,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Column(
                            children: [
                              const SizedBox(height: 100),
                              const Text(
                              "WALLET ADDRESS",
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontSize: 18,
                              ),
                            ),
                            Row(
                              children: <Widget> [ 
                               SizedBox(
                                width: 200,
                                child: Center(
                                  child: SizedBox(
                                    width: 210,
                                    child: Text(
                                      "$walletAddress",
                                      softWrap: false,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:  const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                               const SizedBox(width:50),
                            IconButton.outlined(
                              onPressed: () {
                                 Clipboard.setData(ClipboardData(text: "$walletAddress")).then((_) {
                               showDialog<void>(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
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
                                            'COPIED',
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
                                        'Use the CLAP WALLET ADDRESS you copied to clipboard to fund your account,recieve payments from other users and pay for services. The wallet is encrypted with blockchain technology and end-to-end so transactions can not be traced or recorded.'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(Icons.check_circle_outline),
                                    label: const Text('OK,Done')),
                              ],
                            );
                          });
                         }); 
                              },
                              icon: const Icon(
                                 Icons.copy_all_outlined,
                                 color: Colors.white,
                             ),
                                                     ),
                              ],
                            ),
                                           ],),
                        ),
                                             ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                  child: Container(
                    color:  Colors.deepOrangeAccent,//fromARGB(255, 16, 80, 98),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                          fit: BoxFit.scaleDown,
                           child: SizedBox(
                            width: 200,
                             child: Text(
                                '₦ ${userData['balance']}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                ),
                              ),
                           ),
                         ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white.withOpacity(0.8),
                              ),
                              Transform.translate(
                                offset: const Offset(-10, 0),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white.withOpacity(0.8),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}