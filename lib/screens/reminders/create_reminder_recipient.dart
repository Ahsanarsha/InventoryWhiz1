import 'package:card_club/resources/models/get_reminder_model.dart';
import 'package:card_club/resources/models/get_contact_model.dart';
import 'package:card_club/resources/urls.dart';
import 'package:card_club/screens/address/all_contacts/bloc/all_contact_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';
import 'package:sizer/sizer.dart';

class CreateReminderRecipient extends StatefulWidget {
  const CreateReminderRecipient({Key? key}) : super(key: key);

  @override
  _CreateReminderRecipientState createState() => _CreateReminderRecipientState();
}

class _CreateReminderRecipientState extends State<CreateReminderRecipient> {


  var _searchTEC = TextEditingController();
  GetContactModel model = getAllContactBloc.getAllContactModel;

  int? selectedRadio;

  List<ContactsData> contactData = [];
  List<String> temp = [];
  List<ContactsData> _filteredList = [];
  bool isLoading = false;

  List<Contacts> getList=[];



  @override
  void initState() {
    super.initState();
    getAllContact(context);

    temp=[];
  }

  @override
  void dispose() {
    _searchTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    try {
      contactData = model.contacts!;
    } catch (error) {
      print(error);
    }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          // margin: const EdgeInsets.only(top: 35, left: 22, right: 22),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height:05.h,
                            margin: EdgeInsets.only(top: 30, left: 22, right: 22),
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
                                Navigator.of(context).pop(getList);
                              },
                              child: Text(
                                "Back",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              height:05.h,
                              margin: EdgeInsets.only(top: 30, left: 22, right: 22),
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
                                  Navigator.of(context).pop(getList);
                                },
                                child: Text(
                                  "Done",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 03.h),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 7, bottom: 04.h),
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: 07.h,
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
                      'Recipient',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.75),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      'Who is the recipient?',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),

              Expanded(
                child: isLoading == true
                    ? Center(
                    child: CircularProgressIndicator(
                      color: main_color,
                    ))
                    : contactData.isNotEmpty
                    ? ListView.builder(
                    shrinkWrap: true,
                    itemCount:  _searchTEC.text.isEmpty
                        ? contactData.length
                        : _filteredList.length,
                    physics: const BouncingScrollPhysics(),
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
          bottom: 0),
      height: 105,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
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
                  setState(() {
                    if (temp.contains(contacts.id.toString())) {
                      temp.remove(contacts.id.toString());

                      getList.removeWhere((data) => data.id == contacts.id);

                    } else {
                      temp.add(contacts.id.toString());

                      getList.add(Contacts(id:contacts.id,imagePath: contacts.imagePath));

                    }
                    print(contacts.id);
                  });

                  print(temp);
                  print(getList);
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

  void getAllContact(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    await getAllContactBloc.getAllContactRequest();
    GetContactModel model = getAllContactBloc.getAllContactModel;

    setState(() {
      contactData = model.contacts!;
      isLoading = false;
    });
  }

  _searchFunction(String value) {
    _filteredList = [];
    for (int i = 0; i < contactData.length; ++i) {
      print(contactData[i].name);

      var name = contactData[i].name;
      var imagePath = contactData[i].imagePath;
      var id = contactData[i].id;

      if (name!.contains(_searchTEC.text.toLowerCase())) {
        _filteredList
            .add(ContactsData(name: name, imagePath: imagePath, id: id));
      }
      setState(() {
        print(_filteredList.length);
      });
    }
  }

}
