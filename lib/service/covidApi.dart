import 'dart:convert';
import 'package:covid19_app/model/country_data.dart';
import 'package:http/http.dart' as http;
import 'package:covid19_app/model/global_data.dart';
import 'package:covid19_app/model/countries_data.dart';

class CovidApi {
  Future<GlobalData> getGlobalData() async {
    final response =
        await http.get(Uri.parse('https://covid19.mathdro.id/api'));
    if (response.statusCode == 200) {
      GlobalData data = new GlobalData.fromJson(json.decode(response.body));
      return data;
    } else {
      throw Exception('error');
    }
  }

  Future<CountriesData> getCountriesData() async {
    final response =
        await http.get(Uri.parse('https://covid19.mathdro.id/api/countries'));
    if (response.statusCode == 200) {
      return new CountriesData.fromJson(json.decode(response.body));
    } else {
      throw Exception('error');
    }
  }

  Future<CountryData> getCountryData(country) async {
    final response = await http
        .get(Uri.parse('https://covid19.mathdro.id/api/countries/${country}'));
    if (response.statusCode == 200) {
      return new CountryData.fromJson(json.decode(response.body));
    } else {
      throw Exception('error');
    }
  }
}
