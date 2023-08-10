import 'dart:io';
import 'dart:math';

import 'package:basic_utils/basic_utils.dart';
import 'package:covid19_data_explorer/services/kml_generator.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:covid19_data_explorer/services/http_request.dart';
import 'package:numeral/numeral.dart';
import 'package:covid19_data_explorer/services/lg_connection.dart';
import 'package:covid19_data_explorer/utils/coordinates.dart';
import 'package:path_provider/path_provider.dart';

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
  List<PieChartSectionData> chartSections = [];
  String balloonLabels = '';
  List<CountryResponse> finalCountries = [];
  String kml = '';

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

  @override
  void initState() {
    _buildData();
    _buildChartData(countriesData);
    super.initState();
    loaded = true;
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
    List<CountryResponse> finalCountries = [];
    for (var i = 0; i < countries.length; i++) {
      widget.type == 'cases' && countries[i].cases > 0
          ? finalCountries.add(countries[i])
          : widget.type == 'deaths' && countries[i].deaths > 0
              ? finalCountries.add(countries[i])
              : widget.type == 'tests' && countries[i].tests > 0
                  ? finalCountries.add(countries[i])
                  : widget.type == 'recovered' && countries[i].recovered > 0
                      ? finalCountries.add(countries[i])
                      : null;
    }
    if (finalCountries.length <= 15) {
      for (var i = 0; i < finalCountries.length; i++) {
        var selectedData = widget.type == 'cases'
            ? finalCountries[i].cases
            : widget.type == 'deaths'
                ? finalCountries[i].deaths
                : widget.type == 'tests'
                    ? finalCountries[i].tests
                    : finalCountries[i].recovered;
        var selectedColor =
            Colors.primaries[Random().nextInt(Colors.primaries.length)];
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
          title: Text(finalCountries[i].country),
          subtitle: Text(numeral(selectedData)),
        )));
      }
    } else {
      for (var i = 0; i < finalCountries.length; i++) {
        var selectedData = widget.type == 'cases'
            ? finalCountries[i].cases
            : widget.type == 'deaths'
                ? finalCountries[i].deaths
                : widget.type == 'tests'
                    ? finalCountries[i].tests
                    : finalCountries[i].recovered;
        var selectedColor =
            Colors.primaries[Random().nextInt(Colors.primaries.length)];
        widget.chartColors
            .add(ColorUtils.intToHex(selectedColor.value).substring(1));
        widget.chartCountriesData.add(selectedData);
        widget.chartSections.add(PieChartSectionData(
            value: selectedData.toDouble(),
            color: selectedColor,
            showTitle: false));

        if (i <= 15) {
          widget.labels.add(Expanded(
              child: ListTile(
                  leading:
                      CircleAvatar(backgroundColor: selectedColor, radius: 15),
                  title: Text(finalCountries[i].country,
                      style: const TextStyle(fontSize: 13)),
                  subtitle: Text(numeral(selectedData),
                      style: const TextStyle(fontSize: 10)))));
        }
        if (i > 15 && i <= 30) {
          widget.labels2.add(Expanded(
              child: ListTile(
            leading: CircleAvatar(backgroundColor: selectedColor, radius: 15),
            title: Text(finalCountries[i].country,
                style: const TextStyle(fontSize: 13)),
            subtitle: Text(numeral(selectedData),
                style: const TextStyle(fontSize: 10)),
          )));
        }
        if (i > 30 && i <= 45) {
          widget.labels3.add(Expanded(
              child: ListTile(
            leading: CircleAvatar(backgroundColor: selectedColor, radius: 15),
            title: Text(finalCountries[i].country,
                style: const TextStyle(fontSize: 13)),
            subtitle: Text(numeral(selectedData),
                style: const TextStyle(fontSize: 10)),
          )));
        }
        if (i > 45) {
          widget.labels4.add(Expanded(
              child: ListTile(
            leading: CircleAvatar(backgroundColor: selectedColor, radius: 15),
            title: Text(finalCountries[i].country,
                style: const TextStyle(fontSize: 13)),
            subtitle: Text(numeral(selectedData),
                style: const TextStyle(fontSize: 10)),
          )));
        }
      }
    }
    widget.finalCountries = finalCountries;
    return finalCountries;
  }

  _buildPolygonsData(List<CountryResponse> countries) {
    String polygons = '';
    if (widget.continent == 'North America') {
      for (var i = 0; i < countries.length; i++) {
        if (!noInfo.contains(countries[i].country)) {
          var c = widget.chartColors[i].split('');
          var finalColor = '${c[4]}${c[5]}${c[2]}${c[3]}${c[0]}${c[1]}';
          widget.balloonLabels +=
              '''<h2><font color='#${widget.chartColors[i]}'>⚫</font> ${countries[i].country}: ${numeral(widget.chartCountriesData[i])}</h2>
''';
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
          child: loaded == false
              ? const CircularProgressIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              swapAnimationDuration:
                                  const Duration(milliseconds: 150), // Optional
                              swapAnimationCurve: Curves.linear,
                            )),
                        const SizedBox(height: 20),
                        Text(
                          'Total ${widget.type}: ${numeral(widget.total)}',
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 50),
                        sendKML == false
                            ? ElevatedButton(
                                onPressed: () async {
                                  var polygons =
                                      _buildPolygonsData(widget.finalCountries);
                                  var balloon = kmlGenerator().balloon(
                                      widget.title,
                                      'Total ${widget.type}: ${numeral(widget.total)}',
                                      widget.balloonLabels);
                                  var finalKML = kmlGenerator().continentKML({
                                    'name': widget.title.replaceAll(" ", "_"),
                                    'polygons': polygons
                                  });
                                  var lon = widget.continent == 'North America'
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
                                  var lat = widget.continent == 'North America'
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
                                  widget.kml = kmlGenerator().orbit(content);
                                  await LGConnection().sendKML(
                                      widget.title.replaceAll(" ", "_"),
                                      finalKML,
                                      kmlGenerator().FlyTo({
                                        'lon': lon,
                                        'lat': lat,
                                        'alt': 8700000,
                                        'tilt': 15.68179673613697
                                      }));
                                  await LGConnection()
                                      .sendBalloon(balloon, widget.title);
                                  await LGConnection().sendOrbit(widget.kml);
                                  setState(() {
                                    sendKML = true;
                                  });
                                  /* 
                          var usaCoordinates = Coordinates().usa1(800000);
                          var usaCoordinates2 = Coordinates().usa2(800000);
                          var canadaCoordinates = Coordinates()
                              .canada(widget.type == 'tests' ? 400000 : 300000);
                          var mexicoCoordinates =
                              Coordinates().mexico(widget.type == 'tests'
                                  ? 200000
                                  : widget.type == 'deaths'
                                      ? 600000
                                      : 400000);
                          var coordinates = [usaCoordinates, canadaCoordinates, mexicoCoordinates];
                          var names = ['USA', 'CANADA', 'MEXICO'];
                          var polygons = '';
                          polygons += kmlGenerator().polygon({'name': 'USA2', 'color': polygonColors[widget._random.nextInt(polygonColors.length)], 'coordinates': usaCoordinates2});
                          for(var i = 0; i < 3; i++) {
                            var po = kmlGenerator().polygon({'name': names[i], 'color': polygonColors[widget._random.nextInt(polygonColors.length)], 'coordinates': coordinates[i]});
                            polygons += po;
                          }
                          print(polygons);
                          var kml = kmlGenerator().continentKML({'name': 'North America', 'polygons': polygons});
                          var flyTo = kmlGenerator().FlyTo({'lon': -80.140506, 'alt': 8700000, 'tilt': 15.68179673613697, 'lat': 12.543370 });
                          await LGConnection().sendKML(
                              'NorthAmerica_${widget.type}', kml, flyTo); */
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
                                    child: Text('Play Tour'))
                                : ElevatedButton(
                                    onPressed: () async {
                                      await LGConnection().stopTour();
                                    },
                                    child: Text('Stop Tour'))
                      ],
                    ),
                    SizedBox(
                      width: 200,
                      height: 620,
                      child: Column(children: widget.labels),
                    ),
                    countriesData.length > 15
                        ? SizedBox(
                            width: 200,
                            height: widget.labels2.length <= 5 ? 200 : 620,
                            child: Column(children: widget.labels2))
                        : const SizedBox(),
                    countriesData.length > 30
                        ? SizedBox(
                            width: 200,
                            height: widget.labels3.length <= 5
                                ? 200
                                : widget.labels3.length <= 10
                                    ? 400
                                    : 620,
                            child: Column(children: widget.labels3))
                        : const SizedBox(),
                    countriesData.length > 45
                        ? SizedBox(
                            width: 200,
                            height: widget.labels4.length <= 5
                                ? 200
                                : widget.labels4.length <= 10
                                    ? 400
                                    : 620,
                            child: Column(children: widget.labels4))
                        : const SizedBox()
                  ],
                )),
    );
  }
}
