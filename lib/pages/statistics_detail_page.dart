import 'package:covid19_data_explorer/pages/see_statistics_kml.dart';
import 'package:covid19_data_explorer/services/http_request.dart';
import 'package:flutter/material.dart';
import 'package:numeral/numeral.dart';
import 'package:covid19_data_explorer/services/http_request.dart';

class StatisticsDetailPage extends StatefulWidget {
  const StatisticsDetailPage({super.key});

  @override
  State<StatisticsDetailPage> createState() {
    return StatisticsDetailPageState();
  }
}

class StatisticsDetailPageState extends State<StatisticsDetailPage> {
  late GlobalResponse dataUSA;
  late GlobalResponse dataCanada;
  late GlobalResponse dataMexico;
  late int cases;
  late int deaths;
  late int tests;
  late int recovered;
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
    /* var data1 = await APIRequest()
        .get('https://disease.sh/v3/covid-19/countries/USA?strict=true');
    var data2 = await APIRequest()
        .get('https://disease.sh/v3/covid-19/countries/Canada?strict=true');
    var data3 = await APIRequest()
        .get('https://disease.sh/v3/covid-19/countries/Mexico?strict=true'); */
    var data1 = GlobalResponse(
        updated: 0,
        cases: 107356022,
        todayCases: 0,
        deaths: 1168502,
        todayDeaths: 0,
        recovered: 105519193,
        todayRecovered: 0,
        active: 0,
        critical: 0,
        tests: 1180842363);
    var data2 = GlobalResponse(
        updated: 0,
        cases: 4690486,
        todayCases: 0,
        deaths: 52912,
        todayDeaths: 0,
        recovered: 4630630,
        todayRecovered: 0,
        active: 0,
        critical: 0,
        tests: 66343123);
    var data3 = GlobalResponse(
        updated: 0,
        cases: 7633355,
        todayCases: 0,
        deaths: 334336,
        todayDeaths: 0,
        recovered: 6885378,
        todayRecovered: 0,
        active: 0,
        critical: 0,
        tests: 20013810);
    var dataSA = GlobalResponse(
        updated: 0,
        cases: 68833395,
        todayCases: 0,
        deaths: 1357698,
        todayDeaths: 0,
        recovered: 66485165,
        todayRecovered: 0,
        active: 0,
        critical: 0,
        tests: 244597045);
    var dataAF = GlobalResponse(
        updated: 0,
        cases: 12831574,
        todayCases: 0,
        deaths: 258806,
        todayDeaths: 0,
        recovered: 12087639,
        todayRecovered: 0,
        active: 0,
        critical: 0,
        tests: 111015833);
    var dataAS = GlobalResponse(
        updated: 0,
        cases: 218288753,
        todayCases: 0,
        deaths: 1547809,
        todayDeaths: 0,
        recovered: 201977284,
        todayRecovered: 0,
        active: 0,
        critical: 0,
        tests: 2397216865);
    var dataEU = GlobalResponse(
        updated: 0,
        cases: 249686958,
        todayCases: 0,
        deaths: 2067125,
        todayDeaths: 0,
        recovered: 245818364,
        todayRecovered: 0,
        active: 0,
        critical: 0,
        tests: 2833641419);
    var dataOC = GlobalResponse(
        updated: 0,
        cases: 14552582,
        todayCases: 0,
        deaths: 29336,
        todayDeaths: 0,
        recovered: 14409133,
        todayRecovered: 0,
        active: 0,
        critical: 0,
        tests: 91666664);
    /* var dataSA = await APIRequest().get(
        'https://corona.lmao.ninja/v2/continents/South America?yesterday=&strict=true');
    var dataAF = await APIRequest()
        .get('https://corona.lmao.ninja/v2/continents/Africa?yesterday=true');
    var dataAS = await APIRequest()
        .get('https://corona.lmao.ninja/v2/continents/Asia?yesterday=true');
    var dataEU = await APIRequest()
        .get('https://corona.lmao.ninja/v2/continents/Europe?yesterday=true');
    var dataOC = await APIRequest().get(
        'https://corona.lmao.ninja/v2/continents/Australia-Oceania?yesterday=true'); */
    var finalDatas = [dataSA, dataAF, dataAS, dataEU, dataOC];
    setState(() {
      dataUSA = data1;
      dataCanada = data2;
      dataMexico = data3;
    });
    cases = dataCanada.cases + dataMexico.cases + dataUSA.cases;
    deaths = dataCanada.deaths + dataMexico.deaths + dataUSA.deaths;
    tests = dataCanada.tests + dataMexico.tests + dataUSA.tests;
    recovered = dataCanada.recovered + dataMexico.recovered + dataUSA.recovered;
    //continentData.addAll(iterable) .add(GlobalResponse);
    continentData.add([cases, deaths, tests, recovered]);
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

  List<Widget> _buildContents(String title, List<int> continentData) {
    var contents = <Widget>[];
    var data = [cases, deaths, tests, recovered];
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
                        Container(
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
                                      type: '${titles[i]}',
                                      total: data[i]),
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
        appBar: AppBar(title: Text('Statistics')),
        body: Container(
            alignment: Alignment.topLeft,
            height: double.infinity,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                                      padding: EdgeInsets.all(15),
                                      child: loaded == false
                                          ? Center(
                                              child: SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child:
                                                      CircularProgressIndicator()))
                                          : Column(children: [
                                              Text('${continentTitles[i]}',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(height: 20),
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
                                    padding: EdgeInsets.all(15),
                                    child: loaded == false
                                        ? Center(
                                            child: SizedBox(
                                                height: 50,
                                                width: 50,
                                                child:
                                                    CircularProgressIndicator()))
                                        : Column(children: [
                                            Text('${continentTitles[5]}',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(height: 20),
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
