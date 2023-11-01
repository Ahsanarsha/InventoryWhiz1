import 'dart:io';
import 'package:card_club/resources/models/common_model.dart';
import 'package:card_club/resources/models/get_contact_model.dart';
import 'package:card_club/resources/urls.dart';
import 'package:card_club/screens/address/all_contacts/bloc/all_contact_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import 'all_groups.dart';
import 'bloc/group_bloc.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {

  final formKey = GlobalKey<FormState>();
  var _groupNameTEC = TextEditingController();
  File? imageFile;

  GetContactModel model = getAllContactBloc.getAllContactModel;

  int? selectedRadio;

  List<ContactsData> contactData = [];
  List<String> temp = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getAllContact(context);
  }

  @override
  void dispose() {
    super.dispose();
    _groupNameTEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              width: 90.h,
              height: 07.h,
              margin: EdgeInsets.only(left: 30),
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

                  var groupsName = _groupNameTEC.text.trim();

                  if(formKey.currentState!.validate()){

                    if (temp.isEmpty) {
                     _snackBar("Required!", "minimum 1 user required.");
                    } else {

                      String imagePath;
                      if (imageFile == null) {
                        imagePath = '';
                      } else {
                        imagePath = imageFile!.path.toString();
                      }

                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return Center(
                            child:
                            CircularProgressIndicator(
                              color: main_color,
                            ),
                          );
                        });

                    await groupBloc.createGroupAPI(temp, groupsName,imagePath);
                    await groupBloc.getAllGroupsRequest();

                    CommonModel model = groupBloc.createGroupModel;

                    Navigator.of(context).pop();

                    temp = [];
                    Get.snackbar("Message", model.message.toString());
                    Get.off(()=>AllGroups());
                    }
                  }


                },
                child: Text(
                  "Create Group",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              )),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 50),
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
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showBottomSheet();
                  },
                  child: imageFile == null
                      ? Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width: 250,
                            height: 180,
                            child: CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage('assets/images/pick_image.png'),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: FileImage(imageFile!),
                                  fit: BoxFit.fill),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 14.0,
                                    offset: Offset(0.0, 0.75))
                              ],
                            ),
                          ),
                        ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 05.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Group name",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              color: Colors.black.withOpacity(0.85),
                            ),
                          ),
                          Form(
                            key: formKey,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.70,
                                  child: TextFormField(
                                    controller: _groupNameTEC,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      focusColor: main_color,
                                      contentPadding: EdgeInsets.only(top: 10),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: main_color),
                                      ),
                                      hintText: "Type group name...",
                                      hintStyle: TextStyle(
                                        color: Colors.black26,
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                      ),
                                    ),
                                    style: TextStyle(fontSize: 16),
                                    cursorColor: main_color,
                                    validator: (String? value) {
                                      if (_groupNameTEC.text.isEmpty)
                                        return "Required! Group name";
                                      else if(_groupNameTEC.text.length>15)
                                        return 'Group name is too long.';
                                      else
                                        return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(top: 40),
                          child: Image(
                            height: 20,
                            width: 20,
                            image: AssetImage('assets/icons/ic_emoji.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Participants: ${temp.length}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 03.h),
                isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(
                        color: main_color,
                      ))
                    : contactData.length != 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: contactData.length,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return _myContactsWidget(
                                  contactData[index], index);
                            })
                        : Container(
                            child: Center(
                              child: Text('There is no contacts'),
                            ),
                          ),
                SizedBox(height: 20),
              ],
            ),
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
      margin: EdgeInsets.only(right: 22),
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

  void _snackBar(var title, var message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.black12, colorText: Colors.white);
  }

}
