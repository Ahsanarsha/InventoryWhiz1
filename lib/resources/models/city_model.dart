import 'dart:convert';

CityModel cityModelFromJson(String str) =>
    CityModel.fromJson(json.decode(str));


class CityModel {

  List<CityData> cityList=[];

  CityModel.fromJson(List<dynamic> json) {

    json.forEach((element) {

      var name=element['name'];
      var id=element['id'];

      cityList.add(CityData(name, id));


    });

    print(cityList.length);
  }

}

class CityData{

  String name;
  int id;

  CityData(this.name, this.id);

}