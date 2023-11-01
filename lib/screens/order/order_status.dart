import 'package:card_club/resources/models/get_single_order_model.dart';
import 'package:card_club/screens/order/bloc/order_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({Key? key}) : super(key: key);

  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  GetSingleOrderModel _singleOrderModel = orderBloc.getSingleOrderModel;
  int currentStep = 1;

  @override
  void initState() {
    super.initState();

    setState(() {
      currentStep = _singleOrderModel.data!.order!.orderStatus!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 30, left: 20, right: 22),
          width: MediaQuery.of(context).size.width,
          child: ListView(
            physics: BouncingScrollPhysics(),
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
              SizedBox(height: 30),
              Text(
                'Order Status',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.75),
                ),
              ),
              SizedBox(height: 50),
              if (currentStep == 1)
                Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                    right: 25,
                  ),
                  child: Image.asset(
                    'assets/images/one_delivery.png',
                  ),
                )
              else if (currentStep == 2)
                Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                    right: 25,
                  ),
                  child: Image.asset(
                    'assets/images/two_delivery.png',
                  ),
                )
              else if (currentStep == 3)
                Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                    right: 25,
                  ),
                  child: Image.asset(
                    'assets/images/three_delivery.png',
                  ),
                )
              else if (currentStep == 4)
                Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                    right: 25,
                  ),
                  child: Image.asset(
                    'assets/images/four_delivery.png',
                  ),
                ),
              //todo::if else end
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/order_placed.png',
                        height: 30,
                        width: 30,
                        color: currentStep == 1
                            ? Colors.black.withOpacity(0.75)
                            : Colors.black45,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Order\nPlaced",
                        style: TextStyle(
                          color: currentStep == 1
                              ? Colors.black.withOpacity(0.75)
                              : Colors.black45,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/packed.png',
                        height: 30,
                        width: 30,
                        color: currentStep == 2 ? Colors.black : Colors.black45,
                      ),
                      Text(
                        "Packed",
                        style: TextStyle(
                          color:
                              currentStep == 2 ? Colors.black : Colors.black45,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/shipped.png',
                        height: 30,
                        width: 30,
                        color: currentStep == 3 ? Colors.black : Colors.black45,
                      ),
                      Text(
                        "Shipped",
                        style: TextStyle(
                          color:
                              currentStep == 3 ? Colors.black : Colors.black45,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/delivered.png',
                        height: 30,
                        width: 30,
                        color: currentStep == 4 ? Colors.black : Colors.black45,
                      ),
                      Text(
                        "Delivered",
                        style: TextStyle(
                          color:
                              currentStep == 4 ? Colors.black : Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customer information",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.75),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${_singleOrderModel.data!.order!.user!.name}',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Username",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${_singleOrderModel.data!.order!.user!.email}',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${_singleOrderModel.data!.order!.user!.phoneNum}',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${_singleOrderModel.data!.order!.address!.addressName}',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${_singleOrderModel.data!.order!.address!.streetAddress1}',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${_singleOrderModel.data!.order!.address!.cityId}',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Products information",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.75),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${_singleOrderModel.data!.order!.user!.imageName}',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
