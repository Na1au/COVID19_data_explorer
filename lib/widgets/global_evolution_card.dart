import 'package:covid19_data_explorer/services/http_request.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:numeral/numeral.dart';

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
            FlSpot(0, 557.0),
            FlSpot(1, 78608.0),
            FlSpot(2, 339156.0),
            FlSpot(3, 2654011.0),
            FlSpot(4, 5223477.0),
            FlSpot(5, 9082502.0),
            FlSpot(6, 15231791.0),
            FlSpot(7, 23261601.0),
            FlSpot(8, 31668754.0),
            FlSpot(9, 41778168.0),
            FlSpot(10, 58785996.0),
            FlSpot(11, 78227986.0),
            FlSpot(12, 98526596.0),
            FlSpot(13, 112141380.0),
            FlSpot(14, 124150452.0),
            FlSpot(15, 145220252.0),
            FlSpot(16, 166895763.0),
            FlSpot(17, 179701349.0),
            FlSpot(18, 193094403.0),
            FlSpot(19, 212402204.0),
            FlSpot(20, 230604815.0),
            FlSpot(21, 258500870.0),
            FlSpot(22, 277566671.0),
            FlSpot(23, 349801473.0),
            FlSpot(24, 428169102.0),
            FlSpot(25, 474730951.0),
            FlSpot(26, 509326073.0),
            FlSpot(27, 525862056.0),
            FlSpot(28, 541984328.0),
            FlSpot(29, 569227609.0),
            FlSpot(30, 597060819.0),
            FlSpot(31, 614365390.0),
            FlSpot(32, 627745374.0),
            FlSpot(33, 639328415.0),
            FlSpot(34, 655963530.0),
            FlSpot(35, 668830077.0),
            FlSpot(36, 674569824.0),
          ]),
      LineChartBarData(
          isCurved: true,
          color: Colors.green,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
          spots: const [
            FlSpot(0, 30.0),
            FlSpot(1, 22892.0),
            FlSpot(2, 710017.0),
            FlSpot(3, 2053576.0),
            FlSpot(4, 4526440.0),
            FlSpot(5, 8647437.0),
            FlSpot(6, 14921384.0),
            FlSpot(7, 21733546.0),
            FlSpot(8, 28388093.0),
            FlSpot(9, 37520305.0),
            FlSpot(10, 44086739.0),
            FlSpot(11, 54147168.0),
            FlSpot(12, 63016513.0),
            FlSpot(13, 83128166.0),
            FlSpot(14, 103118308.0),
            FlSpot(15, 117107408.0),
            FlSpot(16, 126671708.0),
          ]),
      LineChartBarData(
        isCurved: true,
        color: Colors.red,
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(0, 17.0),
          FlSpot(1, 2462.0),
          FlSpot(2, 203205.0),
          FlSpot(3, 368901.0),
          FlSpot(4, 513205.0),
          FlSpot(5, 672857.0),
          FlSpot(6, 862838.0),
          FlSpot(7, 1036127.0),
          FlSpot(8, 1206346.0),
          FlSpot(9, 1463040.0),
          FlSpot(10, 1797308.0),
          FlSpot(11, 2198512.0),
          FlSpot(12, 2573874.0),
          FlSpot(13, 3201909.0),
          FlSpot(14, 3595588.0),
          FlSpot(15, 3911876.0),
          FlSpot(16, 4165094.0),
          FlSpot(17, 4458738.0),
          FlSpot(18, 4747809.0),
          FlSpot(19, 4968369.0),
          FlSpot(20, 5188530.0),
          FlSpot(21, 5411559.0),
          FlSpot(22, 5626133.0),
          FlSpot(23, 5935518.0),
          FlSpot(24, 6245549.0),
          FlSpot(25, 6303048.0),
          FlSpot(26, 6348658.0),
          FlSpot(27, 6403118.0),
          FlSpot(28, 6474866.0),
          FlSpot(29, 6535513.0),
          FlSpot(30, 6580259.0),
          FlSpot(31, 6625184.0),
          FlSpot(32, 6676603.0),
          FlSpot(33, 6813633.0),
          FlSpot(34, 6881802.0)
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
      case 1000:
        text = const Text('1M', style: style);
        break;
      case 2000:
        text = const Text('2M', style: style);
        break;
      case 3000:
        text = const Text('3M', style: style);
        break;
      case 4000:
        text = const Text('5M', style: style);
        break;
      case 5000:
        text = const Text('6M', style: style);
        break;
      default:
        return Container();
    }

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
          sideTitles: SideTitles(
            getTitlesWidget: leftTitleWidgets,
            showTitles: true,
            interval: 1,
            reservedSize: 40,
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
                      /*  lineTouchData: lineTouchData1,
        gridData: gridData,
        borderData: borderData, */
                      lineBarsData: data1,
                      minX: 0,
                      maxX: 40,
                      maxY: 700000000,
                      minY: 0,
                    ),
                    swapAnimationDuration:
                        Duration(milliseconds: 150), // Optional
                    swapAnimationCurve: Curves.linear, // Optional
                  )),
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

/* var _globalEvolutionData = [
  [
    557.0,
    78608.0,
    339156.0,
    2654011.0,
    5223477.0,
    9082502.0,
    15231791.0,
    23261601.0,
    31668754.0,
    41778168.0,
    58785996.0,
    78227986.0,
    98526596.0,
    112141380.0,
    124150452.0,
    145220252.0,
    166895763.0,
    179701349.0,
    193094403.0,
    212402204.0,
    230604815.0,
    258500870.0,
    277566671.0,
    349801473.0,
    428169102.0,
    474730951.0,
    509326073.0,
    525862056.0,
    541984328.0,
    569227609.0,
    597060819.0,
    614365390.0,
    627745374.0,
    639328415.0,
    655963530.0,
    668830077.0,
    674569824.0,
  ],
  [
    17.0,
    2462.0,
    203205.0,
    368901.0,
    513205.0,
    672857.0,
    862838.0,
    1036127.0,
    1206346.0,
    1463040.0,
    1797308.0,
    2198512.0,
    2573874.0,
    3201909.0,
    3595588.0,
    3911876.0,
    4165094.0,
    4458738.0,
    4747809.0,
    4968369.0,
    5188530.0,
    5411559.0,
    5626133.0,
    5935518.0,
    6245549.0,
    6303048.0,
    6348658.0,
    6403118.0,
    6474866.0,
    6535513.0,
    6580259.0,
    6625184.0,
    6676603.0,
    6813633.0,
    6881802.0
  ],
  [
    30.0,
    22892.0,
    710017.0,
    2053576.0,
    4526440.0,
    8647437.0,
    14921384.0,
    21733546.0,
    28388093.0,
    37520305.0,
    44086739.0,
    54147168.0,
    63016513.0,
    83128166.0,
    103118308.0,
    117107408.0,
    126671708.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0
  ]
];
 */