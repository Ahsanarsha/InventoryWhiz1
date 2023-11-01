import 'dart:convert';


StatesByCityModel statesByCityModelFromJson(String str) =>
    StatesByCityModel.fromJson(json.decode(str));


class StatesByCityModel {

  List<States> statesList=[];

  StatesByCityModel.fromJson(List <dynamic> json) {

    json.forEach((element) {

      var name=element['name'];
      var id=element['id'];

      statesList.add(States(name, id));

    });

    print(statesList.length);
  }


}

class States{

  String name;
  int id;

  States(this.name, this.id);
}