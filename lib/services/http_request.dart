import 'dart:convert';

import 'package:dio/dio.dart';

class APIRequest {
  final dio = Dio();

  get(url) async {
    try {
      final res = await dio.get(url);
      var response = [];
      for(var i = 0; i < res.data.length; i++) {
        response.add(GlobalResponse.fromJson(res.data[i]));
        print(response);
      }
     return response;
    } catch(e) {
      print('ERROR ON GET URL ==>> $e \n $url');
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
      required this.tests
    });

    static GlobalResponse fromJson(dynamic json) {
      return GlobalResponse(updated: json['updated'], cases: json['cases'], todayCases: json['todayCases'], deaths: json['deaths'], todayDeaths: json['todayDeaths'], recovered: json['recovered'], todayRecovered: json['todayRecovered'], active: json['active'], critical: json['critical'], tests: json['tests']);
    }
  }