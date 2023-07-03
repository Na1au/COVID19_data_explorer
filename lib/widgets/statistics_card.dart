import 'package:covid19_data_explorer/services/http_request.dart';
import 'package:flutter/material.dart';

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
      cases = data.cases;
      deaths = data.deaths;
      tests = data.tests;
      recovered = data.recovered;
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loaded == false ? CircularProgressIndicator() : Card(
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
                    children: [
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
                      ]),
                    ]),
              ],
            )));
  }
}
