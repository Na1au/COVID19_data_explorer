import 'package:covid19_data_explorer/pages/see_statistics_kml.dart';
import 'package:covid19_data_explorer/services/http_request.dart';
import 'package:flutter/material.dart';
import 'package:numeral/numeral.dart';

class StatisticsDetailPage extends StatefulWidget {
  const StatisticsDetailPage({super.key, required this.globalData});
  final List<GlobalResponse> globalData;

  @override
  State<StatisticsDetailPage> createState() {
    return StatisticsDetailPageState();
  }
}

class StatisticsDetailPageState extends State<StatisticsDetailPage> {
  late GlobalResponse dataUSA;
  late GlobalResponse dataCanada;
  late GlobalResponse dataMexico;
/*   late int cases;
  late int deaths;
  late int tests;
  late int recovered; */
  List<List<int>> continentData = [];
  bool loaded = false;
  List<String> continentTitles = [
    'North America',
    'South America',
    'Africa',
    'Asia',
    'Europe',
    'Oceania'
  ];

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
   /*  var data1 = await APIRequest().getCountryData('USA');
    var data2 = await APIRequest().getCountryData('Canada');
    var data3 = await APIRequest().getCountryData('Mexico'); */
    var dataNA = _getGlobalData('North America');
    var dataSA = _getGlobalData('South America');
    var dataAF = _getGlobalData('Africa');
    var dataAS = _getGlobalData('Asia');
    var dataEU = _getGlobalData('Europe');
    var dataOC = _getGlobalData('Australia-Oceania');
    var finalDatas = [dataNA, dataSA, dataAF, dataAS, dataEU, dataOC];
    /* setState(() {
      dataUSA = data1;
      dataCanada = data2;
      dataMexico = data3;
    }); 
    cases = dataCanada.cases + dataMexico.cases + dataUSA.cases;
    deaths = dataCanada.deaths + dataMexico.deaths + dataUSA.deaths;
    tests = dataCanada.tests + dataMexico.tests + dataUSA.tests;
    recovered = dataCanada.recovered + dataMexico.recovered + dataUSA.recovered;
    continentData.add([cases, deaths, tests, recovered]);  */
    for (var i = 0; i < finalDatas.length; i++) {
      continentData.add([
        finalDatas[i].cases,
        finalDatas[i].deaths,
        finalDatas[i].tests,
        finalDatas[i].recovered
      ]);
    }
    setState(() {
      loaded = true;
    });
  }

  GlobalResponse _getGlobalData(continent) {
    var selected = widget.globalData.firstWhere((element) => element.continent == continent);
    return selected;
  }

  List<Widget> _buildContents(String title, List<int> continentData) {
    var contents = <Widget>[];
    //var data = [cases, deaths, tests, recovered];
    var colors = [Colors.amber, Colors.red, Colors.deepPurple, Colors.blue];
    var titles = ['cases', 'deaths', 'tests', 'recovered'];
      for (var i = 0; i < 4; i++) {
        contents.add(/* SizedBox(
          height: 400,
          width: 230,
          child: Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: loaded == false
                    ? Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator()))
                    : Column(children: [
                        Text('${continentTitles[i]}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 20), */
                        SizedBox(
                          width: 200,
                          child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: colors[i],
                                radius: 25,
                              ),
                              // ignore: unnecessary_string_interpolations
                              title: Text('${numeral(continentData[i])}'),
                              subtitle: Text('Total ${titles[i]}'),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => StatisticsKMLPage(
                                      title: '$title total ${titles[i]}',
                                      usa: dataUSA,
                                      canada: dataCanada,
                                      mexico: dataMexico,
                                      type: titles[i],
                                      total: continentData[i]),
                                ));
                              }),
                        ));
                      /* ]),
              )),
        )); */
    }
    return contents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Statistics')),
        body: Container(
            alignment: Alignment.topLeft,
            height: double.infinity,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //America
                            for (var i = 0; i < 5; i++) ...[
                              SizedBox(
                                height: 400,
                                width: 230,
                                child: Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: loaded == false
                                          ? const Center(
                                              child: SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child:
                                                      CircularProgressIndicator()))
                                          : Column(children: [
                                              Text(continentTitles[i],
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const SizedBox(height: 20),
                                              ..._buildContents(
                                                  continentTitles[i], continentData[i])
                                            ]),
                                    )),
                              )
                            ]
                            /* Card(
                              color: Colors.white,
                              child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: loaded == false
                                      ? CircularProgressIndicator()
                                      : Column(
                                          children: [
                                            Text('North America',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(height: 20),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            StatisticsKMLPage(
                                                                title:
                                                                    'North America total cases',
                                                                usa: dataUSA,
                                                                canada:
                                                                    dataCanada,
                                                                mexico:
                                                                    dataMexico,
                                                                type:
                                                                    'cases')));
                                              },
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                      backgroundColor:
                                                          Colors.amber,
                                                      radius: 25),
                                                  SizedBox(width: 10),
                                                  Column(
                                                    children: [
                                                      Text('$cases',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      SizedBox(height: 5),
                                                      Text('Total cases')
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              StatisticsKMLPage(
                                                                  title:
                                                                      'North America total deaths',
                                                                  usa: dataUSA,
                                                                  canada:
                                                                      dataCanada,
                                                                  mexico:
                                                                      dataMexico,
                                                                  type:
                                                                      'deaths')));
                                                },
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                        backgroundColor:
                                                            Colors.red,
                                                        radius: 25),
                                                    SizedBox(width: 10),
                                                    Column(
                                                      children: [
                                                        Text('$deaths',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        SizedBox(height: 5),
                                                        Text('Total deaths')
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                            SizedBox(height: 15),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              StatisticsKMLPage(
                                                                  title:
                                                                      'North America total tests',
                                                                  usa: dataUSA,
                                                                  canada:
                                                                      dataCanada,
                                                                  mexico:
                                                                      dataMexico,
                                                                  type:
                                                                      'tests')));
                                                },
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                        backgroundColor:
                                                            Colors.deepPurple,
                                                        radius: 25),
                                                    SizedBox(width: 10),
                                                    Column(
                                                      children: [
                                                        Text('$tests',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        SizedBox(height: 5),
                                                        Text('Total tests')
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                            SizedBox(height: 15),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              StatisticsKMLPage(
                                                                  title:
                                                                      'North America total recovered',
                                                                  usa: dataUSA,
                                                                  canada:
                                                                      dataCanada,
                                                                  mexico:
                                                                      dataMexico,
                                                                  type:
                                                                      'recovered')));
                                                },
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                        backgroundColor:
                                                            Colors.blue,
                                                        radius: 25),
                                                    SizedBox(width: 10),
                                                    Column(
                                                      children: [
                                                        Text('$recovered',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        SizedBox(height: 5),
                                                        Text('Total recovered')
                                                      ],
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ))), */
                            //SizedBox(width: 20),
                            //Asia
                            /* Card(
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
                                              Text('Total recovered')
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
                                              Text('Total recovered')
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
                                              Text('Total recovered')
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
                                              Text('Total recovered')
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ))), */
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 400,
                              width: 230,
                              child: Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: loaded == false
                                        ? const Center(
                                            child: SizedBox(
                                                height: 50,
                                                width: 50,
                                                child:
                                                    CircularProgressIndicator()))
                                        : Column(children: [
                                            Text(continentTitles[5],
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 20),
                                            ..._buildContents(
                                                continentTitles[5], continentData[5])
                                          ]),
                                  )),
                            )
                          ],
                        )
                      ],
                    ))))); //);
  }
}
