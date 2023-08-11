import 'package:covid19_data_explorer/pages/see_statistics_kml.dart';
import 'package:covid19_data_explorer/services/http_request.dart';
import 'package:flutter/material.dart';
import 'package:numeral/numeral.dart';

class NewDataCard extends StatefulWidget {
  const NewDataCard(
      {super.key,
      required this.globalData,
      required this.type,
      required this.date,
      required this.continentData});
  final List<GlobalResponse> globalData;
  final List<CountryResponse> continentData;
  final String type;
  final String date;

  @override
  State<NewDataCard> createState() => NewDataCardState();
}

class NewDataCardState extends State<NewDataCard> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildContent() {
    var colors = [
      Colors.red,
      Colors.amber,
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.teal
    ];
    var continents = <Widget>[];
    for (var i = 0; i < widget.globalData.length; i++) {
      int data;
      switch (widget.type) {
        case 'cases':
          data = widget.globalData[i].todayCases;
          break;
        case 'deaths':
          data = widget.globalData[i].todayDeaths;
          break;
        default:
          data = widget.globalData[i].todayRecovered;
      }
      continents.add(Expanded(
        child: ListTile(
            onTap: () {
              var finalTitle = widget.globalData[i].continent == 'North America'
                  ? 'North and Central America'
                  : widget.globalData[i].continent;
              if (data > 0) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => StatisticsKMLPage(
                      title: '$finalTitle today ${widget.type}',
                      type: widget.type == 'cases'
                          ? 'todayCases'
                          : widget.type == 'deaths'
                              ? 'todayDeaths'
                              : 'todayRecovered',
                      total: data,
                      continent: widget.globalData[i].continent,
                      totalContinents: widget.continentData),
                ));
              }
            },
            leading: CircleAvatar(
              backgroundColor: colors[i].withAlpha(150),
              radius: 30,
              child: Text(widget.globalData[i].continent.substring(0, 1),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colors[i].shade800)),
            ),
            title: Text(widget.globalData[i].continent == 'North America'
                ? 'North and Central America'
                : widget.globalData[i].continent),
            subtitle: Text(numeral(data))),
      ));
    }
    var finalContinents = Column(children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [continents[0], continents[1]]),
      const SizedBox(height: 20),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [continents[2], continents[3]]),
      const SizedBox(height: 20),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [continents[4], continents[5]])
    ]);
    return finalContinents;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Today ${widget.type}',
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text('Updated: ${widget.date}',
                      textAlign: TextAlign.end,
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 15))
                ],
              ),
              const SizedBox(height: 20),
              _buildContent(),
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Data from Disease.sh API',
                      style: TextStyle(color: Colors.black54, fontSize: 15))
                ],
              )
            ],
          )),
    );
  }
}
