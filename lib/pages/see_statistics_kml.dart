import 'dart:math';

import 'package:basic_utils/basic_utils.dart';
import 'package:covid19_data_explorer/services/kml_generator.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:covid19_data_explorer/services/http_request.dart';
import 'package:numeral/numeral.dart';
import 'package:covid19_data_explorer/services/lg_connection.dart';
import 'package:covid19_data_explorer/utils/coordinates.dart';

// ignore: must_be_immutable
class StatisticsKMLPage extends StatefulWidget {
  StatisticsKMLPage(
      {super.key,
      required this.title,
      required this.type,
      required this.total,
      required this.continent,
      required this.totalContinents});
  final String title;
  final String type;
  final int total;
  final String continent;
  final List<CountryResponse> totalContinents;
  final List<String> chartColors = [];
  final List<int> chartCountriesData = [];
  List<Widget> labels = [];
  List<Widget> labels2 = [];
  List<Widget> labels3 = [];
  List<Widget> labels4 = [];
  List<Widget> labels5 = [];
  List<PieChartSectionData> chartSections = [];
  String balloonLabels1 = '';
  String balloonLabels2 = '';
  List<CountryResponse> finalCountries = [];

  @override
  State<StatisticsKMLPage> createState() {
    return StatisticsKMLPageState();
  }
}

class StatisticsKMLPageState extends State<StatisticsKMLPage> {
  bool loaded = false;
  late List<CountryResponse> countriesData;
  bool sendKML = false;
  bool playTour = false;
  int orbitHeigth = 0;
  bool isConnected = false;
  bool connectionLoaded = false;

  @override
  void initState() {
    _buildData();
    _buildChartData(countriesData);
    super.initState();
    loaded = true;
  }

  init() async {
    await checkConnection();

    connectionLoaded = true;
  }

  checkConnection() async {
    bool res = await LGConnection().checkConnection();
    setState(() {
      isConnected = res;
    });
    connectionLoaded = true;
  }

  _buildData() {
    List<CountryResponse> total = [];
    var countries = widget.totalContinents;
    for (var i = 0; i < countries.length; i++) {
      if (countries[i].continent == widget.continent) {
        total.add(countries[i]);
      }
    }
    setState(() {
      countriesData = total;
    });
  }

  List<CountryResponse> _buildChartData(List<CountryResponse> countries) {
    List<CountryResponse> listCountries = [];
    List<Color> totalColors = [
      Colors.blue.shade400,
      Colors.blue.shade600,
      Colors.blue.shade800,
      Colors.blue.shade900,
      Colors.yellow.shade300,
      Colors.yellow.shade600,
      Colors.yellow.shade900,
      Colors.yellow.shade800,
      Colors.amber.shade900,
      Colors.teal.shade400,
      Colors.teal.shade700,
      Colors.teal.shade900,
      Colors.red.shade200,
      Colors.red.shade400,
      Colors.red.shade300,
      Colors.red.shade600,
      Colors.red.shade900,
      Colors.purple.shade400,
      Colors.purple.shade600,
      Colors.purple.shade800,
      Colors.purple.shade900,
      Colors.pink.shade400,
      Colors.pink.shade600,
      Colors.pink.shade800,
      Colors.pink.shade800,
      Colors.lime.shade600,
      Colors.lime.shade800,
      Colors.lime.shade900,
      Colors.indigo.shade400,
      Colors.indigo.shade700,
      Colors.indigo.shade900,
      Colors.grey.shade800,
      Colors.grey.shade900,
      Colors.green.shade400,
      Colors.green.shade600,
      Colors.green.shade800,
      Colors.green.shade900,
      Colors.cyan.shade600,
      Colors.cyan.shade800,
      Colors.cyan.shade900,
      Colors.brown.shade600,
      Colors.brown.shade800,
      Colors.brown.shade900,
    ];
    for (var i = 0; i < countries.length; i++) {
      widget.type == 'cases' &&
              countries[i].cases > 0 &&
              !noInfo.contains(countries[i].country)
          ? listCountries.add(countries[i])
          : widget.type == 'deaths' &&
                  countries[i].deaths > 0 &&
                  !noInfo.contains(countries[i].country)
              ? listCountries.add(countries[i])
              : widget.type == 'tests' &&
                      countries[i].tests > 0 &&
                      !noInfo.contains(countries[i].country)
                  ? listCountries.add(countries[i])
                  : widget.type == 'recovered' &&
                          countries[i].recovered > 0 &&
                          !noInfo.contains(countries[i].country)
                      ? listCountries.add(countries[i])
                      : widget.type == 'todayCases' &&
                              countries[i].todayCases > 0 &&
                              !noInfo.contains(countries[i].country)
                          ? listCountries.add(countries[i])
                          : widget.type == 'todayDeaths' &&
                                  countries[i].todayDeaths > 0 &&
                                  !noInfo.contains(countries[i].country)
                              ? listCountries.add(countries[i])
                              : widget.type == 'todayRecovered' &&
                                      countries[i].todayRecovered > 0 &&
                                      !noInfo.contains(countries[i].country)
                                  ? listCountries.add(countries[i])
                                  : null;
    }
    widget.finalCountries = listCountries;
    if (widget.finalCountries.length <= 12) {
      for (var i = 0; i < widget.finalCountries.length; i++) {
        var selectedData = widget.type == 'cases'
            ? widget.finalCountries[i].cases
            : widget.type == 'deaths'
                ? widget.finalCountries[i].deaths
                : widget.type == 'tests'
                    ? widget.finalCountries[i].tests
                    : widget.type == 'recovered'
                        ? widget.finalCountries[i].recovered
                        : widget.type == 'todayCases'
                            ? widget.finalCountries[i].todayCases
                            : widget.type == 'todayDeaths'
                                ? widget.finalCountries[i].todayDeaths
                                : widget.finalCountries[i].todayRecovered;
        var selectedColor = totalColors[Random().nextInt(totalColors.length)];
        widget.chartColors
            .add(ColorUtils.intToHex(selectedColor.value).substring(1));
        widget.chartCountriesData.add(selectedData);
        widget.chartSections.add(PieChartSectionData(
            value: selectedData.toDouble(),
            color: selectedColor,
            showTitle: false));
        widget.labels.add(Expanded(
            child: ListTile(
          leading: CircleAvatar(backgroundColor: selectedColor, radius: 15),
          title: Text(widget.finalCountries[i].country),
          subtitle: Text(numeral(selectedData)),
        )));
      }
    } else {
      for (var i = 0; i < widget.finalCountries.length; i++) {
        var selectedData = widget.type == 'cases'
            ? widget.finalCountries[i].cases
            : widget.type == 'deaths'
                ? widget.finalCountries[i].deaths
                : widget.type == 'tests'
                    ? widget.finalCountries[i].tests
                    : widget.type == 'recovered'
                        ? widget.finalCountries[i].recovered
                        : widget.type == 'todayCases'
                            ? widget.finalCountries[i].todayCases
                            : widget.type == 'todayDeaths'
                                ? widget.finalCountries[i].todayDeaths
                                : widget.finalCountries[i].todayRecovered;
        var selectedColor = totalColors[Random().nextInt(totalColors.length)];
        widget.chartColors
            .add(ColorUtils.intToHex(selectedColor.value).substring(1));
        widget.chartCountriesData.add(selectedData);
        widget.chartSections.add(PieChartSectionData(
            value: selectedData.toDouble(),
            color: selectedColor,
            showTitle: false));

        if (i <= 11) {
          widget.labels.add(Expanded(
              child: ListTile(
                  leading:
                      CircleAvatar(backgroundColor: selectedColor, radius: 15),
                  title: Text(widget.finalCountries[i].country,
                      style: const TextStyle(fontSize: 13)),
                  subtitle: Text(numeral(selectedData),
                      style: const TextStyle(fontSize: 10)))));
        }
        if (i >= 12 && i < 24) {
          widget.labels2.add(Expanded(
              child: ListTile(
            leading: CircleAvatar(backgroundColor: selectedColor, radius: 15),
            title: Text(widget.finalCountries[i].country,
                style: const TextStyle(fontSize: 13)),
            subtitle: Text(numeral(selectedData),
                style: const TextStyle(fontSize: 10)),
          )));
        }
        if (i >= 24 && i < 36) {
          widget.labels3.add(Expanded(
              child: ListTile(
            leading: CircleAvatar(backgroundColor: selectedColor, radius: 15),
            title: Text(widget.finalCountries[i].country,
                style: const TextStyle(fontSize: 13)),
            subtitle: Text(numeral(selectedData),
                style: const TextStyle(fontSize: 10)),
          )));
        }
        if (i >= 36 && i < 48) {
          widget.labels4.add(Expanded(
              child: ListTile(
            leading: CircleAvatar(backgroundColor: selectedColor, radius: 15),
            title: Text(widget.finalCountries[i].country,
                style: const TextStyle(fontSize: 13)),
            subtitle: Text(numeral(selectedData),
                style: const TextStyle(fontSize: 10)),
          )));
        }
        if (i >= 48) {
          widget.labels5.add(Expanded(
              child: ListTile(
            leading: CircleAvatar(backgroundColor: selectedColor, radius: 15),
            title: Text(widget.finalCountries[i].country,
                style: const TextStyle(fontSize: 13)),
            subtitle: Text(numeral(selectedData),
                style: const TextStyle(fontSize: 10)),
          )));
        }
      }
    }
    return listCountries;
  }

  _buildPolygonsData(List<CountryResponse> countries) {
    String polygons = '';
    for (var i = 0; i < countries.length; i++) {
      if (!noInfo.contains(countries[i].country)) {
        print('COUNTRY ==>> ${countries[i].country}');
        var c = widget.chartColors[i].split('');
        var finalColor = '${c[4]}${c[5]}${c[2]}${c[3]}${c[0]}${c[1]}';
        if(i <= 25) {
          widget.balloonLabels1 +=
            '''<h2><font color='#${widget.chartColors[i]}'>⚫</font> ${countries[i].country}: ${numeral(widget.chartCountriesData[i])}</h2>
''';
        } else {
          widget.balloonLabels2 +=
            '''<h2><font color='#${widget.chartColors[i]}'>⚫</font> ${countries[i].country}: ${numeral(widget.chartCountriesData[i])}</h2>
''';
        }
        var height = 0;
        if (widget.chartCountriesData[i] > 0 &&
            widget.chartCountriesData[i] < 1000) {
          height = 150000;
        } else if (widget.chartCountriesData[i] > 1000 &&
            widget.chartCountriesData[i] < 5000) {
          height = 200000;
        } else if (widget.chartCountriesData[i] > 5000 &&
            widget.chartCountriesData[i] < 10000) {
          height = 250000;
        } else if (widget.chartCountriesData[i] > 10000 &&
            widget.chartCountriesData[i] < 50000) {
          height = 350000;
        } else if (widget.chartCountriesData[i] > 50000 &&
            widget.chartCountriesData[i] < 100000) {
          height = 450000;
        } else if (widget.chartCountriesData[i] > 100000 &&
            widget.chartCountriesData[i] < 300000) {
          height = 500000;
        } else if (widget.chartCountriesData[i] > 300000 &&
            widget.chartCountriesData[i] < 700000) {
          height = 550000;
        } else if (widget.chartCountriesData[i] > 700000 &&
            widget.chartCountriesData[i] < 1000000) {
          height = 650000;
        } else if (widget.chartCountriesData[i] > 1000000 &&
            widget.chartCountriesData[i] < 50000000) {
          height = 750000;
        } else if (widget.chartCountriesData[i] > 50000000 &&
            widget.chartCountriesData[i] < 100000000) {
          height = 900000;
        } else if (widget.chartCountriesData[i] > 100000000 &&
            widget.chartCountriesData[i] < 500000000) {
          height = 1000000;
        } else if (widget.chartCountriesData[i] > 500000000) {
          height = 1500000;
        }
        if (countries[i].country == 'Russia') {
          polygons += russia(height, 'df$finalColor');
        } else {
          var countryCoordinates =
              _buildPolygonCoordinates(countries[i].country, height);
          polygons += kmlGenerator().polygon(
              countries[i].country, 'df$finalColor', countryCoordinates);
        }
      }
    }
    return polygons;
  }

  _buildPolygonCoordinates(country, int height) {
    String coordinates = '';
    List<Map<String, double>> selectedCountry =
        Coordinates().getCountry(country);
    for (var i = 0; i < selectedCountry.length; i++) {
      coordinates +=
          '${selectedCountry[i]['lon']},${selectedCountry[i]['lat']},$height \n';
    }
    coordinates +=
        '${selectedCountry[0]['lon']},${selectedCountry[0]['lat']},$height \n';
    orbitHeigth = height;
    return coordinates;
  }
/*   List<Widget> _buildList(List<CountryResponse> countries, color) {
    var contents = <Widget>[];
    for (var i = 0; i < countries.length; i++) {
      contents.add(ListTile(
          leading: CircleAvatar(
            backgroundColor: color[i],
            radius: 25,
          ),
          // ignore: unnecessary_string_interpolations
          title: Text(countries[i].country),
          subtitle: Text(widget.type == 'cases'
              ? '${countries[i].cases.toDouble()}'
              : widget.type == 'deaths'
                  ? '${countries[i].deaths.toDouble()}'
                  : widget.type == 'tests'
                      ? '${countries[i].tests.toDouble()}'
                      : '${countries[i].recovered.toDouble()}'),
          onTap: () {}));
    }
    return contents;
  } */

  @override
  Widget build(BuildContext context) {
    if (connectionLoaded == false) checkConnection();

    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: [
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
            backgroundColor: Colors.white)
      ]),
      body: Center(
          child: loaded == false
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 50),
                            Container(
                                alignment: Alignment.center,
                                width: 300,
                                height: 300,
                                child: PieChart(
                                  PieChartData(
                                      sectionsSpace: 1,
                                      centerSpaceRadius: 100,
                                      sections: widget.chartSections),
                                  swapAnimationDuration: const Duration(
                                      milliseconds: 150), // Optional
                                  swapAnimationCurve: Curves.linear,
                                )),
                            const SizedBox(height: 20),
                            Text(
                              widget.type == 'todayCases'
                                  ? 'Today cases: ${numeral(widget.total)}'
                                  : widget.type == 'todayDeaths'
                                      ? 'Today deaths: ${numeral(widget.total)}'
                                      : widget.type == 'todayRecovered'
                                          ? 'Today recovered: ${numeral(widget.total)}'
                                          : 'Total ${widget.type}: ${numeral(widget.total)}',
                              style: const TextStyle(fontSize: 15),
                            ),
                            const SizedBox(height: 50),
                            sendKML == false
                                ? ElevatedButton(
                                    onPressed: () async {
                                      var polygons = _buildPolygonsData(
                                          widget.finalCountries);
                                      var balloon = kmlGenerator().balloon(
                                          widget.title,
                                          widget.type == 'todayCases'
                                              ? 'Today cases: ${numeral(widget.total)}'
                                              : widget.type == 'todayDeaths'
                                                  ? 'Today deaths: ${numeral(widget.total)}'
                                                  : widget.type ==
                                                          'todayRecovered'
                                                      ? 'Today recovered: ${numeral(widget.total)}'
                                                      : 'Total ${widget.type}: ${numeral(widget.total)}',
                                          widget.balloonLabels1, widget.balloonLabels2);
                                      var finalKML = kmlGenerator()
                                          .continentKML({
                                        'name':
                                            widget.title.replaceAll(" ", "_"),
                                        'polygons': polygons
                                      });
                                      var lon = widget.continent ==
                                              'North America'
                                          ? -94.260584
                                          : widget.continent == 'Africa'
                                              ? 18.50675184146605
                                              : widget.continent == 'Asia'
                                                  ? 96.67343735776248
                                                  : widget.continent == 'Europe'
                                                      ? 18.666769022896464
                                                      : widget.continent ==
                                                              'Australia-Oceania'
                                                          ? 141.74397009325503
                                                          : -57.14873614683469;
                                      var lat = widget.continent ==
                                              'North America'
                                          ? 42.872698
                                          : widget.continent == 'Africa'
                                              ? 7.729659071024626
                                              : widget.continent == 'Asia'
                                                  ? 35.55188457751092
                                                  : widget.continent == 'Europe'
                                                      ? 49.90994122738823
                                                      : widget.continent ==
                                                              'Australia-Oceania'
                                                          ? -26.028662619598208
                                                          : -15.567501701815752;
                                      String content = kmlGenerator().orbitTag({
                                        'lon': lon,
                                        'lat': lat,
                                        'alt': orbitHeigth
                                      });
                                      String orbit =
                                          kmlGenerator().orbit(content);
                                      await LGConnection().sendKML(
                                          widget.title.replaceAll(" ", "_"),
                                          finalKML,
                                          kmlGenerator().FlyTo({
                                            'lon': lon,
                                            'lat': lat,
                                            'alt': 9000000,
                                            'tilt': 15.68179673613697
                                          }));
                                      await LGConnection()
                                          .sendBalloon(balloon, widget.title);
                                      await LGConnection().sendOrbit(orbit,
                                          '${widget.title.replaceAll(" ", "_")}Orbit');
                                      setState(() {
                                        sendKML = true;
                                      });
                                    },
                                    child: const Text('See on Liquid Galaxy'))
                                : playTour == false
                                    ? ElevatedButton(
                                        onPressed: () async {
                                          await LGConnection().startTour();
                                          setState(() {
                                            playTour = true;
                                          });
                                        },
                                        child: const Text('Start orbit'))
                                    : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            playTour = false;
                                          });
                                          await LGConnection().stopTour();
                                        },
                                        child: const Text('Stop orbit'))
                          ],
                        ),
                        const SizedBox(width: 50),
                        SizedBox(
                          width: 250,
                          height: widget.labels.length < 8 ? 300 : 620,
                          child: Column(children: widget.labels),
                        ),
                        countriesData.length > 12
                            ? SizedBox(
                                width: 250,
                                height: widget.labels2.length <= 5 ? 200 : 620,
                                child: Column(children: widget.labels2))
                            : const SizedBox(),
                        countriesData.length > 24
                            ? SizedBox(
                                width: 250,
                                height: widget.labels3.length <= 5
                                    ? 200
                                    : widget.labels3.length <= 10
                                        ? 400
                                        : 620,
                                child: Column(children: widget.labels3))
                            : const SizedBox(),
                        countriesData.length > 36
                            ? SizedBox(
                                width: 250,
                                height: widget.labels4.length <= 5
                                    ? 200
                                    : widget.labels4.length <= 10
                                        ? 400
                                        : 620,
                                child: Column(children: widget.labels4))
                            : const SizedBox(),
                        countriesData.length > 48
                            ? SizedBox(
                                width: 250,
                                height: widget.labels5.length <= 5
                                    ? 250
                                    : widget.labels5.length <= 10
                                        ? 500
                                        : 620,
                                child: Column(children: widget.labels5))
                            : const SizedBox()
                      ],
                    ),
                  ))),
    );
  }
}
