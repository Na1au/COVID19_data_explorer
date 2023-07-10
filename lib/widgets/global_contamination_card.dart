import 'package:covid19_data_explorer/services/http_request.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:numeral/numeral.dart';

class GlobalContaminationCard extends StatefulWidget {
  const GlobalContaminationCard({super.key});

  @override
  State<GlobalContaminationCard> createState() =>
      GlobalContaminationCardState();
}

class GlobalContaminationCardState extends State<GlobalContaminationCard> {
  late String date;
  late double critical;
  late double notCritical;
  bool loaded = false;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    GlobalResponse data =
        await APIRequest().get('https://corona.lmao.ninja/v2/all');
    setState(() {
      date = DateTime.fromMillisecondsSinceEpoch(data.updated)
          .toString()
          .substring(0, 16);
      critical = data.critical.toDouble() / 10;
      notCritical = (data.active.toDouble() - critical) / 10;
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loaded == false
        ? const CircularProgressIndicator()
        : Card(
            color: Colors.white,
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(children: [
                  Row(
                    children: [
                      const Text('Total cases',
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
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Spacer(),
                      CircleAvatar(backgroundColor: Colors.amber, radius: 10),
                      SizedBox(width: 5),
                      Text('Not critical: ${numeral(notCritical.toInt())}'),
                      SizedBox(width: 30),
                      CircleAvatar(backgroundColor: Colors.red, radius: 10),
                      SizedBox(width: 5),
                      Text('Critical: ${numeral(critical.toInt())}')
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 300,
                    width: 300,
                    child: PieChart(
                      PieChartData(sections: [
                        PieChartSectionData(
                            value: critical,
                            color: Colors.red,
                            title: 'Critical'),
                        PieChartSectionData(
                            value: notCritical,
                            color: Colors.amber,
                            title: 'Not critical'),
                      ]),
                      swapAnimationDuration:
                          const Duration(milliseconds: 150), // Optional
                      swapAnimationCurve: Curves.linear, // Optional
                    ),
                  ),
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
