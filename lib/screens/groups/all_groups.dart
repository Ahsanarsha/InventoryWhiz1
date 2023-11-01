import 'package:card_club/resources/models/common_model.dart';
import 'package:card_club/resources/models/get_all_groups_model.dart';
import 'package:card_club/screens/groups/update_group.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';
import 'package:sizer/sizer.dart';
import '../../resources/urls.dart';
import 'bloc/group_bloc.dart';
import 'edit_group_members.dart';

class AllGroups extends StatefulWidget {
  const AllGroups({Key? key}) : super(key: key);

  @override
  _AllGroupsState createState() => _AllGroupsState();
}

class _AllGroupsState extends State<AllGroups> {

  var _searchTEC = TextEditingController();
  GetAllGroupsModel _allGroupsModel = groupBloc.getAllGroupsModel;

  List<String> temp = [];
  List<Groups>? groups = [];
  List<Groups> _filteredList = [];

  int groupID = 0;

  @override
  void initState() {
    super.initState();
    groups = _allGroupsModel.groups;
  }

  @override
  Widget build(BuildContext context) {
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

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

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
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Container(
                    height: 32.h,
                    padding: EdgeInsets.only(top: 30, left: 22, right: 0),
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
                              height: 05.h,
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
                            Container(
                              alignment: Alignment.topRight,
                              child: Theme(
                                data: ThemeData(
                                  splashColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                ),
                                child: PopupMenuButton(
                                  elevation: 3.2,
                                  offset: Offset(-20, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      child: Container(
                                        width: 130,
                                        padding: EdgeInsets.all(10),
                                        decoration: myBoxDecoration(),
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black45,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ),
                                      value: 1,
                                    ),
                                    PopupMenuItem(
                                      child: Container(
                                        width: 130,
                                        padding: EdgeInsets.all(10),
                                        decoration: myBoxDecoration(),
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black45,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ),
                                      value: 2,
                                    ),
                                  ],
                                  onSelected: (int index) async {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    if (index == 1) {
                                      if (temp.length == 1) {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (dialogContext) {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                color: main_color,
                                              ));
                                            });

                                        await groupBloc
                                            .getSingleGroupDetailAPI(groupID);
                                        Navigator.of(context).pop();

                                        Get.to(() => UpdateGroup());
                                      } else {
                                        _snackBar("Not Edit!",
                                            "For Edit Group only select 1 (Groups).");
                                      }
                                    } else if (index == 2) {
                                      if (temp.isEmpty) {
                                        _snackBar("Required!",
                                            "Please Select group first.");
                                      } else {
                                        showDeleteGroupDialog();
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 03.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Groups",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat',
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 7, bottom: 04.h, right: 20),
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
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 40, left: 22, right: 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Groups',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.75),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Your Groups',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 03.h),
              Expanded(
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 5,
                      childAspectRatio: isPortrait ? 0.82 : 1,
                    ),
                    physics: BouncingScrollPhysics(),
                    itemCount: _searchTEC.text.isEmpty
                        ? groups!.length
                        : _filteredList.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return _searchTEC.text.isEmpty
                          ? _myGroupsWidget(groups![index], index)
                          : _myGroupsWidget(_filteredList[index], index);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _myGroupsWidget(Groups groups, int position) {
    String finalUrl;
    try {
      String imagePath = groups.imagePath!.toString();
      finalUrl = imageUrl + imagePath;
    } catch (error) {
      finalUrl = "https://i.postimg.cc/K8kPGR9s/clipart.png";
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print(groupID);
              Get.to(() => EditGroupMembers(), arguments: position);
            },
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
          SizedBox(height: 01.h),
          Text(
            groups.title.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
            ),
          ),
          SizedBox(height: 01.h),
          InkWell(
            onTap: () {
              setState(() {
                groupID = groups.id!;
                if (temp.contains(groups.id.toString())) {
                  temp.remove(groups.id.toString());
                } else {
                  temp.add(groups.id.toString());
                }
                print(groups.id);
              });

              print(temp);
            },
            child: temp.contains(groups.id.toString())
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
    );
  }

  _snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black12,
      colorText: Colors.white,
    );
  }

  showDeleteGroupDialog() {
    showGeneralDialog(
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.1),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 200,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 00,
                    ),
                    Text(
                      'Delete Group(s)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Are you sure you want to delete \nthese ${temp.length} group(s).',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        color: Colors.black.withOpacity(0.30),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 50,
                              margin: const EdgeInsets.only(top: 25),
                              decoration: const BoxDecoration(
                                color: main_color,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(37)),
                              ),
                              child: const Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                              await deleteGroups(context);
                            },
                            child: Container(
                              height: 50,
                              margin: const EdgeInsets.only(top: 25),
                              decoration: const BoxDecoration(
                                color: main_color,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(37)),
                              ),
                              child: const Center(
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 4), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }

  deleteGroups(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    await groupBloc.delGroupsRequest(temp);
    await groupBloc.getAllGroupsRequest();

    CommonModel model = groupBloc.delGroupsModel;
    GetAllGroupsModel _allGroupsModel = groupBloc.getAllGroupsModel;

    Navigator.of(context).pop();

    _snackBar("Group", model.message.toString());
    setState(() {
      groups=[];
      groups = _allGroupsModel.groups;
    });
  }

  _searchFunction(String value) {
    _filteredList = [];
    for (int i = 0; i < groups!.length; ++i) {
      print(groups![i].title);

      var title = groups![i].title;
      var imagePath = groups![i].imagePath;
      var id = groups![i].id;

      if (title!.contains(value.toUpperCase()) ||
          title.contains(value.toLowerCase())) {
        _filteredList.add(Groups(title: title, imagePath: imagePath, id: id));
      }
      setState(() {
        print(_filteredList.length);
      });
    }
  }
}
