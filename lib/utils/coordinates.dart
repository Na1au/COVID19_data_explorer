class Coordinates {
  usa1(height) {
    var coordinates = [
      { 'lon': -124.781629, 'lat': 48.498806},
      { 'lon': -122.585387, 'lat': 48.963954},
      { 'lon': -95.249389, 'lat': 48.988106},
      { 'lon': -82.593842, 'lat': 45.370193},
      { 'lon': -81.928924, 'lat': 42.048841},
      { 'lon': -74.875010, 'lat': 44.982995},
      { 'lon': -70.914411, 'lat': 45.410798},
      { 'lon': -68.977476, 'lat': 47.638139},
      { 'lon': -66.838174, 'lat': 44.798666},
      { 'lon': -81.257686, 'lat': 30.862163},
      { 'lon': -79.914571, 'lat': 26.518506},
      { 'lon': -80.522151, 'lat': 25.001593},
      { 'lon': -85.291696, 'lat': 29.620527},
      { 'lon': -97.219665, 'lat': 25.815203},
      { 'lon': -117.393704, 'lat': 32.350783},
      { 'lon': -124.807485, 'lat': 40.265177},
    ];
    String USACoordinates = '';
    for(var i = 0; i < coordinates.length; i++) {
      USACoordinates += '${coordinates[i]['lon']},${coordinates[i]['lat']},$height \n';
    }
    USACoordinates += '${coordinates[0]['lon']},${coordinates[0]['lat']},$height \n';
    return USACoordinates;
  }

  usa2(height) {
    var coordinates = [
      {'lat': 69.83209915101473, 'lon': -141.32141031921168},
      {'lat': 71.57363491925182, 'lon': -156.96594131795428},
      {'lat': 68.90315099442729, 'lon': -169.18273799674762},
      {'lat': 53.05451194772462, 'lon': -169.44640986751295},
      {'lat': 59.523251434388165, 'lon': -141.05773844844637}
    ];
    String USACoordinates = '';
    for(var i = 0; i < coordinates.length; i++) {
      USACoordinates += '${coordinates[i]['lon']},${coordinates[i]['lat']},$height \n';
    }
    USACoordinates += '${coordinates[0]['lon']},${coordinates[0]['lat']},$height \n';
    return USACoordinates;
  }

  canada(height) {
    var coordinates = [
      {'lat': 69.78767871098114, 'lon': -141.34597507879818},
      {'lat': 74.59681696124024, 'lon': -124.2951941026405},
      {'lat': 77.54754257664334, 'lon': -119.19753784699421},
      {'lat': 83.17703589840266, 'lon': -77.36160101889602},
      {'lat': 82.56665747176554, 'lon': -60.13503879556149},
      {'lat': 74.26658773736122, 'lon': -79.64675723219551},
      {'lat': 67.00870994219987, 'lon': -61.013945031445886},
      {'lat': 60.59936741201164, 'lon': -64.5295700737925},
      {'lat': 47.53425420982638, 'lon': -51.87332027705693},
      {'lat': 43.443872184977046, 'lon': -65.40888224301098},
      {'lat': 47.39801448546225, 'lon': -69.15849355044855},
      {'lat': 41.77093347380173, 'lon': -83.30466566880175},
      {'lat': 48.91582640000619, 'lon': -95.26917571922813},
      {'lat': 48.47836317100931, 'lon': -128.19190151227482},
      {'lat': 60.48941251303364, 'lon': -141.48836724497838}
    ];
    String CanadaCoordinates = '';
    for(var i = 0; i < coordinates.length; i++) {
      CanadaCoordinates += '${coordinates[i]['lon']},${coordinates[i]['lat']},$height \n';
    }
    CanadaCoordinates += '${coordinates[0]['lon']},${coordinates[0]['lat']},$height \n';
    return CanadaCoordinates;
  }

  mexico(height) {
    var coordinates = [
      {'lat': 32.68612893439156, 'lon': -117.31604183081026},
      {'lat': 26.067195609999306, 'lon': -97.01330778188033},
      {'lat': 18.927644873323857, 'lon': -95.73889373984791},
      {'lat': 19.756933755648856, 'lon': -91.0367453778663},
      {'lat': 21.892645716545168, 'lon': -90.33362038915877},
      {'lat': 21.892645716545168, 'lon': -86.59826888665},
      {'lat': 18.21949091817505, 'lon': -87.69690168150552},
      {'lat': 17.676004435975827, 'lon': -90.77307350710097},
      {'lat': 16.204706164055267, 'lon': -90.33362038915877},
      {'lat': 14.161916671558757, 'lon': -92.52064789644047},
      {'lat': 16.13425939422036, 'lon': -94.60805024971853},
      {'lat': 15.24580470326511, 'lon': -96.71742521584113},
      {'lat': 20.14237702203285, 'lon': -105.85805006903904},
      {'lat': 24.370904065118673, 'lon': -112.3619563430355},
      {'lat': 32.439124886554694, 'lon': -117.28383126398825}
    ];
    String mexicoCoordinates = '';
    for(var i = 0; i < coordinates.length; i++) {
      mexicoCoordinates += '${coordinates[i]['lon']},${coordinates[i]['lat']},$height \n';
    }
    mexicoCoordinates += '${coordinates[0]['lon']},${coordinates[0]['lat']},$height \n';
    print('COORDENADA ==>> $mexicoCoordinates');
    return mexicoCoordinates;
  }
}