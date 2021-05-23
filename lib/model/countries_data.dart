// To parse this JSON data, do
//
//     final countriesData = countriesDataFromJson(jsonString);

import 'dart:convert';

CountriesData countriesDataFromJson(String str) =>
    CountriesData.fromJson(json.decode(str));

String countriesDataToJson(CountriesData data) => json.encode(data.toJson());

class CountriesData {
  CountriesData({
    this.countries,
  });

  List<Country> countries;

  factory CountriesData.fromJson(Map<String, dynamic> json) => CountriesData(
        countries: List<Country>.from(
            json["countries"].map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
      };
}

class Country {
  Country({
    this.name,
    this.iso2,
    this.iso3,
  });

  String name;
  String iso2;
  String iso3;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json["name"],
        iso2: json["iso2"] == null ? null : json["iso2"],
        iso3: json["iso3"] == null ? null : json["iso3"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "iso2": iso2 == null ? null : iso2,
        "iso3": iso3 == null ? null : iso3,
      };
}
