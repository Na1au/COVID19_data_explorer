import 'package:dio/dio.dart';

class APIRequest {
  final dio = Dio();

  getGlobalData() async {
    try {
      final res = await dio.get('https://disease.sh/v3/covid-19/continents');
      List<GlobalResponse> response = [];
      for (var i = 0; i < res.data.length; i++) {
        response.add(GlobalResponse.fromJson(res.data[i]));
      }
      return response;
    } catch (e) {
      throw Exception('ERROR ON GET GLOBAL DATA');
    }
  }

  getCountryData(country) async {
    try {
      final res = await dio.get('https://disease.sh/v3/covid-19/countries/$country');
      return CountryResponse.fromJson(res.data);
    } catch (e) {
      throw Exception('ERROR ON GET COUNTRY DATA');
    }
  }

  getContinentData() async {
    try {
      final res = await dio.get('https://disease.sh/v3/covid-19/countries');
      List<CountryResponse> response = [];
      for (var i = 0; i < res.data.length; i++) {
        response.add(CountryResponse.fromJson(res.data[i]));
      }
      return response;
    } catch (e) {
      throw Exception('ERROR ON GET CONTINENT DATA: $e');
    }
  }
}

class GlobalResponse {
  final int updated;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int todayRecovered;
  final int active;
  final int critical;
  final int tests;
  final int population;
  final String continent;
  final List<dynamic> countries;

  GlobalResponse({
      required this.updated,
      required this.cases,
      required this.todayCases,
      required this.deaths,
      required this.todayDeaths,
      required this.recovered,
      required this.todayRecovered,
      required this.active,
      required this.critical,
      required this.tests,
      required this.population,
      required this.continent,
      required this.countries
      });

  static GlobalResponse fromJson(dynamic json) {
    return GlobalResponse(
        updated: json['updated'],
        cases: json['cases'],
        todayCases: json['todayCases'],
        deaths: json['deaths'],
        todayDeaths: json['todayDeaths'],
        recovered: json['recovered'],
        todayRecovered: json['todayRecovered'],
        active: json['active'],
        critical: json['critical'],
        tests: json['tests'],
        population: json['population'],
        continent: json['continent'],
        countries: json['countries']
        );
  }
}

class CountryResponse {
  final int updated;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int todayRecovered;
  final int active;
  final int critical;
  final int tests;
  final int population;
  final String continent;
  final String country;

  CountryResponse(
      {required this.updated,
      required this.cases,
      required this.todayCases,
      required this.deaths,
      required this.todayDeaths,
      required this.recovered,
      required this.todayRecovered,
      required this.active,
      required this.critical,
      required this.tests,
      required this.population,
      required this.continent,
      required this.country
      });

  static CountryResponse fromJson(dynamic json) {
    return CountryResponse(
        updated: json['updated'],
        cases: json['cases'],
        todayCases: json['todayCases'],
        deaths: json['deaths'],
        todayDeaths: json['todayDeaths'],
        recovered: json['recovered'],
        todayRecovered: json['todayRecovered'],
        active: json['active'],
        critical: json['critical'],
        tests: json['tests'],
        population: json['population'],
        continent: json['continent'],
        country: json['country']
        );
  }
}
