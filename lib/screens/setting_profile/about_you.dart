import 'package:card_club/resources/models/city_model.dart';
import 'package:card_club/resources/models/get_countries_model.dart';
import 'package:card_club/resources/models/get_states_by_country_id_model.dart';
import 'package:card_club/resources/models/user_update_detail_model.dart';
import 'package:card_club/screens/address/add_new_contact/bloc/get_cities_bloc.dart';
import 'package:card_club/screens/address/add_new_contact/bloc/get_countries_bloc.dart';
import 'package:card_club/screens/address/add_new_contact/bloc/get_states_bloc.dart';
import 'package:card_club/screens/dob/bloc/user_update_detail_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'edit_user_profile.dart';

class AboutYou extends StatefulWidget {
  const AboutYou({Key? key}) : super(key: key);

  @override
  _AboutYouState createState() => _AboutYouState();
}

class _AboutYouState extends State<AboutYou> {

  final formKey = GlobalKey<FormState>();

  var _companyNameTEC = TextEditingController();
  var _yourRoleTEC = TextEditingController();
  var _zipCodeTEC = TextEditingController();
  var _salaryTEC = TextEditingController();

  GetCountriesModel model = getCountriesBloc.getCountriesModel;

  List<CountryData>? countriesList = [];
  List<States>? statesList = [];
  List<CityData>? citiesList = [];

  //todo::For Country
  var countyName = "United States";
  var countryID = 1;

  //todo::For States
  var stateName = "Country";
  var stateID = 0;

  //todo::For States
  var cityName = "City";
  var cityID = 0;

  @override
  void initState() {
    super.initState();
    countriesList = model.countryList;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      countriesList = model.countryList;
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 37, left: 22, right: 22),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: main_color,
                  elevation: 0.0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Back",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black12, width: 2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        focusColor: main_color,
                        contentPadding: EdgeInsets.only(top: 15),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: main_color),
                        ),
                        hintText: "Company name",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.black26,
                            fontFamily: 'Montserrat'),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                      ),
                      cursorColor: main_color,
                      controller: _companyNameTEC,
                      validator: (String? value) {
                        if (_companyNameTEC.text.isEmpty)
                          return "Company name required!";
                        else
                          return null;
                      },
                    ),
                    TextFormField(
                      controller: _yourRoleTEC,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15),
                        focusColor: main_color,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: main_color),
                        ),
                        hintText: "Your role",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.black26,
                            fontFamily: 'Montserrat'),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                      ),
                      cursorColor: main_color,
                      validator: (String? value) {
                        if (_yourRoleTEC.text.isEmpty)
                          return "Your role required!";
                        else
                          return null;
                      },
                    ),
                    TextFormField(
                      controller: _zipCodeTEC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15),
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.black26,
                            fontFamily: 'Montserrat'),
                        hintText: "Zip code",
                        focusColor: main_color,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: main_color),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                      ),
                      cursorColor: main_color,
                      validator: (String? value) {
                        if (_zipCodeTEC.text.isEmpty)
                          return "Zip code required!";
                        else
                          return null;
                      },
                    ),
                    TextFormField(
                      controller: _salaryTEC,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15),
                        focusColor: main_color,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: main_color),
                        ),
                        hintText: "Salary",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.black26,
                            fontFamily: 'Montserrat'),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                      ),
                      cursorColor: main_color,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<CountryData>(
                          hint: Text(
                            countyName,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 24,
                          ),
                          isExpanded: true,
                          elevation: 2,
                          onChanged: (CountryData? newValue) {
                            FocusScope.of(context).unfocus();

                            setState(() {
                              countyName = newValue!.name;
                              countryID = newValue.id;

                              print(countyName);
                              print(countryID);

                              getStates(countryID, context);
                            });
                          },
                          items: countriesList
                              ?.map<DropdownMenuItem<CountryData>>((CountryData value) {
                            return DropdownMenuItem<CountryData>(
                              value: value,
                              child: Text(
                                value.name,
                                style: TextStyle(
                                  color: Colors.black87,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black12,
                      height: 2,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<States>(
                          hint: Text(
                            stateName,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          elevation: 16,
                          isExpanded: true,
                          onChanged: (States? newValue) async {
                            FocusScope.of(context).unfocus();

                            setState(() {
                              stateName = newValue!.name;
                              stateID = newValue.id;

                              print(stateName);
                              print(stateID);

                              getCities(stateID, context);
                            });
                          },
                          items: statesList
                              ?.map<DropdownMenuItem<States>>((States value) {
                            return DropdownMenuItem<States>(
                              value: value,
                              child: Text(
                                value.name,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black12,
                      height: 2,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<CityData>(
                          hint: Text(
                            cityName,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          elevation: 16,
                          isExpanded: true,
                          onChanged: (CityData? newValue) async {
                            FocusScope.of(context).unfocus();

                            print(cityName);
                            print(cityID);

                            setState(() {
                              cityName = newValue!.name;
                              cityID = newValue.id;
                            });
                          },
                          items: citiesList
                              ?.map<DropdownMenuItem<CityData>>((CityData value) {
                            return DropdownMenuItem<CityData>(
                              value: value,
                              child: Text(
                                value.name,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black12,
                      height: 2,
                    ),
                    // DropdownSearch<Country>(
                    //   mode: Mode.DIALOG,
                    //   showSearchBox: true,
                    //   showSelectedItem: true,
                    //   dropdownSearchDecoration: InputDecoration(
                    //     contentPadding: EdgeInsets.only(top: 15),
                    //     focusColor: main_color,
                    //     focusedBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: main_color),
                    //     ),
                    //   ),
                    //   items: countriesList,
                    //   onChanged: (value){
                    //     print(value);
                    //   },
                    //   popupItemBuilder: _customPopupItemBuilderExample2,
                    //   //show selected item
                    //   selectedItem: '',
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () async {

                  if(formKey.currentState!.validate()){

                  var companyName = _companyNameTEC.text.trim();
                  var companyRole = _yourRoleTEC.text.trim();
                  var zipCode = _zipCodeTEC.text.trim();
                  var salary = _salaryTEC.text.trim();

                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (dialogContext) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: main_color,
                        ));
                      });

                  await userUpdateDetailBloc.sendUpdateAboutRequest(
                    cityID,
                    stateID,
                    countryID,
                    salary,
                    zipCode,
                    companyRole,
                    companyName,
                  );

                  Navigator.of(context).pop();

                  UserUpdateDetailModel model=userUpdateDetailBloc.userUpdateAboutYouModel;

                  _snackBar("Message", model.message.toString());

                  Get.off(()=>EditUserProfile());


                  }

                },
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: main_color,
                    borderRadius: BorderRadius.all(Radius.circular(37)),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Save changes",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void getStates(int countryID, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: main_color,
            ),
          );
        });

    await getStatesBloc.getStatesRequest(countryID);

    setState(() {
      StatesByCityModel model = getStatesBloc.getStatesModel;
      statesList = [];
      statesList = model.statesList;
      stateName = "Select State";
    });

    Navigator.of(context).pop();
  }

  void getCities(int stateID, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: main_color,
            ),
          );
        });

    await getCitiesBloc.getCitiesRequest(stateID);

    setState(() {
      CityModel model = getCitiesBloc.getCitiesModel;
      citiesList = [];
      citiesList = model.cityList;

      cityName = "Select City";
    });

    Navigator.of(context).pop();
  }

  void _snackBar(var title, var message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.black12, colorText: Colors.white);
  }

}
