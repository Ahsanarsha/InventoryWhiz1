import 'package:card_club/resources/models/city_model.dart';
import 'package:card_club/resources/models/common_model.dart';
import 'package:card_club/resources/models/get_countries_model.dart';
import 'package:card_club/resources/models/get_states_by_country_id_model.dart';
import 'package:card_club/screens/address/add_new_contact/bloc/get_cities_bloc.dart';
import 'package:card_club/screens/address/add_new_contact/bloc/get_countries_bloc.dart';
import 'package:card_club/screens/address/add_new_contact/bloc/get_states_bloc.dart';
import 'package:card_club/screens/cart_item/shipping/bloc/shipping_bloc.dart';
import 'package:card_club/screens/cart_item/shipping/select_shpping_address.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddShippingAddress extends StatefulWidget {
  const AddShippingAddress({Key? key}) : super(key: key);

  @override
  _AddShippingAddressState createState() => _AddShippingAddressState();
}

class _AddShippingAddressState extends State<AddShippingAddress> {
  final formKey = GlobalKey<FormState>();

  var _addressName = TextEditingController();
  var _addressOneTEC = TextEditingController();
  var _addressTwoTEC = TextEditingController();
  var _zipCodeTEC = TextEditingController();

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
                height: 65.h,
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
                        hintText: "Address Name",
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
                      controller: _addressName,
                      validator: (String? value) {
                        if (_addressName.text.isEmpty)
                          return "Address Name";
                        else
                          return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        focusColor: main_color,
                        contentPadding: EdgeInsets.only(top: 15),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: main_color),
                        ),
                        hintText: "Street Address or P.O. Box",
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
                      controller: _addressOneTEC,
                      validator: (String? value) {
                        if (_addressOneTEC.text.isEmpty)
                          return "Street Address or P.O. Box";
                        else
                          return null;
                      },
                    ),
                    TextFormField(
                      controller: _addressTwoTEC,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 15),
                        focusColor: main_color,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: main_color),
                        ),
                        hintText: "Street Address or P.O. Box",
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
                              ?.map<DropdownMenuItem<CountryData>>(
                                  (CountryData value) {
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
                          items: citiesList?.map<DropdownMenuItem<CityData>>(
                              (CityData value) {
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
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    var addressName = _addressName.text.trim();
                    var streetAddress1 = _addressOneTEC.text.trim();
                    var streetAddress2 = _addressTwoTEC.text.trim();
                    int postalCode = int.parse(_zipCodeTEC.text.trim());

                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (dialogContext) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: main_color,
                          ));
                        });

                    await shippingBloc.saveShippingAddressRequest(
                      addressName,
                      streetAddress1,
                      streetAddress2,
                      postalCode,
                      countryID,
                      stateID,
                      cityID,
                    );

                    if(shippingBloc.savaShippingAddressModel.statusCode==200){
                      await shippingBloc.getShippingAddressRequest();
                      Navigator.of(context).pop();

                      CommonModel model = shippingBloc.savaShippingAddressModel;
                      _snackBar("Message", model.message.toString());

                      Get.off(() => SelectShippingAddress());
                    }else{
                      Navigator.of(context).pop();

                      CommonModel model = shippingBloc.savaShippingAddressModel;
                      _snackBar("Message", model.message.toString());
                    }

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
                            "Add Shipping Address",
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

   getStates(int countryID, BuildContext context) async {
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

  getCities(int stateID, BuildContext context) async {
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

  _snackBar(var title, var message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black12,
      colorText: Colors.white,
    );
  }
}
