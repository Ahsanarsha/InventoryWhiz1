import 'package:card_club/resources/models/get_gift_by_id_model.dart';
import 'package:card_club/resources/models/gift_category_model.dart';
import 'package:card_club/resources/models/gift_detail_model.dart';
import 'package:card_club/resources/models/gift_favorite_model.dart';
import 'package:card_club/resources/urls.dart';
import 'package:card_club/screens/home_gift/bloc/gift_bloc.dart';
import 'package:card_club/screens/home_gift/bloc/popular_gift_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:color_thief_flutter/color_thief_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cacheing/widget/image_cacheing_widget.dart';
import 'package:sizer/sizer.dart';

import '../../resources/cache_manager.dart';
import '../../resources/models/get_popular_gift_model.dart';
import 'bloc/get_gift_by_id_bloc.dart';
import 'bloc/gift_detail_bloc.dart';
import 'gift_product_page.dart';

class Gifts extends StatefulWidget {
  const Gifts({Key? key}) : super(key: key);

  @override
  _GiftsState createState() => _GiftsState();
}

class _GiftsState extends State<Gifts> {

  GiftCategoryModel giftCategoryModel = getGiftBYIdBloc.giftCategoryModel;
  GetGiftByIDModel _getGiftByIDModel = getGiftBYIdBloc.getGiftByIdModel;

  List<GiftsData> giftList = [];
  var categoryID = 1;
  var isLoading = false.obs;
  var isLoadingFav = false.obs;

  //todo::new code
  int _pageNumber = 0;
  bool _isLoadMoreRunning = false;
  bool _hasNextPage = true;
  List<DataModel> feedList = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    giftList = _getGiftByIDModel.giftsData!;

    _loadInitialData();
    _scrollController.addListener(_loadMore);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    //Controler _controler=Get.put(Controler());

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 16, bottom: 0),
        child: ListView(
            physics: BouncingScrollPhysics(),
            controller: _scrollController,
            children: [
              SizedBox(height: size.height * 0.1),
              Text(
                'Products',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              Container(
                width: size.width * 1,
                height: isPortrait ? size.height * 0.4 : size.height * 0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    giftCategoryModel.data!.isNotEmpty
                        ? Expanded(
                            flex: 1,
                            child: Container(
                              width: size.width,
                              height: 33.h,
                              child: ListView.builder(
                                itemCount: giftCategoryModel.data!.length,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return _myGiftCategoryWidget(
                                      giftCategoryModel.data![index]);
                                },
                              ),
                            ),
                          )
                        : Expanded(
                            flex: 1,
                            child: Container(
                              width: size.width,
                              height: size.height * 0.33,
                              child: CircularProgressIndicator(
                                color: main_color,
                              ),
                            ),
                          ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: size.width,
                        height: 33.h,
                        child: Obx(
                          () => isLoading.value
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: main_color,
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: giftList.length,
                                  // itemCount: _controler.data.length,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _myGiftBoxWidget(giftList[index]);
                                  },
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Most Popular',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              feedList.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: feedList.length,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return _myPopularGiftWidget(feedList[index]);
                      })
                  : Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: main_color,
                        ),
                      ),
                    ),
              _isLoadMoreRunning == true
                  ? Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: main_color,
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(height: 70),
            ]),
      ),
    );
  }

  Widget _myGiftCategoryWidget(Data data) {
    return InkWell(
      onTap: () async {
        var cardID = data.id;

        isLoading.value = true;

        await getGiftBYIdBloc.getGiftByIdRequest(cardID);
        //todo::set data and update UI
        setState(() {
          categoryID = cardID!;
          giftList = [];
          GetGiftByIDModel model = getGiftBYIdBloc.getGiftByIdModel;
          giftList = model.giftsData!;
        });
        isLoading.value = false;
      },
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10, bottom: 20, top: 20),
        child: Text(
          data.title.toString(),
          style: TextStyle(
            fontSize: 14,
            color: Colors.black45,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }

  Widget _myGiftBoxWidget(GiftsData gifts) {
    String cardImage = gifts.imagePath.toString();
    String finalUrl = imageUrl + cardImage;

    var isEmptyList = gifts.wishlist?.isNotEmpty;

    var colorFinal = main_color.obs;
    var isLoading = false.obs;

    getColorFromUrl(finalUrl).then(
      (color) {
        // [R,G,B]
        colorFinal.value =
            Color(hexOfRGBA(color[0], color[1], color[2], opacity: 0.5));
      },
    );

    return Obx(
      () => Container(
        width: MediaQuery.of(context).size.width * 0.40,
        margin: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: colorFinal.value,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                gifts.title.toString(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                ),
                maxLines: 1,
              ),
            ),
            InkWell(
              onTap: () async {
                var id = gifts.id;
                isLoading.value = true;

                await giftDetailBloc.giftDetailRequest(id);

                GiftDetailModel _model = giftDetailBloc.giftDetailModel;
                isLoading.value = false;

                Get.to(() => GiftProductPage(), arguments: _model);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Image.network(
                      finalUrl,
                      height: 115,
                      width: 140,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Center(
                    child: Obx(
                      () => isLoading.value
                          ? CircularProgressIndicator(
                              color: main_color,
                            )
                          : Container(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "\$ " + gifts.price.toString(),
                    style: TextStyle(
                      color: Color(0xFF9E4C34),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      _addToWisList(gifts.id);
                    },
                    child: isEmptyList == true
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Image.asset(
                            'assets/icons/ic_heart.png',
                            height: 20,
                            width: 20,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _myPopularGiftWidget(DataModel dataList) {
    var isEmptyList = dataList.wishlist?.isNotEmpty;

    String finalUrl = '';
    try {
      String imagePath = dataList.imagePath!.toString();
      finalUrl = imageUrl + imagePath;
    } catch (error) {
      finalUrl = 'https://i.postimg.cc/mDrQwBDL/user3.png';
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      height: 105,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 105,
            width: 105,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 17,
                    right: 17,
                    top: 5,
                  ),
                  child: Text(
                    '${dataList.title}',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 17, right: 17),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '\$ ${dataList.price}',
                          style: TextStyle(
                            color: Color(0xFF9E4C34),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            _addToWisListPopular(dataList.id);
                          },
                          child: isEmptyList == true
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Image.asset(
                                  'assets/icons/ic_heart.png',
                                  height: 20,
                                  width: 20,
                                ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _addToWisList(int? giftID) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    await giftBloc.addToWishListAPI('gift_id',giftID!);
    await getGiftBYIdBloc.getGiftByIdRequest(categoryID);

    GiftFavoriteModel modelF = giftBloc.addToWishListModel;
    GetGiftByIDModel model = getGiftBYIdBloc.getGiftByIdModel;

    setState(() {
      giftList = [];
      giftList = model.giftsData!;
    });

    Navigator.of(context).pop();

    Get.snackbar("Favorite", modelF.message.toString());
  }

  _addToWisListPopular(int? giftID) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          return Center(
              child: CircularProgressIndicator(
            color: main_color,
          ));
        });

    await giftBloc.addToWishListAPI('gift_id',giftID!);
    await getGiftBYIdBloc.getGiftByIdRequest(categoryID);
    await _loadInitialData();

    Navigator.of(context).pop();

    GiftFavoriteModel modelF = giftBloc.addToWishListModel;
    Get.snackbar("Favorite", modelF.message.toString());
  }

  int hexOfRGBA(int r, int g, int b, {double opacity = 1}) {
    r = (r < 0) ? -r : r;
    g = (g < 0) ? -g : g;
    b = (b < 0) ? -b : b;
    opacity = (opacity < 0) ? -opacity : opacity;
    opacity = (opacity > 1) ? 255 : opacity * 255;
    r = (r > 255) ? 255 : r;
    g = (g > 255) ? 255 : g;
    b = (b > 255) ? 255 : b;
    int a = opacity.toInt();
    return int.parse(
        '0x${a.toRadixString(16)}${r.toRadixString(16)}${g.toRadixString(16)}${b.toRadixString(16)}');
  }

  _loadInitialData() async {
    await getPopularGiftBloc.getPopularGiftRequest();

    GetPopularGiftModel _model = getPopularGiftBloc.getPopularGiftModel;

    setState(() {
      feedList = [];
      _model.popularGifts!.data!.forEach((element) {
        feedList.add(element);
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
        await getPopularGiftBloc.loadMoreGiftRequest(_pageNumber);

        GetPopularGiftModel model = getPopularGiftBloc.loadMoreGiftModel;

        setState(() {
          model.popularGifts!.data!.forEach((element) {
            feedList.add(element);
          });
          if (model.popularGifts!.data!.isEmpty) {
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
