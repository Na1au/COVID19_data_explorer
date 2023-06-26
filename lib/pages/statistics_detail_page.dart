import 'package:flutter/material.dart';

class StatisticsDetailPage extends StatefulWidget {
  @override
  State<StatisticsDetailPage> createState() {
    return StatisticsDetailPageState();
  }
}

class StatisticsDetailPageState extends State<StatisticsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Statistics')),
        body: Center(
            child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.grey.shade200,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      child: Row(
                        children: [
                          //America
                          Card(
                              color: Colors.white,
                              child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Text('America',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.amber,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('126.942.259',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total cases')
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.red,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('1.636.732',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total deaths')
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor:
                                                  Colors.deepPurple,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('1.318.936.359',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total tests')
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.blue,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('5',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total variants')
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ))),
                          SizedBox(width: 20),
                          //Asia
                          Card(
                              color: Colors.white,
                              child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Text('Asia',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.amber,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('218.005.098',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total cases')
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.red,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('1.547.402',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total deaths')
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor:
                                                  Colors.deepPurple,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('2.396.875.944',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total tests')
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.blue,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('7',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total variants')
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ))),
                          SizedBox(width: 20),
                          //Africa
                          Card(
                              color: Colors.white,
                              child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Text('Africa',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.amber,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('12.829.456',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total cases')
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.red,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('258.804',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total deaths')
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor:
                                                  Colors.deepPurple,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('111.015.515',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total tests')
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.blue,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('6',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total variants')
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ))),
                          SizedBox(width: 20),
                          Card(
                              color: Colors.white,
                              child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Text('Europe',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.amber,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('249.631.998',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total cases')
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.red,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('2.065.194',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total deaths')
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor:
                                                  Colors.deepPurple,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('2.833.327.579',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total tests')
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.blue,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('5',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total variants')
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ))),
                          SizedBox(width: 20),
                          Card(
                              color: Colors.white,
                              child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Text('Oceania',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.amber,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('14.513.753',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total cases')
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.red,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('28.945',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total deaths')
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor:
                                                  Colors.deepPurple,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('91.666.246',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total tests')
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: Colors.blue,
                                              radius: 25),
                                          SizedBox(width: 10),
                                          Column(
                                            children: [
                                              Text('4',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 5),
                                              Text('Total variants')
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ))),
                        ],
                      ),
                    )
                  ],
                ))));
  }
}
