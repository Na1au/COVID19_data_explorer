import 'package:dio/dio.dart';

class APIRequest {
  final dio = Dio();

  getGlobalData() async {
    try {
      final res = await dio.get('https://disease.sh/v3/covid-19/continents');
      List<GlobalResponse> response = [];
      for (var i = 0; i < res.data.length; i++) {
        response.add(GlobalResponse.fromJson(res.data[i]));
        //print(response);
      }
      return response;
    } catch (e) {
      print('ERROR ON GET GLOBAL DATA: $e');
    }
  }

  getCountryData(country) async {
    try {
      final res = await dio.get('https://disease.sh/v3/covid-19/countries/$country');
      return CountryResponse.fromJson(res.data);
    } catch (e) {
      print('ERROR ON GET COUNTRY DATA: $e');
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
  final double casesPerOneMillion;
  final double deathsPerOneMillion;
  final double testsPerOneMillion;
  final int population;
  final String continent;
  final double activePerOneMillion;
  final double recoveredPerOneMillion;
  final double criticalPerOneMillion;
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
      required this.casesPerOneMillion,
      required this.deathsPerOneMillion,
      required this.testsPerOneMillion, 
      required this.population,
      required this.continent,
      required this.activePerOneMillion,
      required this.recoveredPerOneMillion,
      required this.criticalPerOneMillion,
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
        casesPerOneMillion: json['casesPerOneMillion'],
        deathsPerOneMillion: json['deathsPerOneMillion'],
        testsPerOneMillion: json['testsPerOneMillion'],
        population: json['population'],
        continent: json['continent'],
        activePerOneMillion: json['activePerOneMillion'],
        recoveredPerOneMillion: json['recoveredPerOneMillion'],
        criticalPerOneMillion: json['criticalPerOneMillion'],
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
