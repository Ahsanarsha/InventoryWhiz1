import 'package:card_club/resources/models/common_model.dart';
import 'package:card_club/resources/models/get_contact_model.dart';
import 'package:card_club/resources/models/get_contact_sync_model.dart';
import 'package:card_club/resources/urls.dart';
import 'package:card_club/screens/address/add_new_contact/add_contact.dart';
import 'package:card_club/screens/address/add_new_contact/bloc/get_countries_bloc.dart';
import 'package:card_club/screens/address/add_new_contact/update_contact.dart';
import 'package:card_club/screens/address/all_contacts/bloc/all_contact_bloc.dart';
import 'package:card_club/screens/address/all_contacts/bloc/sync_contacts_bloc.dart';
import 'package:card_club/screens/address/contact_info/contact_info.dart';
import 'package:card_club/screens/groups/all_groups.dart';
import 'package:card_club/screens/groups/create_grop.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../bottom_navigation.dart';
import '../../groups/bloc/group_bloc.dart';
import 'add_sync_contacts.dart';

class AllContacts extends StatefulWidget {
  @override
  _AllContactsState createState() => _AllContactsState();
}

class _AllContactsState extends State<AllContacts> {
  //todo::save contact length
  final saveContactLength = GetStorage();
  int _contactLength = 0;

  var _searchTEC = TextEditingController();
  GetContactModel model = getAllContactBloc.getAllContactModel;

  List<ContactsData> contactData = [];
  List<ContactsData> _filteredList = [];
  List<String> temp = [];

  List<String> syncList = [];

  int index = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    saveContactLength.writeIfNull("count", 0);

    if (saveContactLength.read('count') != null) {
      _contactLength = saveContactLength.read('count');
    }

    print(_contactLength);
    print(contactData.length);

    if (_contactLength == 0) {
      getAllContact(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _searchTEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      contactData = model.contacts!;
    } catch (error) {
      print(error);
    }

    BoxDecoration myBoxDecoration() {
      return BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        border: Border.all(
          color: Colors.black12,
        ),
      );
    }

    BoxDecoration myClickDecoration() {
      return BoxDecoration(
        color: main_color,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        border: Border.all(
          color: Colors.black12,
        ),
      );
    }

    String clickItem = "";

    List<String> _listMenu = ['Edit', 'Delete', 'Create Group', 'All Groups'];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 70),
        child: FloatingActionButton(
          onPressed: () async {
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

            await getCountriesBloc.getCountriesRequest();

            Navigator.of(context).pop();

            Get.to(() => AddContact());
          },
          backgroundColor: main_color,
          child: const Icon(Icons.add),
        ),
      ),
      body: SafeArea(
        child: Container(
          // margin: const EdgeInsets.only(top: 35, left: 22, right: 22),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Container(
                    height: 25.h,
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
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 35, right: 10),
                          child: Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child: PopupMenuButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              elevation: 3.2,
                              offset: Offset(-20, 50),
                              itemBuilder: (context) {
                                return _listMenu.map((String choice) {
                                  return PopupMenuItem(
                                    value: choice,
                                    child: Container(
                                      width: 130,
                                      padding: EdgeInsets.all(10),
                                      decoration: clickItem == choice
                                          ? myClickDecoration()
                                          : myBoxDecoration(),
                                      child: Text(
                                        "$choice",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black45,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              onSelected: (value) async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                setState(() {
                                  clickItem = value.toString();
                                  print(clickItem);
                                });

                                if (value == 'Edit') {
                                  if (temp.length == 1) {
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

                                    await getCountriesBloc
                                        .getCountriesRequest();

                                    Navigator.of(context).pop();
                                    Get.to(UpdateContact(), arguments: index);
                                  } else {
                                    _snackBar(
                                        "Select", "Only one contact to update");
                                  }
                                } else if (value == 'Delete') {
                                  if (temp.length > 0) {
                                    deleteContact(context);
                                  } else {
                                    _snackBar("Delete Contact",
                                        "Please select first which you want to delete contact.");
                                  }
                                } else if (value == 'Create Group') {
                                  Get.to(CreateGroup());
                                } else if (value == 'All Groups') {
                                  getAllGroups(context);
                                }
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 7, bottom: 10),
                          width: MediaQuery.of(context).size.width * 0.90,
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
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 22, right: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        syncContact(context);
                      },
                      child: Container(
                        decoration: new BoxDecoration(
                          color: const Color(0xFFf2cfd4),
                          borderRadius: new BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: ImageIcon(
                            AssetImage('assets/images/sync.png'),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (temp.length == contactData.length) {
                          setState(() {
                            temp = [];
                          });
                        } else if (temp.length > contactData.length) {
                          setState(() {
                            temp = [];
                          });
                        } else {
                          setState(() {
                            for (var value in contactData) {
                              temp.add(value.id.toString());
                            }
                          });
                        }
                      },
                      child: Text(
                        'Select all',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 02.h),
              Expanded(
                child: isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(
                        color: main_color,
                      ))
                    : contactData.length != 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: _searchTEC.text.isEmpty
                                ? contactData.length
                                : _filteredList.length,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return _searchTEC.text.isEmpty
                                  ? _myContactsWidget(contactData[index], index)
                                  : _myContactsWidget(
                                      _filteredList[index], index);
                            })
                        : Container(
                            child: Center(
                              child: Text('There is no contacts'),
                            ),
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _myContactsWidget(ContactsData contacts, int index) {
    String finalUrl = '';
    try {
      String imagePath = contacts.imagePath!.toString();
      finalUrl = imageUrl + imagePath;
    } catch (error) {
      finalUrl = 'https://i.postimg.cc/mDrQwBDL/user3.png';
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
          left: 22,
          right: 22,
          bottom: index == contactData.length - 1 ? 80 : 10),
      height: 105,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  int id = contacts.id!;
                  getSingleContactDetail(context, id, index);
                },
                child: Container(
                  height: 72,
                  width: 72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
              InkWell(
                onTap: () {
                  index = index;
                  setState(() {
                    if (temp.contains(contacts.id.toString())) {
                      temp.remove(contacts.id.toString());
                    } else {
                      temp.add(contacts.id.toString());
                    }
                    print(contacts.id);
                  });

                  print(temp);
                },
                child: temp.contains(contacts.id.toString())
                    ? Icon(
                        Icons.radio_button_checked,
                        color: main_color,
                      )
                    : Icon(
                        Icons.radio_button_off,
                        color: Colors.black26,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getAllContact(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    await getAllContactBloc.getAllContactRequest();

    GetContactModel model = getAllContactBloc.getAllContactModel;

    setState(() {
      contactData = model.contacts!;
      isLoading = false;
      _contactLength = contactData.length;
      saveContactLength.write("count", contactData.length);
    });
  }

  deleteContact(BuildContext context) async {
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

    await getAllContactBloc.delContactsRequest(temp);
    await getAllContactBloc.getAllContactRequest();

    GetContactModel modelAll = getAllContactBloc.getAllContactModel;

    setState(() {
      temp = [];
      contactData = [];
      contactData = modelAll.contacts!;
    });

    Navigator.of(context).pop();
    CommonModel model = getAllContactBloc.delContactModel;

    _snackBar("Contact", model.message.toString());

    Get.offAll(() => BottomNavigation(), arguments: 4);
  }

  getSingleContactDetail(BuildContext context, int id, int index) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    await getAllContactBloc.getSingleContactAPI(id);
    Navigator.of(context).pop();

    Get.to(() => ContactInfo(), arguments: index);
  }

  getAllGroups(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    await groupBloc.getAllGroupsRequest();

    Navigator.of(context).pop();

    Get.to(() => AllGroups());
  }

  _searchFunction(String value) {
    _filteredList = [];
    for (int i = 0; i < contactData.length; ++i) {
      print(contactData[i].name);

      var name = contactData[i].name;
      var imagePath = contactData[i].imagePath;
      var id = contactData[i].id;

      if (name!.contains(value.toUpperCase()) ||
          name.contains(value.toLowerCase())) {
        _filteredList
            .add(ContactsData(name: name, imagePath: imagePath, id: id));
      }
      setState(() {
        print(_filteredList.length);
      });
    }
  }

  _snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black12,
      colorText: Colors.white,
    );
  }

  syncContact(BuildContext context) async {
    // Request contact permission
    if (await FlutterContacts.requestPermission()) {

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (dialogContext) {
            return Center(
                child: CircularProgressIndicator(
              color: main_color,
            ));
          });

    // Get all contacts (lightly fetched)
    List<Contact> contacts = await FlutterContacts.getContacts();

    // Get all contacts (fully fetched)
    contacts = await FlutterContacts.getContacts(withProperties: true);


    if (contacts.isEmpty) {
      Navigator.of(context).pop();
      _snackBar('Sync Failed', 'No Contacts Available.');
    } else {
      for (int i = 0; i < contacts.length; i++) {
        contacts[i].phones.forEach((element) {
          setState(() {
            print(element.number);
            syncList.add(element.number);
          });
        });


      }
    }
    }

    await syncContactsBloc.getSyncContactsAPI(syncList);

    GetContactSyncModel model = syncContactsBloc.getSyncContactsModel;
    Navigator.of(context).pop();

    Get.to(()=>AddSyncContacts());
    _snackBar("title", '${model.users!.length}');
  }

}
