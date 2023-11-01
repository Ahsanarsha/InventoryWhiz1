import 'package:card_club/resources/models/all_cards_model.dart';
import 'package:card_club/resources/models/get_cart_items_model.dart';
import 'package:card_club/resources/models/user_profile_model.dart';
import 'package:card_club/resources/urls.dart';
import 'package:card_club/screens/cart_item/bloc/cart_bloc.dart';
import 'package:card_club/screens/home_card/bloc/all_card_bloc.dart';
import 'package:card_club/screens/profile/bloc/user_profile_bloc.dart';
import 'package:card_club/screens/setting_profile/edit_user_profile.dart';
import 'package:card_club/screens/wishlist/user_wishlist.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';
import 'package:sizer/sizer.dart';

import '../../test/testing.dart';
import '../cart_item/cart_items.dart';
import '../inbox/bloc/notification_bloc.dart';
import '../inbox/user_inbox.dart';
import '../wishlist/bloc/wishlist_bloc.dart';
import 'card_product_page.dart';

class EditCard extends StatefulWidget {
  const EditCard({Key? key}) : super(key: key);

  @override
  _EditCardState createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
  UserProfileModel profileModel = userProfileBloc.userProfileModel;

  List<Cards> cardsList = [];
  bool isLoading = false;
  int lastID = 0;

  //todo::new code
  int _pageNumber = 1;
  bool _isLoadMoreRunning = false;
  bool _hasNextPage = true;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _scrollController.addListener(_loadMore);
  }

  @override
  Widget build(BuildContext context) {
    String finalUrl = '';
    try {
      String imagePath = profileModel.imagePath!.toString();
      finalUrl = imageUrl + imagePath;
    } catch (error) {
      print(error);
    }

    var size = MediaQuery.of(context).size;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: main_color,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 20, right: 02.h, left: 02.h, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(30), // Image radius
                        child: finalUrl != ''
                            ? ImageCacheing(
                                fit: BoxFit.cover,
                                url: finalUrl,
                                loadingWidget: Center(
                                  child: CircularProgressIndicator(),
                                ))
                            : Image.asset('assets/images/circularperson.png'),
                      ),
                    ),
                    onTap: () {
                      Get.to(() => EditUserProfile());
                    },
                  ),
                  Flexible(
                    child: Text(
                      'Hi,${profileModel.name.toString()}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.10),
                  InkWell(
                    onTap: () async {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (dialogContext) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: main_color,
                            ));
                          });

                      await wishlistBloc.wishlistRequest();

                      Navigator.of(context).pop();

                      Get.to(() => UserWishList());
                    },
                    child: ImageIcon(
                      AssetImage('assets/images/wish_list.png'),
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 2),
                  InkWell(
                    onTap: () async {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (dialogContext) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: main_color,
                            ));
                          });

                      await cartBloc.getCartRequest();

                      GetCartItemsModel model = cartBloc.getCartModel;

                      if (model.status == 200) {
                        Navigator.of(context).pop();
                        Get.to(CartItems());
                      }
                    },
                    child: ImageIcon(
                      AssetImage('assets/images/order_status.png'),
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 2),
                  InkWell(
                    onTap: () async {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (dialogContext) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: main_color,
                            ));
                          });

                      await notificationBloc.getNotificationAPI();

                      Navigator.of(context).pop();
                      Get.to(() => UserInbox());
                    },
                    child: ImageIcon(
                      AssetImage('assets/images/bell.png'),
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            //SizedBox(height: size.height*0.007),
            Expanded(
              child: Container(
                height: size.height,
                padding: EdgeInsets.fromLTRB(22, 0, 22, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.04),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.all(Radius.circular(37)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 30, top: 2),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: TextStyle(
                              color: Colors.black12,
                              fontFamily: 'Montserrat',
                            ),
                            border: InputBorder.none,
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(
                                Icons.search,
                                size: 33,
                                color: Colors.black12,
                              ),
                            ),
                          ),
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.06),
                    Expanded(
                      child: ListView(
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Best Seller Products',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              Container(
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      aspectRatio: 2.0,
                                      enlargeCenterPage: false,
                                      viewportFraction:1,
                                      pageSnapping:true,
                                      scrollDirection: Axis.horizontal,
                                      autoPlay: true,
                                    ),
                                    items: imageSliders,
                                  )),


                              SizedBox(height: size.height * 0.02),
                              Text(
                                'Best Products',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              cardsList.isNotEmpty
                                  ? GridView.count(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      shrinkWrap: true,
                                      mainAxisSpacing: 10,
                                      physics: ScrollPhysics(),
                                      children: List.generate(
                                        cardsList.length,
                                        (index) {
                                          return _cardWidget(
                                              cardsList[index], index);
                                        },
                                      ),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                        color: main_color,
                                      ),
                                    ),
                              _isLoadMoreRunning == true
                                  ? Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, bottom: 20),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: main_color,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardWidget(Cards cardsList, int index) {
    String cardImage = cardsList.imagePath.toString();
    String finalUrl = imageUrl + cardImage;

    return GestureDetector(
      onTap: () {
        List<Cards> list = [];

        list.add(Cards(
            id: cardsList.id,
            cardCategoriesId: cardsList.cardCategoriesId,
            title: cardsList.title,
            scope: cardsList.scope,
            imagePath: cardsList.imagePath,
            imageName: cardsList.imageName,
            soldQuantity: cardsList.soldQuantity,
            qty: cardsList.qty,
            price: cardsList.price,
            createdAt: cardsList.createdAt,
            updatedAt: cardsList.updatedAt));

        Get.to(() => CardProductPage(), arguments: list);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: ImageCacheing(
            fit: BoxFit.cover,
            url: finalUrl,
            loadingWidget: Center(
              child: CircularProgressIndicator(),
            )),
      ),
    );
  }

  _loadInitialData() async {
    await allCardBloc.loadFirstCardsApi();

    AllCardModel _model = allCardBloc.loadFirstCardsModel;

    setState(() {
      cardsList = [];
      _model.data!.data!.forEach((element) {
        cardsList.add(element);
      });
    });
  }

  _loadMore() async {
    if (_hasNextPage == true &&
        _isLoadMoreRunning == false &&
        _scrollController.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _pageNumber += 1; // Increase _page by 1
      try {
        await allCardBloc.loadMoreCardsApi(_pageNumber);

        AllCardModel _model = allCardBloc.loadMoreCardsModel;

        setState(() {
          _model.data!.data!.forEach((element) {
            cardsList.add(element);
          });
          if (_model.data!.data!.isEmpty) {
            _hasNextPage = false;
          }
        });
      } catch (err) {
        print('Something went wrong  $err');
        setState(() {
          _hasNextPage = false;
        });
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }
}
