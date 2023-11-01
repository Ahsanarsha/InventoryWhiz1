import 'package:card_club/resources/models/common_model.dart';
import 'package:card_club/screens/setting_profile/bloc/debit_card_bloc.dart';
import 'package:card_club/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../resources/models/get_debit_card_model.dart';

class AddDebitCard extends StatefulWidget {
  const AddDebitCard({Key? key}) : super(key: key);

  @override
  _AddDebitCardState createState() => _AddDebitCardState();
}

class _AddDebitCardState extends State<AddDebitCard> {
  var _cardHolderNameTEC = TextEditingController();
  var _cardNumberTEC = TextEditingController();
  var _monthTEC = TextEditingController();
  var _yearTEC = TextEditingController();
  var _cvvTEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  GetDebitCardModel? getModel;
  bool isAdded = false;

  @override
  void initState() {
    super.initState();
    getModel = debitCardBloc.getDebitCardModel;
  }

  @override
  void dispose() {
    super.dispose();
    _cardHolderNameTEC.dispose();
    _cardNumberTEC.dispose();
    _monthTEC.dispose();
    _yearTEC.dispose();
    _cvvTEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      _cardHolderNameTEC.text = '${getModel!.paymentCard!.cardHolderName}';
      _cardNumberTEC.text = '${getModel!.paymentCard!.cardNumber}';
      _monthTEC.text = '${getModel!.paymentCard!.expireMonth}';
      _yearTEC.text = '${getModel!.paymentCard!.expireYear}';
      _cvvTEC.text = '${getModel!.paymentCard!.cvv}';
      isAdded = true;
    } catch (error) {
      print(error);
      isAdded = false;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 30, left: 22, right: 22),
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
              Form(
                key: formKey,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Credit/Debit card',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 01.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Edit or remove card information",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 06.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Card holder name:",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 02.h),
                      TextFormField(
                        controller: _cardHolderNameTEC,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black12,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: main_color,
                            ),
                          ),
                        ),
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(20),
                        ],
                        validator: (String? value) {
                          if (_cardHolderNameTEC.text.isEmpty)
                            return "Name is required!";
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 02.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Card number:",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 02.h),
                      TextFormField(
                        controller: _cardNumberTEC,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black12,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: main_color,
                            ),
                          ),
                        ),
                        validator: (String? value) {
                          if (_cardNumberTEC.text.isEmpty)
                            return "Card number required!";
                          else if (_cardNumberTEC.text.length <= 13)
                            return "At least 13 digit";
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 02.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Expire date:",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 02.h),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: _monthTEC,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: main_color,
                                  ),
                                ),
                                hintText: "Month",
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                ),
                              ),
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(11),
                              ],
                              validator: (String? value) {
                                if (_monthTEC.text.isEmpty)
                                  return "Month required!";
                                else if (_monthTEC.text.length <= 1)
                                  return "At least 2 digit";
                                else
                                  return null;
                              },
                            ),
                          ),
                          SizedBox(width: 02.h),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: _yearTEC,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: main_color,
                                  ),
                                ),
                                hintText: "Year",
                                hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                ),
                              ),
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(11),
                              ],
                              validator: (String? value) {
                                if (_yearTEC.text.isEmpty)
                                  return "Year is required!";
                                else if (_yearTEC.text.length <= 3)
                                  return "At least 4 digit";
                                else
                                  return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 02.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "CVV:",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 02.h),
                      TextFormField(
                        controller: _cvvTEC,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black12,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: main_color,
                            ),
                          ),
                        ),
                        validator: (String? value) {
                          if (_cvvTEC.text.isEmpty)
                            return "Card number required!";
                          else
                            return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  getModel!.paymentCard.isNull
                      ? Container()
                      : Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {
                                int id = getModel!.paymentCard!.id!;
                                if (formKey.currentState!.validate()) {
                                  removeDebitCard(id);
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.90,
                                height: 50,
                                margin: const EdgeInsets.only(top: 12),
                                decoration: const BoxDecoration(
                                  color: main_color,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(37)),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Remove",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(width: 1.h),
                  getModel!.paymentCard.isNull
                      ? Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () async {
                                String cardHolderName =
                                    _cardHolderNameTEC.text.trim();
                                String cardNumber = _cardNumberTEC.text.trim();
                                String expireMonth = _monthTEC.text.trim();
                                String expireYear = _yearTEC.text.trim();
                                String cvv = _cvvTEC.text.trim();

                                if (formKey.currentState!.validate()) {
                                  saveDebitCard(
                                    context,
                                    cardHolderName,
                                    cardNumber,
                                    expireMonth,
                                    expireYear,
                                    cvv,
                                  );
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.90,
                                height: 50,
                                margin: const EdgeInsets.only(top: 12),
                                decoration: const BoxDecoration(
                                  color: main_color,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(37)),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Save",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () async {
                                String cardHolderName =
                                    _cardHolderNameTEC.text.trim();
                                String cardNumber = _cardNumberTEC.text.trim();
                                String expireMonth = _monthTEC.text.trim();
                                String expireYear = _yearTEC.text.trim();
                                String cvv = _cvvTEC.text.trim();
                                int id = getModel!.paymentCard!.id!;

                                if (formKey.currentState!.validate()) {
                                  updateDebitCard(
                                    context,
                                    id,
                                    cardHolderName,
                                    cardNumber,
                                    expireMonth,
                                    expireYear,
                                    cvv,
                                  );
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.90,
                                height: 50,
                                margin: const EdgeInsets.only(top: 12),
                                decoration: const BoxDecoration(
                                  color: main_color,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(37)),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Update",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              SizedBox(height: 02.h),
            ],
          ),
        ),
      ),
    );
  }

  saveDebitCard(
    BuildContext context,
    String cardHolderName,
    String cardNumber,
    String expireMonth,
    String expireYear,
    String cvv,
  ) async {
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

    await debitCardBloc.saveDebitCardAPI(
      cardHolderName,
      cardNumber,
      expireMonth,
      expireYear,
      cvv,
    );

    await debitCardBloc.getDebitCardAPI();

    Navigator.of(context).pop();

    GetDebitCardModel _getDebitModel = debitCardBloc.getDebitCardModel;
    CommonModel _commonModel = debitCardBloc.addDebitCardModel;
    _snackBar("Message", _commonModel.message);

    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      getModel = _getDebitModel;
    });
  }

  updateDebitCard(
    BuildContext context,
    int id,
    String cardHolderName,
    String cardNumber,
    String expireMonth,
    String expireYear,
    String cvv,
  ) async {
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

    await debitCardBloc.updateDebitCardAPI(
      id,
      cardHolderName,
      cardNumber,
      expireMonth,
      expireYear,
      cvv,
    );

    await debitCardBloc.getDebitCardAPI();

    Navigator.of(context).pop();

    CommonModel _commonModel = debitCardBloc.updateDebitCardModel;
    _snackBar("Message", _commonModel.message);

    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      getModel = debitCardBloc.getDebitCardModel;
    });
  }

  removeDebitCard(int id) async {
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

    await debitCardBloc.delDebitCardAPI(id);

    Navigator.of(context).pop();

    CommonModel _commonModel = debitCardBloc.delDebitCardModel;
    _snackBar("Message", _commonModel.message);
    clearAllFields();
  }

  clearAllFields() {
    _cardHolderNameTEC.text = '';
    _cardNumberTEC.text = '';
    _monthTEC.text = '';
    _yearTEC.text = '';
    _cvvTEC.text = '';
  }

  _snackBar(var title, var message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black45,
      colorText: Colors.white,
    );
  }
}
