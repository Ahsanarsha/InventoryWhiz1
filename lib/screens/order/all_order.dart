import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../resources/models/get_order_model.dart';
import 'bloc/order_bloc.dart';
import 'order_status.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({Key? key}) : super(key: key);

  @override
  _AllOrderScreenState createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  GetOrderModel _getOrderModel = orderBloc.getAllOrderModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 45, left: 22, right: 22),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
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
              Container(
                padding: const EdgeInsets.only(bottom: 10, top: 20, left: 5),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'My Orders',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              SizedBox(height: 04.h),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _getOrderModel.order!.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return _myOrderWidget(_getOrderModel.order![index]);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _myOrderWidget(OrderData order) {
    return GestureDetector(
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

        await orderBloc.getSingleOrderApi(order.id!);

        Navigator.of(context).pop();

        Get.to(() => OrderStatus());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0.0, 0.75))
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Shipping:'),
                  Text(
                    '${order.shippingService}',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total:'),
                  Text(
                    '\$ ${order.grandTotal}',
                    style: TextStyle(
                      color: price_color,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
