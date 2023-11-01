import 'dart:io';

import 'package:card_club/resources/models/city_model.dart';
import 'package:card_club/resources/models/common_model.dart';
import 'package:card_club/resources/models/get_countries_model.dart';
import 'package:card_club/resources/models/get_states_by_country_id_model.dart';
import 'package:card_club/screens/address/add_new_contact/bloc/add_new_contact_bloc.dart';
import 'package:card_club/screens/address/all_contacts/bloc/all_contact_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phonenumbers/phonenumbers.dart';

import '../../../bottom_navigation.dart';
import '../../../resources/models/get_contact_model.dart';
import '../../../resources/urls.dart';
import 'bloc/get_cities_bloc.dart';
import 'bloc/get_countries_bloc.dart';
import 'bloc/get_states_bloc.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact({Key? key}) : super(key: key);

  @override
  _UpdateContactState createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  final saveContactLength = GetStorage();

  var nameTEC = TextEditingController();
  var nickNameTEC = TextEditingController();
  var phoneNUmberTEC = PhoneNumberEditingController.fromCountryCode('US');
  var emailTEC = TextEditingController();
  var streetNumber1TEC = TextEditingController();
  var streetNumber2TEC = TextEditingController();
  var companyApartTEC = TextEditingController();
  var zipCodeTEC = TextEditingController();

  GetCountriesModel model = getCountriesBloc.getCountriesModel;
  GetContactModel modelContact = getAllContactBloc.getAllContactModel;

  List<ContactsData> contactData = [];
  int index = 0;

  List<CountryData>? countriesList = [];
  List<States>? statesList = [];
  List<CityData>? citiesList = [];

  //todo::For Country
  var countyName = "United States";
  var countryID = 1;

  //todo::For States
  var stateName = "Select State";
  var stateID = 0;

  //todo::For States
  var cityName = "Select City";
  var cityID = 0;

  File? imageFile;
  PhoneNumber? initialValue;

  @override
  void initState() {
    super.initState();
    countriesList = model.countryList;
    index = Get.arguments;

    nameTEC.text = modelContact.contacts![index].name.toString();
    nickNameTEC.text = modelContact.contacts![index].nickName.toString();
    emailTEC.text = modelContact.contacts![index].email.toString();
    streetNumber1TEC.text =
        modelContact.contacts![index].streetAddress1.toString();
    streetNumber2TEC.text =
        modelContact.contacts![index].streetAddress2.toString();
    companyApartTEC.text = modelContact.contacts![index].address.toString();
    zipCodeTEC.text = modelContact.contacts![index].postalCode.toString();

    setState(() {
      initialValue = PhoneNumber(
          Country('United States', 'US', 1, LengthRule.range(0, 10)),
          modelContact.contacts![index].phoneNum.toString());
    });
  }

  @override
  void dispose() {
    nameTEC.dispose();
    nickNameTEC.dispose();
    phoneNUmberTEC.dispose();
    emailTEC.dispose();
    streetNumber1TEC.dispose();
    streetNumber2TEC.dispose();
    companyApartTEC.dispose();
    zipCodeTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    setState(() {
      countriesList = model.countryList;
    });

    String userImage = imageUrl + modelContact.contacts![index].imagePath.toString();
    print(modelContact.contacts![index].imagePath.toString());

    // userImage = 'https://i.postimg.cc/mDrQwBDL/user3.png';

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: size.width,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  GestureDetector(
                    onTap: () {
                      showBottomSheet();
                    },
                    child: imageFile == null
                        ? Padding(
                            padding: EdgeInsets.all(30),
                            child: Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(userImage),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.all(30),
                            child: Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: FileImage(imageFile!),
                                    fit: BoxFit.fill),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 14.0,
                                      offset: Offset(0.0, 0.75))
                                ],
                              ),
                            ),
                          ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    height: 53,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.black12, width: 2)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: TextFormField(
                        controller: nameTEC,
                        decoration: InputDecoration(
                          focusColor: main_color,
                          hintText: modelContact.contacts![index].name,
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.black26,
                          ),
                        ),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        cursorColor: main_color,
                        validator: (String? value) {
                          if (nameTEC.text.isEmpty)
                            return 'Required Name';
                          else
                            return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.black12, width: 2)),
                    child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nickNameTEC,
                              decoration: InputDecoration(
                                focusColor: main_color,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: main_color),
                                ),
                                hintText: "Nickname...",
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              cursorColor: main_color,
                              validator: (String? value) {
                                if (nickNameTEC.text.isEmpty)
                                  return 'Required Nickname';
                                else
                                  return null;
                              },
                            ),
                            PhoneNumberFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              countryCodeWidth: 40,
                              controller: phoneNUmberTEC,
                              initialValue: initialValue,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                              ),
                            ),
                            TextFormField(
                              controller: emailTEC,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                focusColor: main_color,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: main_color),
                                ),
                                hintText: "Email...",
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                ),
                              ),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                              cursorColor: main_color,
                              validator: (String? value) {
                                if (emailTEC.text.isEmpty)
                                  return 'Required Email';
                                else
                                  return null;
                              },
                            ),
                            TextFormField(
                              controller: streetNumber1TEC,
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                focusColor: main_color,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: main_color),
                                ),
                                hintText: "Street Address or P.O. Box",
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              cursorColor: main_color,
                              validator: (String? value) {
                                if (streetNumber1TEC.text.isEmpty)
                                  return 'Required Street Address or P.O. Box';
                                else
                                  return null;
                              },
                            ),
                            TextFormField(
                              controller: streetNumber2TEC,
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                focusColor: main_color,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: main_color),
                                ),
                                hintText: "Street Address or P.O. Box",
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              cursorColor: main_color,
                            ),
                            TextFormField(
                              controller: companyApartTEC,
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                focusColor: main_color,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: main_color),
                                ),
                                hintText: "Company, Apartment, Floor, etc",
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                ),
                              ),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                              cursorColor: main_color,
                              validator: (String? value) {
                                if (companyApartTEC.text.isEmpty)
                                  return 'Required Company, Apartment, Floor, etc';
                                else
                                  return null;
                              },
                            ),
                            TextFormField(
                              controller: zipCodeTEC,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                focusColor: main_color,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: main_color),
                                ),
                                hintText: "Zip/Postal Code",
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              cursorColor: main_color,
                              validator: (String? value) {
                                if (zipCodeTEC.text.isEmpty)
                                  return 'Required Zip/Postal Code';
                                else
                                  return null;
                              },
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
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
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  iconSize: 24,
                                  isExpanded: true,
                                  elevation: 16,
                                  onChanged: (CountryData? newValue) {
                                    FocusScope.of(context).unfocus();

                                    setState(() {
                                      countyName = newValue!.name;
                                      countryID = newValue.id;
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
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis,
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
                                      getCities(stateID, context);
                                    });
                                  },
                                  items: statesList
                                      ?.map<DropdownMenuItem<States>>(
                                          (States value) {
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
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  isExpanded: true,
                                  onChanged: (CityData? newValue) async {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      cityName = newValue!.name;
                                      cityID = newValue.id;
                                    });
                                  },
                                  items: citiesList
                                      ?.map<DropdownMenuItem<CityData>>(
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
                            SizedBox(height: 20)
                          ],
                        )),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: main_color,
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                          onPressed: () async {
                            var id = modelContact.contacts![index].id;
                            var name = nameTEC.text.trim();
                            var nickName = nickNameTEC.text.trim();
                            var phoneNumber = phoneNUmberTEC.value.toString();
                            var email = emailTEC.text.trim();
                            var streetAddress1 = streetNumber1TEC.text.trim();
                            var streetAddress2 = streetNumber2TEC.text.trim();
                            var companyApartment = companyApartTEC.text.trim();
                            var postalCode = zipCodeTEC.text.trim();

                            String imagePath = '';
                            try {
                              imagePath = imageFile!.path.toString();
                            } catch (error) {
                              imagePath = '';
                            }

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

                            await addNewContactBloc.updateContactRequest(
                              id,
                              name,
                              nickName,
                              phoneNumber,
                              email,
                              streetAddress1,
                              streetAddress2,
                              companyApartment,
                              postalCode,
                              countryID,
                              stateID,
                              cityID,
                              imagePath,
                            );

                            await getAllContactBloc.getAllContactRequest();

                            Navigator.of(context).pop();
                            CommonModel model =
                                addNewContactBloc.updateContactModel;
                            saveContactLength.write("count", 0);

                            _snackBar("Message", model.message);

                            Get.offAll(() => BottomNavigation(), arguments: 4);
                          },
                          child: Text(
                            "Update Contact",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
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

  // Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  showBottomSheet() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text('Gallery'),
            onPressed: () {
              _getFromGallery();
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              _getFromCamera();
              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
