import 'package:covid19_data_explorer/pages/about_page.dart';
import 'package:covid19_data_explorer/services/lg_connection.dart';
import 'package:covid19_data_explorer/widgets/global_contamination_card.dart';
import 'package:covid19_data_explorer/widgets/global_evolution_card.dart';
import 'package:flutter/material.dart';
import 'config_page.dart';
import 'package:covid19_data_explorer/widgets/statistics_card.dart';
import 'package:covid19_data_explorer/widgets/new_data_card.dart';
import 'package:covid19_data_explorer/services/http_request.dart';

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
  bool loadedData = false;
  late List<GlobalResponse> globalData;
  late List<CountryResponse> countriesData;
  String date = '';

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    globalData = await APIRequest().getGlobalData();
    countriesData = await APIRequest().getContinentData();
    _buildNewCardContent();
    setState(() {
      loadedData = true;
    });
  }

  List<Widget> _buildNewCardContent() {
    var types = ['cases', 'deaths', 'recovered'];
    List<Widget> newData = [];
    date = DateTime.fromMillisecondsSinceEpoch(globalData.first.updated)
        .toString()
        .substring(0, 16);
    for (var i = 0; i < 3; i++) {
      newData.add(SizedBox(
          height: 410,
          width: 420,
          child:
              NewDataCard(globalData: globalData, type: types[i], date: date, continentData: countriesData)));
    }
    return newData;
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

  List<Widget> notLoaded() {
    return const [
      SizedBox(
          height: 400,
          width: 420,
          child: Card(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()))),
      SizedBox(
          height: 400,
          width: 420,
          child: Card(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()))),
      SizedBox(
          height: 400,
          width: 420,
          child: Card(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()))),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (loaded == false) checkConnection();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Row(children: [
            Icon(Icons.coronavirus_outlined, size: 35),
            SizedBox(width: 15),
            Text('COVID-19 DATA EXPLORER'),
          ]),
          actions: [
            Chip(
                label: Row(children: [
                  const Text('Connection: '),
                  isConnected == true
                      ? const Icon(
                          Icons.circle,
                          color: Colors.green,
                          size: 20,
                        )
                      : const Icon(
                          Icons.circle,
                          color: Colors.red,
                          size: 20,
                        )
                ]),
                backgroundColor: Colors.white),
            const SizedBox(width: 15),
            IconButton(
                iconSize: 35,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ConfigPage()));
                },
                icon: const Icon(Icons.settings)),
            IconButton(
                iconSize: 35,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AboutPage()));
                },
                icon: const Icon(Icons.info))
          ],
        ),
        body: Center(
          child: Container(
              color: Theme.of(context).colorScheme.background,
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                              height: 350, width: 510, child: StatisticsCard()),
                          SizedBox(
                              height: 350,
                              width: 750,
                              child: GlobalContaminationCard())
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: loadedData ? _buildNewCardContent() : notLoaded()),
                    const GlobalEvolutionCard()
                  ],
                ),
              )),
        ));
  }
}
