import 'package:covid19_data_explorer/services/http_request.dart';
import 'package:flutter/material.dart';
import 'package:numeral/numeral.dart';

class StatisticsCard extends StatefulWidget {
  const StatisticsCard({super.key});

  @override
  State<StatisticsCard> createState() => StatisticsCardState();
}

class StatisticsCardState extends State<StatisticsCard> {
  late String date;
  late int cases;
  late int deaths;
  late int tests;
  late int recovered;
  bool loaded = false;
  late List<GlobalResponse> globalData;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    globalData =
        await APIRequest().get('https://disease.sh/v3/covid-19/continents');
    setState(() {
      date = DateTime.fromMillisecondsSinceEpoch(globalData.first.updated)
          .toString()
          .substring(0, 16);
      for(var i =0; i < globalData.length; i++) {
        cases += globalData[i].cases;
        deaths += globalData[i].deaths;
        tests += globalData[i].tests;
        recovered += globalData[i].recovered;
      }
      loaded = true;
    });
  }

  List<Widget> _buildContent() {
    var data = [cases, deaths, tests, recovered];
    var titles = ['cases', 'deaths', 'tests', 'recovered'];
    var colors = [Colors.amber, Colors.red, Colors.deepPurple, Colors.blue];
    var statistics = <Widget>[];
    for (var i = 0; i < data.length; i++) {
      statistics.add(Expanded(
        child: ListTile(
            leading: CircleAvatar(
              backgroundColor: colors[i],
              radius: 25,
            ),
            title: Text('${numeral(data[i])}'),
            subtitle: Text('Total ${titles[i]}')),
      ));
    }
    return statistics;
  }

  @override
  Widget build(BuildContext context) {
    return loaded == false
        ? const CircularProgressIndicator()
        : Card(
            color: Colors.white,
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('Statistics',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Text('Updated: $date',
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                color: Colors.black54, fontSize: 15))
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: 
                          _buildContent()
                          /* Expanded(
                            child: ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.amber,
                                  radius: 25,
                                ),
                                title: Text('${numeral(cases)}'),
                                subtitle: const Text('Total cases')),
                          )
                          const CircleAvatar(
                          backgroundColor: Colors.amber, radius: 25),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Text('$cases',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          const Text('Total cases')
                        ],
                      ),
                      const Spacer(),
                      const CircleAvatar(
                          backgroundColor: Colors.red, radius: 25),
                      const SizedBox(width: 10),
                      Column(children: [
                        Text('$deaths',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        const Text('Total deaths')
                      ]),
                      const Spacer(),
                      const CircleAvatar(
                          backgroundColor: Colors.deepPurple, radius: 25),
                      const SizedBox(width: 10),
                      Column(children: [
                        Text('$tests',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        const Text('Total tests')
                      ]),
                      const Spacer(),
                      const CircleAvatar(
                          backgroundColor: Colors.blue, radius: 25),
                      const SizedBox(width: 10),
                      Column(children: [
                        Text('$recovered',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        const Text('Total recovered')
                      ]), */
                        ),
                        const SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.end ,children: const [
                      Text('Data from Disease.sh API', style: TextStyle(
                                color: Colors.black54, fontSize: 15))
                    ],)
                  ],
                )));
  }
}
