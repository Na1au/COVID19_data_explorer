import 'package:flutter/material.dart';

class StatisticsCard extends StatefulWidget {
  @override
  State<StatisticsCard> createState() {
    return StatisticsCardState();
  }
}

class StatisticsCardState extends State<StatisticsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Statistics',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Spacer(),
                    Text('Updated just now',
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.black54, fontSize: 15))
                  ],
                ),
                SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(backgroundColor: Colors.amber, radius: 25),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          Text('8.500K',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text('Total cases')
                        ],
                      ),
                      Spacer(),
                      CircleAvatar(backgroundColor: Colors.red, radius: 25),
                      SizedBox(width: 10),
                      Column(children: [
                        Text('650K',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text('Total deaths')
                      ]),
                      Spacer(),
                      CircleAvatar(
                          backgroundColor: Colors.deepPurple, radius: 25),
                      SizedBox(width: 10),
                      Column(children: [
                        Text('12.500K',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text('Total tests')
                      ]),
                      Spacer(),
                      CircleAvatar(backgroundColor: Colors.blue, radius: 25),
                      SizedBox(width: 10),
                      Column(children: [
                        Text('7',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text('Total variants')
                      ]),
                    ]),
              ],
            )));
  }
}
