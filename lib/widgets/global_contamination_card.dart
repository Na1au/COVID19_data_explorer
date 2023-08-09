import 'package:covid19_data_explorer/services/http_request.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GlobalContaminationCard extends StatefulWidget {
  const GlobalContaminationCard({super.key});

  @override
  State<GlobalContaminationCard> createState() =>
      GlobalContaminationCardState();
}

class GlobalContaminationCardState
    extends State<GlobalContaminationCard> {
  late String date;
  /* late double critical;
  late double notCritical; */
  late List<GlobalResponse> globalData;
  bool loaded = false;
  late List<BarChartGroupData> finalGroups;

  final betweenSpace = 0;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    globalData = await APIRequest().getGlobalData();
    List<BarChartGroupData> groups = [];
    for (var i = 0; i < 6; i++) {
      Color color;
      switch(i) {
        case 0:
          color = Colors.red;
          break;
        case 1:
          color = Colors.amber;
          break;
        case 2: 
          color = Colors.blue;
          break;
        case 3: 
          color = Colors.green;
          break;
        case 4:
          color = Colors.purple;
          break;
        case 5:
          color = Colors.teal;
          break;
        default: 
          color = Colors.black;
      } 
      groups.add(BarChartGroupData(
        x: i,
        groupVertically: true,
        barRods: [
          BarChartRodData(
            fromY: 0,
            toY: (globalData[i].active / 10000).toDouble(),
            color: color,
            width: 30,
          )
        ],
      ));
    }
    setState(() {
      date = DateTime.fromMillisecondsSinceEpoch(globalData.first.updated)
          .toString()
          .substring(0, 16);
      finalGroups = groups;
      loaded = true;
    });
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'North-Central America';
        break;
      case 1:
        text = 'Asia';
        break;
      case 2:
        text = 'Europe';
        break;
      case 3:
        text = 'South America';
        break;
      case 4:
        text = 'Australia-Oceania';
        break;
      case 5:
        text = 'Africa';
        break;
      default:
        text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  BarChartGroupData generateGroupData(
    int x,
    double pilates,
    double quickWorkout,
  ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: pilates,
          color: Colors.amber,
          width: 10,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: loaded == false
                ? const Center(child: CircularProgressIndicator())
                : Column(children: [
                    Row(children: [
                      const Text('Global active cases',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 30),
                      const Spacer(),
                      Text('Updated: $date',
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 15))
                    ]),
                    const SizedBox(height: 30),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Spacer(),
                          SizedBox(
                              height: 210,
                              width: 550,
                              child: BarChart(BarChartData(
                                  alignment: BarChartAlignment.spaceBetween,
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(),
                                    rightTitles: AxisTitles(),
                                    topTitles: AxisTitles(),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: bottomTitles,
                                        reservedSize: 20,
                                      ),
                                    ),
                                  ),
                                  barTouchData: BarTouchData(enabled: false),
                                  borderData: FlBorderData(show: false),
                                  gridData: FlGridData(show: false),
                                  barGroups: finalGroups,
                                  maxY: 1500))
                              ),
                          const Spacer(),
                        ]),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Data from Disease.sh API',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 15))
                      ],
                    )
                  ])));
  }
}
