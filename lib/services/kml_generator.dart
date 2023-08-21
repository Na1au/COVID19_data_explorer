// ignore: camel_case_types
class kmlGenerator {

  orbitTag(content) {
    double heading = 0;
    int orbit = 0;
    String finalOrbit = '';
    String range = '15000000';

    while (orbit <= 36) {
      if (heading >= 360) heading -= 360;
      finalOrbit += '''
            <gx:FlyTo>
              <gx:duration>1.2</gx:duration>
              <gx:flyToMode>smooth</gx:flyToMode>
              <LookAt>
                  <longitude>${content['lon']}</longitude>
                  <latitude>${content['lat']}</latitude>
                  <heading>$heading</heading>
                  <altitude>${content['alt']}</altitude>
                  <tilt>70</tilt>
                  <gx:fovy>35</gx:fovy>
                  <range>$range</range>
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

  polygon(name, color, coordinates) {
    String polygon = '''

      <Style id="$name">
        <PolyStyle>
          <color>$color</color>
          <fill>true</fill>
          <outline></outline>
        </PolyStyle>
      </Style>
      <Placemark>
        <name>$name</name>
        <styleUrl>#$name</styleUrl>
        <Polygon>
          <extrude>1</extrude>
          <altitudeMode>relativeToGround</altitudeMode>
          <outerBoundaryIs>
            <LinearRing>
            <altitudeMode>relativeToGround</altitudeMode>
              <coordinates>
              $coordinates
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

  balloon(name, description, content1, content2) {
    String kml = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document>
 <name>$name</name>
 <Style id="purple_paddle">
   <BalloonStyle>
     <text>\$[description]</text>
     <bgColor>fffcfcfc</bgColor>
   </BalloonStyle>
 </Style>
 <Placemark>
   <name>$name</name>
   <Snippet maxLines="0"></Snippet>
   <description><![CDATA[<!-- BalloonStyle background color:
ffffffff
-->
<!-- Icon URL:
http://maps.google.com/mapfiles/kml/paddle/purple-blank.png
-->
<table width="400" border="0" cellspacing="0" cellpadding="5">
 <tr>
   <td colspan="2" align="center">
     <img src="https://i.imgur.com/NiRb4Az.png" alt="picture" height="150" />
   </td>
 </tr>
 <tr>
   <td colspan="2" align="center">
     <h1><font color='#1387ed'>$name</font></h1>
     <h1><font color='#1d1e1f'>$description</h1>
     </td>
 </tr>
  <tr>
    <td align="left">
      $content1
    </td>
    <td align="left">
      $content2
    </td>
  </tr>
 <tr>
   <td colspan="2" align="center">
     <font color="#999999">@COVID-19 data explorer 2023</font>
   </td>
 </tr>
</table>]]></description>
   <styleUrl>#purple_paddle</styleUrl>
   <gx:balloonVisibility>1</gx:balloonVisibility>
 </Placemark>
 </Document>
</kml>
''';
return kml;
  }

  FlyTo(content) {
    String flyTo ='''flytoview=<LookAt><longitude>${content['lon']}</longitude><latitude>${content['lat']}</latitude><altitude>${content['alt']}</altitude><tilt>${content['tilt']}</tilt><altitudeMode>relativeToGround</altitudeMode><gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode></LookAt>''';

    return flyTo;
  }

  testKML(balloon) {
    String kml = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2"
xmlns:gx="http://www.google.com/kml/ext/2.2">
  <Document>
    <name>TESTE</name>
    <open>1</open>

    <Style id="CANADA">
    <PolyStyle>
      <color>7f3d3d3d</color>
         <fill>true</fill>
         <outline></outline>
    </PolyStyle>
    </Style>
    <Placemark>
    	<name>CANADA</name>
    	<styleUrl>#CANADA</styleUrl>
    	<Polygon>
    	  <extrude>1</extrude>
    	  <altitudeMode>relativeToGround</altitudeMode>
    	  <outerBoundaryIs>
    	    <LinearRing>
    	    <altitudeMode>relativeToGround</altitudeMode>
        	  <coordinates>
          -141.34597507879818,69.78767871098114,300000
-124.2951941026405,74.59681696124024,300000
-119.19753784699421,77.54754257664334,300000
-77.36160101889602,83.17703589840266,300000
-60.13503879556149,82.56665747176554,300000
-79.64675723219551,74.26658773736122,300000
-61.013945031445886,67.00870994219987,300000
-64.5295700737925,60.59936741201164,300000
-51.87332027705693,47.53425420982638,300000
-65.40888224301098,43.443872184977046,300000 
-69.15849355044855,47.39801448546225,300000
-83.30466566880175,41.77093347380173,300000
-141.34597507879818,69.78767871098114,300000
		</coordinates>
	       </LinearRing>
    	  </outerBoundaryIs>
    	 </Polygon>
  	</Placemark>

  <Style id="USA2">
    <PolyStyle>
      <color>7ffc0060</color>
         <fill>true</fill>
         <outline></outline>
    </PolyStyle>
  </Style>
  <Placemark>
    <name>USA2</name>
    <styleUrl>#USA2</styleUrl>
    <Polygon>
      <extrude>1</extrude>
      <altitudeMode>relativeToGround</altitudeMode>
      <outerBoundaryIs>
        <LinearRing>
        <altitudeMode>relativeToGround</altitudeMode>
          <coordinates>
          -141.32141031921168,69.83209915101473,800000
-156.96594131795428,71.57363491925182,800000
-169.18273799674762,68.90315099442729,800000
-169.44640986751295,53.05451194772462,800000
-141.05773844844637,59.523251434388165,800000 
-141.32141031921168,69.83209915101473,800000
          </coordinates>
        </LinearRing>
      </outerBoundaryIs>
    </Polygon>
  </Placemark>
  $balloon
  </Document>
  </kml>
  ''';
  return kml;
  }

  String testBalloon = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document>
 <name>balloon_teste.kml</name>
 <Style id="purple_paddle">
   <BalloonStyle>
     <text>\$[description]</text>
     <bgColor>fffcfcfc</bgColor>
   </BalloonStyle>
 </Style>
 <Placemark>
   <name>North America total cases</name>
   <Snippet maxLines="0"></Snippet>
   <description><![CDATA[<!-- BalloonStyle background color:
ffffffff
-->
<!-- Icon URL:
http://maps.google.com/mapfiles/kml/paddle/purple-blank.png
-->
<table width="400" border="0" cellspacing="0" cellpadding="5">
 <tr>
   <td colspan="2" align="center">
     <img src="https://i.imgur.com/NiRb4Az.png" alt="picture" height="150" />
   </td>
 </tr>
 <tr>
   <td colspan="2" align="center">
     <h2><font color='#1387ed'>North America total cases</font></h2>
     <h2><font color='#1d1e1f'>27M</h2>
     </td>
 </tr>
 <tr>
   <td colspan="2" align="center">
     <font color="#999999">@COVID-19 data explorer 2023</font>
   </td>
 </tr>
</table>]]></description>
   <styleUrl>#purple_paddle</styleUrl>
   <gx:balloonVisibility>1</gx:balloonVisibility>
   <Point>
     <coordinates>-17.841486,28.638478,0</coordinates>
   </Point>
 </Placemark>
</Document>
</kml>
''';

  String flyTo ='''flytoview=<LookAt><longitude>-80.140506</longitude><latitude>12.543370</latitude><altitude>8700000</altitude><heading>167.0211046386626</heading><tilt>15.68179673613697</tilt><range>800</range><altitudeMode>relativeToGround</altitudeMode><gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode></LookAt>''';
}
