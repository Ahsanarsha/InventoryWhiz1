import 'package:flutter/material.dart';

class VerifyEmail extends StatefulWidget {

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            decoration: new BoxDecoration(
              color: Color.fromRGBO(37, 49, 52, 1),
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0),
              ),
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      margin:
                          new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                      width: 120,
                      color: Colors.grey,
                      // margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                      height: 3.0,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        new Text(
                          'Forget password',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            "Enter your email for the verification process we will send link in your email",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        new Text(
                          'E-mail',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                            padding: const EdgeInsets.all(0.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    autofocus: true,
                                    keyboardType: TextInputType.emailAddress,
                                    //decoration: InputDecoration.collapsed(hintText: 'Enter your reference number'),
                                    onSaved: (String? value) {},
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (String? value) {},
                                    cursorColor: Colors.red,
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                      hintText: 'Write your email',
                                      border: InputBorder.none,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.clear,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              //alignment: Alignment.center,
                              width: double.infinity,
                              child: RaisedButton(
                                elevation: 20,
                                textColor: Colors.white,
                                color: Colors.red,
                                child: Text("Verification"),
                                onPressed: () {

                                  if (formKey.currentState!.validate()) {

                                  }
                                },
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
