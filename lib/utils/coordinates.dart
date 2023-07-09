import 'dart:convert';

class Coordinates {
  usa() {
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
      USACoordinates += '${coordinates[i]['lon']},${coordinates[i]['lat']},100000 \n';
    }
    USACoordinates += '${coordinates[0]['lon']},${coordinates[0]['lat']},100000 \n';
    print('COORDENADA ==>> $USACoordinates');
    return USACoordinates;
  }
}
