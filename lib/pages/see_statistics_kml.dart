import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:covid19_data_explorer/services/http_request.dart';
import 'package:numeral/numeral.dart';

class StatisticsKMLPage extends StatefulWidget {
  const StatisticsKMLPage(
      {super.key,
      required this.title,
      required this.usa,
      required this.canada,
      required this.mexico, required this.type, required this.total});
  final String title;
  final GlobalResponse usa;
  final GlobalResponse canada;
  final GlobalResponse mexico;
  final String type;
  final int total;

  @override
  State<StatisticsKMLPage> createState() {
    return StatisticsKMLPageState();
  }
}

class StatisticsKMLPageState extends State<StatisticsKMLPage> {
  late double usaValue;
  late double canadaValue;
  late double mexicoValue;
  bool loaded = false;

  @override
  void initState() {
    if (widget.type == 'cases') {
      usaValue = widget.usa.cases.toDouble();
      canadaValue = widget.canada.cases.toDouble();
      mexicoValue = widget.mexico.cases.toDouble();
    } else if (widget.type == 'deaths') {
      usaValue = widget.usa.deaths.toDouble();
      canadaValue = widget.canada.deaths.toDouble();
      mexicoValue = widget.mexico.deaths.toDouble();
    } else if (widget.type == 'tests') {
      usaValue = widget.usa.tests.toDouble();
      canadaValue = widget.canada.tests.toDouble();
      mexicoValue = widget.mexico.tests.toDouble();
    } else if (widget.type == 'recovered') {
      usaValue = widget.usa.recovered.toDouble();
      canadaValue = widget.canada.recovered.toDouble();
      mexicoValue = widget.mexico.recovered.toDouble();
    }
    super.initState();
    loaded = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
          child: loaded == false ? CircularProgressIndicator() : Column(
        children: [
          const SizedBox(height: 50),
          Container(
            alignment: Alignment.center,
            width: 300,
            height: 300,
            child: PieChart(
              PieChartData(sections: [
                PieChartSectionData(
                    value: usaValue, color: Colors.blue, title: 'USA'),
                PieChartSectionData(
                    value: canadaValue, color: Colors.amber, title: 'Canada'),
                PieChartSectionData(
                    value: mexicoValue,
                    color: Color.fromARGB(255, 250, 170, 146),
                    title: 'Mexico')
              ]),
              swapAnimationDuration:
                  const Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear, // Optional
            ),
          ),
          const SizedBox(height: 20),
          Text('Total ${widget.type}: ${numeral(widget.total)}'),
          const SizedBox(height: 50),
          ElevatedButton(
              onPressed: () {}, child: const Text('See on Liquid Galaxy'))
        ],
      )),
    );
  }
}
