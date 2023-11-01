import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';
import 'package:phonenumbers/phonenumbers.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DropdownSearch Demo")),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            PhoneNumberField(
              controller: PhoneNumberEditingController.fromCountryCode('AZ'),
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 24),
            PhoneNumberFormField(
              autovalidateMode: AutovalidateMode.always,
              controller: PhoneNumberEditingController.fromCountryCode('TR'),
              decoration: InputDecoration(border: UnderlineInputBorder()),
            ),
            ImageCacheing(
                height: 100,
                width: 100,
                url: 'https://i.postimg.cc/PrMqF6nW/apple.png',
                loadingWidget: Center(
                  child: CircularProgressIndicator(),
                )),

            Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                  ),
                  items: imageSliders,
                )),

          ],
        ),
      ),
    );
  }

}

final List<String> imgList = [
  'https://i.postimg.cc/bwR19xGd/Group-58.png',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];


final List<Widget> imageSliders = imgList
    .map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
           // Image.network(item, fit: BoxFit.cover, width: 1000.0),

            ImageCacheing(
                width: 1000.0,
                height: 200,
                fit: BoxFit.cover,
                url: item,
                loadingWidget: Center(
                  child: CircularProgressIndicator(),
                )),
            Container(
              color: Colors.transparent,
              alignment: Alignment.bottomLeft,
              height: 145,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20),
                    //    side:  const BorderSide(color: Colors.grey)
                  ),
                  onPressed: () {
                    //Get.to(() => TestPage());
                  },
                  child: Text(
                    'Shop now',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )),
  ),
))
    .toList();
