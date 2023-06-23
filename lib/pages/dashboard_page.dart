import 'package:flutter/material.dart';
import 'config_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() {
    return DashboardPageState();
  }
}

class DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard page'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ConfigPage()));
                },
                icon: Icon(Icons.settings))
          ],
        ),
        body: Center(
          child: Container(
            color: Colors.grey.shade200,
            width: double.infinity,
            height: double.infinity,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Column(
                      children: [
                        // Statistics card
                        Card(
                            color: Colors.white,
                            child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Row(
                                      /* 
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start, */
                                      children: [
                                        Text('Statistics',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        Spacer(),
                                        Text('Updated just now',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15))
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.amber,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('8.500K',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total cases')
                                            ],
                                          ),
                                          Spacer(),
                                          CircleAvatar(
                                              backgroundColor: Colors.red,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(children: [
                                            Text('650K',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(height: 10),
                                            Text('Total deaths')
                                          ]),
                                          Spacer(),
                                          CircleAvatar(
                                              backgroundColor:
                                                  Colors.deepPurple,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(children: [
                                            Text('12.500K',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(height: 10),
                                            Text('Total tests')
                                          ]),
                                          Spacer(),
                                          CircleAvatar(
                                              backgroundColor: Colors.blue,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(children: [
                                            Text('7',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(height: 10),
                                            Text('Total variants')
                                          ]),
                                        ]),
                                  ],
                                ))),
                        SizedBox(height: 15),
                        //Total cases cardx
                        Card(
                            color: Colors.white,
                            child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Text('Total cases',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                    Spacer(),
                                    CircleAvatar(backgroundColor: Colors.amber, radius: 10),
                                    SizedBox(width: 5),
                                    Text('Not critial'),
                                    SizedBox(width: 30),
                                    CircleAvatar(
                                        backgroundColor: Colors.red, radius: 10),
                                    SizedBox(width: 5),
                                    Text('Critical')
                                  ],
                                )))
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
