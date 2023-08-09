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
  late List<CountryResponse> finalContinentsData;
  List<List<int>> continentData = [];
  bool loaded = false;
  List<String> continentTitles = [
    'North America',
    'South America',
    'Africa',
    'Asia',
    'Europe',
    'Australia-Oceania'
  ];

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    var dataNA = _getGlobalData('North America');
    var dataSA = _getGlobalData('South America');
    var dataAF = _getGlobalData('Africa');
    var dataAS = _getGlobalData('Asia');
    var dataEU = _getGlobalData('Europe');
    var dataOC = _getGlobalData('Australia-Oceania');
    var finalDatas = [dataNA, dataSA, dataAF, dataAS, dataEU, dataOC];
    for (var i = 0; i < finalDatas.length; i++) {
      continentData.add([
        finalDatas[i].cases,
        finalDatas[i].deaths,
        finalDatas[i].tests,
        finalDatas[i].recovered
      ]);
    }
    var continentsData = await APIRequest().getContinentData();
    setState(() {
      finalContinentsData = continentsData;
      loaded = true;
    });
  }

  GlobalResponse _getGlobalData(continent) {
    var selected = widget.globalData
        .firstWhere((element) => element.continent == continent);
    return selected;
  }

  List<Widget> _buildContents(String title, List<int> continentData) {
    var contents = <Widget>[];
    var colors = [Colors.amber, Colors.red, Colors.deepPurple, Colors.blue];
    var titles = ['cases', 'deaths', 'tests', 'recovered'];
    for (var i = 0; i < 4; i++) {
      contents.add(SizedBox(
        width: 250,
        child: ListTile(
            leading: CircleAvatar(
              backgroundColor: colors[i],
              radius: 30,
            ),
            // ignore: unnecessary_string_interpolations
            title: Text('${numeral(continentData[i])}'),
            subtitle: Text('Total ${titles[i]}'),
            onTap: () {
              var finalTitle = title == 'North America' ? 'North and Central America' : title;
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StatisticsKMLPage(
                    title: '$finalTitle total ${titles[i]}',
                    type: titles[i],
                    total: continentData[i],
                    continent: title,
                    totalContinents: finalContinentsData),
              ));
            }),
      ));
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
                padding:
                    const EdgeInsets.all(15),
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            //America
                            for (var i = 0; i < 3; i++) ...[
                              SizedBox(
                                height: 400,
                                width: 350,
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
                                              Text(continentTitles[i] == 'North America' ? 'North and Central America' : continentTitles[i],
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const SizedBox(height: 20),
                                              ..._buildContents(
                                                  continentTitles[i],
                                                  continentData[i])
                                            ]),
                                    )),
                              )
                            ]
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            for (var i = 3; i < 6; i++) ...[
                              SizedBox(
                                height: 400,
                                width: 350,
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
                                                  continentTitles[i],
                                                  continentData[i])
                                            ]),
                                    )),
                              )
                            ]
                          ],
                        )
                      ],
                    ))))); //);
  }
}
