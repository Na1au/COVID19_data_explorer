import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
          color: Colors.amber,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
          spots: const [
            FlSpot(0, 0.0000557),
            FlSpot(1, 0.0078608),
            FlSpot(2, 0.0339156),
            FlSpot(3, 0.2654011),
            FlSpot(4, 0.5223477),
            FlSpot(5, 0.9082502),
            FlSpot(6, 1.5231791),
            FlSpot(7, 2.3261601),
            FlSpot(8, 3.1668754),
            FlSpot(9, 4.1778168),
            FlSpot(10, 5.8785996),
            FlSpot(11, 7.8227986),
            FlSpot(12, 9.8526596),
            FlSpot(13, 11.2141380),
            FlSpot(14, 12.4150452),
            FlSpot(15, 14.5220252),
            FlSpot(16, 16.6895763),
            FlSpot(17, 17.9701349),
            FlSpot(18, 19.3094403),
            FlSpot(19, 21.2402204),
            FlSpot(20, 23.0604815),
            FlSpot(21, 25.8500870),
            FlSpot(22, 27.7566671),
            FlSpot(23, 34.9801473),
            FlSpot(24, 42.8169102),
            FlSpot(25, 47.4730951),
            FlSpot(26, 50.9326073),
            FlSpot(27, 52.5862056),
            FlSpot(28, 54.1984328),
            FlSpot(29, 56.9227609),
            FlSpot(30, 59.7060819),
            FlSpot(31, 61.4365390),
            FlSpot(32, 62.7745374),
            FlSpot(33, 63.9328415),
            FlSpot(34, 65.5963530),
            FlSpot(35, 66.8830077),
            FlSpot(36, 67.4569824),
          ]),
      LineChartBarData(
          isCurved: true,
          color: Colors.blue,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
          spots: const [
            FlSpot(0, 0.0000030),
            FlSpot(1, 0.0022892),
            FlSpot(2, 0.0710017),
            FlSpot(3, 0.2053576),
            FlSpot(4, 0.4526440),
            FlSpot(5, 0.8647437),
            FlSpot(6, 1.4921384),
            FlSpot(7, 2.1733546),
            FlSpot(8, 2.8388093),
            FlSpot(9, 3.7520305),
            FlSpot(10, 4.4086739),
            FlSpot(11, 5.4147168),
            FlSpot(12, 6.3016513),
            FlSpot(13, 8.3128166),
            FlSpot(14, 10.3118308),
            FlSpot(15, 11.7107408),
            FlSpot(16, 12.6671708),
          ]),
      LineChartBarData(
        isCurved: true,
        color: Colors.red,
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(0, 0.0000017),
          FlSpot(1, 0.0002462),
          FlSpot(2, 0.0203205),
          FlSpot(3, 0.0368901),
          FlSpot(4, 0.0513205),
          FlSpot(5, 0.0672857),
          FlSpot(6, 0.0862838),
          FlSpot(7, 0.1036127),
          FlSpot(8, 0.1206346),
          FlSpot(9, 0.1463040),
          FlSpot(10, 0.1797308),
          FlSpot(11, 0.2198512),
          FlSpot(12, 0.2573874),
          FlSpot(13, 0.3201909),
          FlSpot(14, 0.3595588),
          FlSpot(15, 0.3911876),
          FlSpot(16, 0.4165094),
          FlSpot(17, 0.4458738),
          FlSpot(18, 0.4747809),
          FlSpot(19, 0.4968369),
          FlSpot(20, 0.5188530),
          FlSpot(21, 0.5411559),
          FlSpot(22, 0.5626133),
          FlSpot(23, 0.5935518),
          FlSpot(24, 0.6245549),
          FlSpot(25, 0.6303048),
          FlSpot(26, 0.6348658),
          FlSpot(27, 0.6403118),
          FlSpot(28, 0.6474866),
          FlSpot(29, 0.6535513),
          FlSpot(30, 0.6580259),
          FlSpot(31, 0.6625184),
          FlSpot(32, 0.6676603),
          FlSpot(33, 0.6813633),
          FlSpot(34, 0.6881802),
          FlSpot(35, 0.6799459),
          FlSpot(36, 0.6881802)
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
      case 10:
        text = const Text('10M', style: style);
        break;
      case 20:
        text = const Text('20M', style: style);
        break;
      case 30:
        text = const Text('30M', style: style);
        break;
      case 40:
        text = const Text('40M', style: style);
        break;
      case 50:
        text = const Text('50M', style: style);
        break;
      case 60:
        text = const Text('60M', style: style);
        break;
      case 70:
        text = const Text('70M', style: style);
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

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              const Row(
                children: [
                  Text('Global data evolution',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Spacer(),
                  CircleAvatar(backgroundColor: Colors.amber, radius: 10),
                  SizedBox(width: 5),
                  Text('Cases'),
                  SizedBox(width: 30),
                  CircleAvatar(backgroundColor: Colors.blue, radius: 10),
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
                        lineTouchData: LineTouchData(
                            touchTooltipData: LineTouchTooltipData(
                                tooltipBorder: BorderSide(
                                    width: 1,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                tooltipBgColor: Colors.white)),
                        titlesData: _titlesData,
                        gridData: FlGridData(
                          show: true,
                          checkToShowHorizontalLine: (value) => value % 10 == 0,
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: Theme.of(context).colorScheme.background,
                            strokeWidth: 1,
                          ),
                          drawVerticalLine: false,
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: data1,
                        minX: 0,
                        maxX: 40,
                        maxY: 70,
                        minY: 0,
                      ),
                      swapAnimationDuration:
                          const Duration(milliseconds: 150), // Optional
                      swapAnimationCurve: Curves.linear)),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Data from Athena API',
                      style: TextStyle(color: Colors.black54, fontSize: 15))
                ],
              )
            ])));
  }
}
