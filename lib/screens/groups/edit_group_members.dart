import 'package:card_club/resources/models/get_all_groups_model.dart';
import 'package:card_club/resources/urls.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';

import 'bloc/group_bloc.dart';

class EditGroupMembers extends StatefulWidget {
  EditGroupMembers({Key? key}) : super(key: key);

  @override
  _EditGroupMembersState createState() => _EditGroupMembersState();
}

class _EditGroupMembersState extends State<EditGroupMembers> {
  var _searchTEC = TextEditingController();
  GetAllGroupsModel _allGroupsModel = groupBloc.getAllGroupsModel;

  List<Contacts> _contacts = [];
  List<Contacts> _filteredList = [];

  int index=0;

  @override
  void initState() {
    super.initState();
    index=Get.arguments;
    _contacts = _allGroupsModel.groups![index].contacts!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15.0,
                            offset: Offset(0.0, 0.75))
                      ],
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(44),
                        bottomLeft: Radius.circular(44),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 35, left: 22, right: 22),
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
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            "Groups Info",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 7, bottom: 10),
                          width: MediaQuery.of(context).size.width * 0.80,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.all(Radius.circular(37)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: TextField(
                              controller: _searchTEC,
                              onSubmitted: (value) {
                                setState(() {
                                  _searchTEC.clear();
                                });
                              },
                              onChanged: (value) {
                                _searchFunction(value);
                              },
                              decoration: InputDecoration(
                                hintText: "",
                                border: InputBorder.none,
                                suffixIcon: Icon(
                                  Icons.search,
                                  size: 35,
                                  color: Colors.black12,
                                ),
                              ),
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.12,
                padding: EdgeInsets.only(top: 30, left: 22, right: 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "${_allGroupsModel.groups![index].title}",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    Text(
                      'Members ${_contacts.length}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _searchTEC.text.isEmpty
                        ? _contacts.length
                        : _filteredList.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return _searchTEC.text.isEmpty
                          ? _myGroupsWidget(_contacts[index], index)
                          : _myGroupsWidget(_filteredList[index], index);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _myGroupsWidget(Contacts contacts, int index) {

    String finalUrl;
    try {
      String imagePath = contacts.imagePath!.toString();
      finalUrl = imageUrl + imagePath;
    } catch (error) {
      finalUrl = "https://i.postimg.cc/K8kPGR9s/clipart.png";
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
          left: 22, right: 22, bottom: index == _contacts.length - 1 ? 80 : 10),
      height: 105,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 72,
                  width: 72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    child: ImageCacheing(
                        height: 72,
                        width: 72,
                        fit: BoxFit.cover,
                        url: finalUrl,
                        loadingWidget: Center(
                          child: CircularProgressIndicator(),
                        )),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        left: 17,
                        right: 17,
                      ),
                      child: Text(
                        contacts.name.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.radio_button_checked,
                color: main_color,
              )
            ],
          ),
        ],
      ),
    );
  }

  _searchFunction(String value) {
    _filteredList = [];
    for (int i = 0; i < _contacts.length; ++i) {
      print(_contacts[i].name);

      var name = _contacts[i].name;
      var imagePath = _contacts[i].imagePath;
      var id = _contacts[i].id;

      if (name!.contains(value.toUpperCase()) ||
          name.contains(value.toLowerCase())) {
        _filteredList.add(Contacts(name: name, imagePath: imagePath, id: id));
      }
      setState(() {
        print(_filteredList.length);
      });
    }
  }
}
