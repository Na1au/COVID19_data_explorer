class kmlGenerator {

  polygon(content) {
    print('CONTENT ==>> $content');
    String polygon = '''

      <Style id="${content['name']}">
        <PolyStyle>
          <color>${content['color']}</color>
          <fill>true</fill>
          <outline></outline>
        </PolyStyle>
      </Style>
      <Placemark>
        <name>${content['name']}</name>
        <styleUrl>#${content['name']}</styleUrl>
        <Polygon>
          <extrude>1</extrude>
          <altitudeMode>relativeToGround</altitudeMode>
          <outerBoundaryIs>
            <LinearRing>
            <altitudeMode>relativeToGround</altitudeMode>
              <coordinates>
              ${content['coordinates']}
              </coordinates>
            </LinearRing>
          </outerBoundaryIs>
        </Polygon>
      </Placemark>
  ''';
  return polygon;
  }

  continentKML(content) {
    String kml = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2"
xmlns:gx="http://www.google.com/kml/ext/2.2">
  <Document>
    <name>${content['name']}</name>
    <open>1</open>
    ${content['polygons']}
  </Document>
  </kml>
 ''';
    return kml;
  }

  FlyTo(content) {
    String flyTo ='''flytoview=<LookAt><longitude>${content['lon']}</longitude><latitude>${content['lat']}</latitude><altitude>${content['alt']}</altitude><tilt>${content['tilt']}</tilt><altitudeMode>relativeToGround</altitudeMode><gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode></LookAt>''';

    return flyTo;
  }

  String flyTo ='''flytoview=<LookAt><longitude>-80.140506</longitude><latitude>12.543370</latitude><altitude>8700000</altitude><tilt>15.68179673613697</tilt><altitudeMode>relativeToGround</altitudeMode><gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode></LookAt>''';
}
