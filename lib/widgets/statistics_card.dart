import 'package:covid19_data_explorer/pages/statistics_detail_page.dart';
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
    globalData = await APIRequest().getGlobalData();
    var c = 0;
    var d = 0;
    var t = 0;
    var r = 0;
    for (var i = 0; i < globalData.length; i++) {
      c += globalData[i].cases;
      d += globalData[i].deaths;
      t += globalData[i].tests;
      r += globalData[i].recovered;
    }
    setState(() {
      date = DateTime.fromMillisecondsSinceEpoch(globalData.first.updated)
          .toString()
          .substring(0, 16);
      cases = c;
      deaths = d;
      tests = t;
      recovered = r;
      loaded = true;
    });
  }

  Widget _buildContent() {
    var data = [cases, deaths, tests, recovered];
    var titles = ['cases', 'deaths', 'tests', 'recovered'];
    var colors = [Colors.amber, Colors.red, Colors.deepPurple, Colors.blue];
    var statistics = <Widget>[];
    for (var i = 0; i < data.length; i++) {
      statistics.add(Expanded(
        child: ListTile(
            leading: CircleAvatar(
              backgroundColor: colors[i],
              radius: 30,
            ),
            title: Text(numeral(data[i])),
            subtitle: Text('Total ${titles[i]}')),
      ));
    }
    var finalStatistics = Column(children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [statistics[0], statistics[1]]),
      const SizedBox(height: 50),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [statistics[2], statistics[3]])
    ]);
    return finalStatistics;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StatisticsDetailPage(
              globalData: globalData,
            ),
          ),
        );
      },
      child: Card(
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: loaded == false
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Row(
                          children: [
                            const Text('Global statistics',
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
                        _buildContent(),
                        const SizedBox(height: 40),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Data from Disease.sh API',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15))
                          ],
                        )
                      ],
                    ))),
    );
  }
}
