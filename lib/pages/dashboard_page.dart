import 'package:covid19_data_explorer/pages/about_page.dart';
import 'package:covid19_data_explorer/pages/search_page.dart';
import 'package:covid19_data_explorer/services/lg_connection.dart';
//import 'package:covid19_data_explorer/services/http_request.dart';
import 'package:covid19_data_explorer/widgets/global_contamination_card.dart';
import 'package:covid19_data_explorer/widgets/global_evolution_card.dart';
//import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'config_page.dart';
import 'package:covid19_data_explorer/widgets/statistics_card.dart';
//import 'statistics_detail_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() {
    return DashboardPageState();
  }
}

class DashboardPageState extends State<DashboardPage> {
  bool isConnected = false;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
  }

  init() async {
    await checkConnection();

    loaded = true;
  }

  checkConnection() async {
    bool res = await LGConnection().checkConnection();
    setState(() {
      isConnected = res;
    });
    loaded = true;
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) checkConnection();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(children: [
            const Icon(Icons.coronavirus_outlined),
            const SizedBox(width: 15),
            const Text('COVID-19 DATA EXPLORER'),
            Spacer(),
            //const SizedBox(width: 50),
            Text(
              isConnected == true ? 'CONNECTED' : 'DISCONNECTED',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            isConnected == true
                ? const Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 25,
                  )
                : const Icon(
                    Icons.circle,
                    color: Colors.red,
                    size: 25,
                  ),
            Spacer()
          ]),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SearchPage()));
                },
                icon: const Icon(Icons.search)),
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
              children: const [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    child: Column(
                      children: [
                        // Statistics card
                        StatisticsCard(),
                        SizedBox(height: 15),
                        //Total cases card
                        GlobalContaminationCard(),
                        SizedBox(height: 15),
                        //Global contamination evolution card
                        GlobalEvolutionCard()
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}

kml() {}
