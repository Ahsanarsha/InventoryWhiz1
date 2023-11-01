import 'dart:convert';

GetCountriesModel getCountriesFromJson(String str) =>
    GetCountriesModel.fromJson(json.decode(str));



class GetCountriesModel {

  List<CountryData> countryList = [];

  GetCountriesModel.fromJson(List <dynamic> json) {

    json.forEach((element) {

      var name=element['name'];
      var id=element['id'];

      countryList.add(CountryData(name,id));

    });

  }

}

class CountryData {

  final String name;
  final int id;
  CountryData(this.name,this.id);
}


