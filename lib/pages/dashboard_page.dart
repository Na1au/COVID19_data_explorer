import 'package:covid19_data_explorer/pages/about_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'config_page.dart';
import 'package:covid19_data_explorer/widgets/statistics_card.dart';
import 'statistics_detail_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() {
    return DashboardPageState();
  }
}

class DashboardPageState extends State<DashboardPage> {
  final avgColor = Colors.blue;
  final leftBarColor = Colors.red;
  final rigthBarColor = Colors.orange;
  final betweenSpace = 0.2;

  BarChartGroupData generateGroupData(
    int x,
    double pilates,
    double quickWorkout,
    double cycling,
  ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: pilates,
          color: leftBarColor,
          width: 5,
        ),
        BarChartRodData(
          fromY: pilates + betweenSpace,
          toY: pilates + betweenSpace + quickWorkout,
          color: rigthBarColor,
          width: 5,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(children: const [
            Icon(Icons.coronavirus_outlined),
            SizedBox(width: 15),
            Text('COVID-19 DATA EXPLORER')
          ]),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ConfigPage()));
                },
                icon: const Icon(Icons.settings)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AboutPage()));
                },
                icon: const Icon(Icons.info))
          ],
        ),
        body: Center(
          child: Container(
            color: Colors.grey.shade200,
            width: double.infinity,
            height: double.infinity,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Column(
                      children: [
                        // Statistics card
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const StatisticsDetailPage(),
                              ),
                            );
                          },
                          child: const StatisticsCard(),
                        ),
                        const SizedBox(height: 15),
                        //Total cases cardx
                        Card(
                            color: Colors.white,
                            child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: const [
                                        Text('Total cases',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        Spacer(),
                                        CircleAvatar(
                                            backgroundColor: Colors.amber,
                                            radius: 10),
                                        SizedBox(width: 5),
                                        Text('Not critial'),
                                        SizedBox(width: 30),
                                        CircleAvatar(
                                            backgroundColor: Colors.red,
                                            radius: 10),
                                        SizedBox(width: 5),
                                        Text('Critical')
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                    Container(
                                      height: 200,
                                      width: 200,
                                      child: BarChart(
                                        BarChartData(
                                          alignment:
                                              BarChartAlignment.spaceBetween,
                                          titlesData: FlTitlesData(
                                            show: true,
                                            leftTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                reservedSize: 28,
                                                interval: 1,
                                                getTitlesWidget: leftTitles,
                                              ),
                                            ),
                                            bottomTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                getTitlesWidget: bottomTitles,
                                                reservedSize: 42,
                                              ),
                                            ),
                                          ),
                                          barTouchData:
                                              BarTouchData(enabled: false),
                                          borderData: FlBorderData(show: false),
                                          gridData: FlGridData(show: false),
                                          barGroups: [
                                            generateGroupData(0, 2, 3, 2),
                                            generateGroupData(1, 2, 5, 1.7),
                                            generateGroupData(2, 1.3, 3.1, 2.8),
                                            generateGroupData(3, 3.1, 4, 3.1),
                                            generateGroupData(4, 0.8, 3.3, 3.4),
                                          ],
                                        ),
                                        swapAnimationDuration: const Duration(
                                            milliseconds: 150), // Optional
                                        swapAnimationCurve:
                                            Curves.linear, // Optional
                                      ),
                                    )
                                  ],
                                )))
                      ],
                    ))
              ],
            ),
          ),
        ));
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }
}

kml() {

}