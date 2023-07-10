class kmlGenerator {
  continentKML(coordinates) {
    String kml = '''
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
          ${coordinates[0]}
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
          ${coordinates[1]}
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
          ${coordinates[2]}
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
          ${coordinates[3]}
          </coordinates>
        </LinearRing>
      </outerBoundaryIs>
    </Polygon>
  </Placemark>
</Document>
</kml>
 ''';
    return kml;
  }

  String flyTo =
      '''flytoview=<LookAt><longitude>-80.140506</longitude><latitude>12.543370</latitude><altitude>8700000</altitude><tilt>15.68179673613697</tilt><altitudeMode>relativeToGround</altitudeMode><gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode></LookAt>
''';
}
