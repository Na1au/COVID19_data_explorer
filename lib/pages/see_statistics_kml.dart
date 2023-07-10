import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:covid19_data_explorer/services/http_request.dart';
import 'package:numeral/numeral.dart';
import 'package:covid19_data_explorer/services/lg_connection.dart';
import 'package:covid19_data_explorer/utils/coordinates.dart';

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
              onPressed: () async {
                var heights = [];
                var usaCoordinates = Coordinates().usa1(800000);
                var usaCoordinates2 = Coordinates().usa2(800000);
                var canadaCoordinates = Coordinates().canada(widget.type == 'tests' ? 400000 : 300000);
                var mexicoCoordinates = Coordinates().mexico(widget.type == 'tests' ? 200000 : widget.type == 'deaths' ? 600000 : 400000);
                            var testKML = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2"
xmlns:gx="http://www.google.com/kml/ext/2.2">
<Document>
  <name>NorthAmerica</name>
  <open>1</open>
  <Style id="USA">
    <PolyStyle>
      <color>fff00760</color>
	<fill>true</fill>
	<outline></outline>
    </PolyStyle>
  </Style>
<Style id="Canada">
    <PolyStyle>
      <color>ff07d4eb</color>
	<fill>true</fill>
	<outline></outline>
    </PolyStyle>
  </Style>
<Style id="Mexico">
    <PolyStyle>
      <color>ff07eb16</color>
	<fill>true</fill>
	<outline></outline>
    </PolyStyle>
  </Style>
  <Placemark>
    <name>USA</name>
    <styleUrl>#USA</styleUrl>
    <Polygon>
      <extrude>1</extrude>
      <altitudeMode>relativeToGround</altitudeMode>
      <outerBoundaryIs>
        <LinearRing>
        <altitudeMode>relativeToGround</altitudeMode>
          <coordinates>
          $usaCoordinates
          </coordinates>
        </LinearRing>
      </outerBoundaryIs>
    </Polygon>
  </Placemark>
    <Placemark>
    <name>USA</name>
    <styleUrl>#USA</styleUrl>
    <Polygon>
      <extrude>1</extrude>
      <altitudeMode>relativeToGround</altitudeMode>
      <outerBoundaryIs>
        <LinearRing>
        <altitudeMode>relativeToGround</altitudeMode>
          <coordinates>
          $usaCoordinates2
          </coordinates>
        </LinearRing>
      </outerBoundaryIs>
    </Polygon>
  </Placemark>
  <Placemark>
    <name>Canada</name>
    <styleUrl>#Canada</styleUrl>
    <Polygon>
      <extrude>1</extrude>
      <altitudeMode>relativeToGround</altitudeMode>
      <outerBoundaryIs>
        <LinearRing>
        <altitudeMode>relativeToGround</altitudeMode>
          <coordinates>
          $canadaCoordinates
          </coordinates>
        </LinearRing>
      </outerBoundaryIs>
    </Polygon>
  </Placemark>
 <Placemark>
    <name>Mexico</name>
    <styleUrl>#Mexico</styleUrl>
    <Polygon>
      <extrude>1</extrude>
      <altitudeMode>relativeToGround</altitudeMode>
      <outerBoundaryIs>
        <LinearRing>
        <altitudeMode>relativeToGround</altitudeMode>
          <coordinates>
          $mexicoCoordinates
          </coordinates>
        </LinearRing>
      </outerBoundaryIs>
    </Polygon>
  </Placemark>
</Document>
</kml>
 ''';
                            String flyTo =
                                '''flytoview=<LookAt><longitude>-102.25961959532764</longitude><latitude>19.93601211675189</latitude><altitude>8500000</altitude><tilt>15.68179673613697</tilt><altitudeMode>relativeToGround</altitudeMode><gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode></LookAt>
''';
                            await LGConnection()
                                .sendKML('NorthAmerica_${widget.type}', testKML, flyTo);
              }, child: const Text('See on Liquid Galaxy'))
        ],
      )),
    );
  }
}