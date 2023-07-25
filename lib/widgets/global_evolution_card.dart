//import 'package:covid19_data_explorer/services/http_request.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
//import 'package:numeral/numeral.dart';

class GlobalEvolutionCard extends StatefulWidget {
  const GlobalEvolutionCard({super.key});

  @override
  State<GlobalEvolutionCard> createState() => GlobalEvolutionCardState();
}

class GlobalEvolutionCardState extends State<GlobalEvolutionCard> {
  late List<LineChartBarData> data1 = [];

  @override
  void initState() {
    data1 = [
      LineChartBarData(
          isCurved: true,
          color: Colors.blue,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
          spots: const [
            FlSpot(0, 0.000557),
            FlSpot(1, 0.078608),
            FlSpot(2, 0.339156),
            FlSpot(3, 2.654011),
            FlSpot(4, 5.223477),
            FlSpot(5, 9.082502),
            FlSpot(6, 15.231791),
            FlSpot(7, 23.261601),
            FlSpot(8, 31.668754),
            FlSpot(9, 41.778168),
            FlSpot(10, 58.785996),
            FlSpot(11, 78.227986),
            FlSpot(12, 98.526596),
            FlSpot(13, 112.141380),
            FlSpot(14, 124.150452),
            FlSpot(15, 145.220252),
            FlSpot(16, 166.895763),
            FlSpot(17, 179.701349),
            FlSpot(18, 193.094403),
            FlSpot(19, 212.402204),
            FlSpot(20, 230.604815),
            FlSpot(21, 258.500870),
            FlSpot(22, 277.566671),
            FlSpot(23, 349.801473),
            FlSpot(24, 428.169102),
            FlSpot(25, 474.730951),
            FlSpot(26, 509.326073),
            FlSpot(27, 525.862056),
            FlSpot(28, 541.984328),
            FlSpot(29, 569.227609),
            FlSpot(30, 597.060819),
            FlSpot(31, 614.365390),
            FlSpot(32, 627.745374),
            FlSpot(33, 639.328415),
            FlSpot(34, 655.963530),
            FlSpot(35, 668.830077),
            FlSpot(36, 674.569824),
          ]),
      LineChartBarData(
          isCurved: true,
          color: Colors.green,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
          spots: const [
            FlSpot(0, 0.000030),
            FlSpot(1, 0.022892),
            FlSpot(2, 0.710017),
            FlSpot(3, 2.053576),
            FlSpot(4, 4.526440),
            FlSpot(5, 8.647437),
            FlSpot(6, 14.921384),
            FlSpot(7, 21.733546),
            FlSpot(8, 28.388093),
            FlSpot(9, 37.520305),
            FlSpot(10, 44.086739),
            FlSpot(11, 54.147168),
            FlSpot(12, 63.016513),
            FlSpot(13, 83.128166),
            FlSpot(14, 103.118308),
            FlSpot(15, 117.107408),
            FlSpot(16, 126.671708),
          ]),
      LineChartBarData(
        isCurved: true,
        color: Colors.red,
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(0, 0.000017),
          FlSpot(1, 0.002462),
          FlSpot(2, 0.203205),
          FlSpot(3, 0.368901),
          FlSpot(4, 0.513205),
          FlSpot(5, 0.672857),
          FlSpot(6, 0.862838),
          FlSpot(7, 1.036127),
          FlSpot(8, 1.206346),
          FlSpot(9, 1.463040),
          FlSpot(10, 1.797308),
          FlSpot(11, 2.198512),
          FlSpot(12, 2.573874),
          FlSpot(13, 3.201909),
          FlSpot(14, 3.595588),
          FlSpot(15, 3.911876),
          FlSpot(16, 4.165094),
          FlSpot(17, 4.458738),
          FlSpot(18, 4.747809),
          FlSpot(19, 4.968369),
          FlSpot(20, 5.188530),
          FlSpot(21, 5.411559),
          FlSpot(22, 5.626133),
          FlSpot(23, 5.935518),
          FlSpot(24, 6.245549),
          FlSpot(25, 6.303048),
          FlSpot(26, 6.348658),
          FlSpot(27, 6.403118),
          FlSpot(28, 6.474866),
          FlSpot(29, 6.535513),
          FlSpot(30, 6.580259),
          FlSpot(31, 6.625184),
          FlSpot(32, 6.676603),
          FlSpot(33, 6.813633),
          FlSpot(34, 6.881802)
        ],
      ),
    ];

    super.initState();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 100:
        text = const Text('100M', style: style);
        break;
      case 200:
        text = const Text('200M', style: style);
        break;
      case 300:
        text = const Text('300M', style: style);
        break;
      case 400:
        text = const Text('400M', style: style);
        break;
      case 500:
        text = const Text('500M', style: style);
        break;
      case 600:
        text = const Text('600M', style: style);
        break;
      case 700:
        text = const Text('700M', style: style);
        break;
      default:
        text = const Text('');
        break;
    }
    /* switch (value.toInt()) {
      case 10:
        text = const Text('Jan 2020', style: style);
        break;
      case 5:
        text = const Text('July', style: style);
        break;
      case 11:
        text = const Text('Jan 2021', style: style);
        break;
      case 17:
        text = const Text('July', style: style);
        break;
      case 23:
        text = const Text('Jan 2022', style: style);
        break;
      case 29:
        text = const Text('July', style: style);
        break;
      case 35:
        text = const Text('Jan 2023', style: style);
        break;
      default:
        text = const Text('');
        break;
    }  */

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Jan 2020', style: style);
        break;
      case 5:
        text = const Text('July', style: style);
        break;
      case 11:
        text = const Text('Jan 2021', style: style);
        break;
      case 17:
        text = const Text('July', style: style);
        break;
      case 23:
        text = const Text('Jan 2022', style: style);
        break;
      case 29:
        text = const Text('July', style: style);
        break;
      case 35:
        text = const Text('Jan 2023', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  FlTitlesData get _titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          //sideTitles: SideTitles(showTitles: false)
          sideTitles: SideTitles(
            getTitlesWidget: leftTitleWidgets,
            showTitles: true,
            interval: 1,
            reservedSize: 50,
          ),
        ),
      );

/*   _getData(String type) {
    var finalData = [];
    // ignore: avoid_init_to_null
    var selected = null;
    switch (type) {
      case 'cases':
        {
          selected = 0;
        }
        break;

      case 'deaths':
        {
          selected = 1;
        }
        break;

      case 'recovered':
        {
          selected = 2;
        }
        break;
    }
    for (var i = 0; i < _globalEvolutionData[selected].length; i++) {
      var y = _globalEvolutionData[selected][i];
      finalData.add(FlSpot(i.toDouble(), y));
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              Row(
                children: const [
                  Text('Global data evolution',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Spacer(),
                  CircleAvatar(backgroundColor: Colors.blue, radius: 10),
                  SizedBox(width: 5),
                  Text('Cases'),
                  SizedBox(width: 30),
                  CircleAvatar(backgroundColor: Colors.green, radius: 10),
                  SizedBox(width: 5),
                  Text('Recovered'),
                  SizedBox(width: 30),
                  CircleAvatar(backgroundColor: Colors.red, radius: 10),
                  SizedBox(width: 5),
                  Text('Deaths')
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                  height: 400,
                  width: 1000,
                  child: LineChart(
                      LineChartData(
                        titlesData: _titlesData,
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        lineBarsData: data1,
                        minX: 0,
                        maxX: 40,
                        maxY: 700,
                        minY: 0,
                      ),
                      swapAnimationDuration:
                          const Duration(milliseconds: 150), // Optional
                      swapAnimationCurve: Curves.linear)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text('Data from Disease.sh API',
                      style: TextStyle(color: Colors.black54, fontSize: 15))
                ],
              )
            ])));
  }
}
