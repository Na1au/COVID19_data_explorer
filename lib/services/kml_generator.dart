class kmlGenerator {

  orbitTag(content) {
    double heading = 0;
    int orbit = 0;
    String finalOrbit = '';
    //String range = '800';

    while (orbit <= 36) {
      if (heading >= 360) heading -= 360;
      finalOrbit += '''
            <gx:FlyTo>
              <gx:duration>1.2</gx:duration>
              <gx:flyToMode>smooth</gx:flyToMode>
              <LookAt>
                  <longitude>${content.lon}</longitude>
                  <latitude>${content.lat}</latitude>
                  <heading>$heading</heading>
                  <tilt>${content.tilt}</tilt>
                  <gx:fovy>35</gx:fovy>
                  <altitudeMode>relativeToGround</altitudeMode>
              </LookAt>
            </gx:FlyTo>
          ''';
      heading += 10;
      orbit += 1;
    }
    return finalOrbit;
  }

  orbit(content) {
    String orbit = '''
<?xml version="1.0" encoding="UTF-8"?>
      <kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
        <gx:Tour>
          <name>Orbit</name>
          <gx:Playlist> 
            $content
          </gx:Playlist>
        </gx:Tour>
      </kml>
    ''';
    return orbit;
  }

  polygon(content) {
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

  String flyTo ='''flytoview=<LookAt><longitude>-80.140506</longitude><latitude>12.543370</latitude><altitude>8700000</altitude><heading>167.0211046386626</heading><tilt>15.68179673613697</tilt><range>800</range><altitudeMode>relativeToGround</altitudeMode><gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode></LookAt>''';
}
