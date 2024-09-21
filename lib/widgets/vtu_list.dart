// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children:  [
         const  Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Services"),
                Row(
                  children: [
                    Text("Pay Your Bills"),
                  ],
                ),
              ],
            ),
          ),
          
          Divider(color: Colors.red[200],),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              children: [
                Row(
                  children: [
                      
                      
                      SizedBox(width: 100,
                        child: GestureDetector(
                              onTap: (){},
                              child: const Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.deepOrangeAccent,
                                    child: Icon(
                                      Icons.call,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Airtime',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ) ,
                     SizedBox(width: 80,
                        child: GestureDetector(
                              onTap: (){},
                              child: const Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.deepOrangeAccent,
                                    child: Icon(
                                      Icons.wifi,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Data',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ), 
                      SizedBox(width: 80,
                        child: GestureDetector(
                              onTap: (){},
                              child: const Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.deepOrangeAccent,
                                    child: Icon(
                                      Icons.desktop_mac,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Cable TV',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ),
                     SizedBox(width: 80,
                        child: GestureDetector(
                              onTap: (){},
                              child: const Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.deepOrangeAccent,
                                    child: Icon(
                                      Icons.tips_and_updates,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Electricity',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      )            
                  ],
                ),
                const SizedBox(height: 25,),
                 Row(
                  children: [
                      
                      
                      SizedBox(width: 100,
                        child: GestureDetector(
                              onTap: (){},
                              child: const Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.deepOrangeAccent,
                                    child: Icon(
                                      Icons.sports_esports,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Betting',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ) ,
                     SizedBox(width: 80,
                        child: GestureDetector(
                              onTap: (){},
                              child: const Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.deepOrangeAccent,
                                    child: Icon(
                                      Icons.school,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Exam Pins',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ), 
                      SizedBox(width: 80,
                        child: GestureDetector(
                              onTap: (){},
                              child: const Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.deepOrangeAccent,
                                    child: Icon(
                                      Icons.real_estate_agent,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Quick Loans',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ),
                     SizedBox(width: 80,
                        child: GestureDetector(
                              onTap: (){},
                              child: const Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.deepOrangeAccent,
                                    child: Icon(
                                      Icons.more_horiz,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'More',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      )            
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}