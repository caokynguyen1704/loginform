//change something

//add more
//abcdef

//adddddd
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'goto.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

FormData _$FormDataFromJson(Map<String, dynamic> json) {
  return FormData(
    email: json['email'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$FormDataToJson(FormData instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

final themeColor = new Color(0xfff5a623);
final primaryColor = new Color(0xff203152);
final greyColor = new Color(0xffaeaeae);
final greyColor2 = new Color(0xffE8E8E8);

@JsonSerializable()
class FormData {
  String email;
  String password;

  FormData({
    this.email,
    this.password,
  });

  factory FormData.fromJson(Map<String, dynamic> json) =>
      _$FormDataFromJson(json);

  Map<String, dynamic> toJson() => _$FormDataToJson(this);
}

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);
  var httpClient = http.Client();
  @override
  _SignIn createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String error_mail = "";
  bool vailEmail = true;
  bool vailPass = true;
  int count_mail = 0;
  int count_pass = 0;
  bool viewMail = false;
  bool viewPass = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Sign in Form'),
      ),
      body: Scrollbar(
          child: Form(
              key: _formKey,
              child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        //validator: (value) {},

                        onChanged: (value) {
                          setState(() {
                            count_mail++;
                            isLoading = false;
                            vailEmail = true;
                          });
                        },
                        controller: email,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Your email address',
                          labelText: 'Email',
                          enabledBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: vailEmail ? Colors.blue : Colors.red)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: vailEmail ? Colors.blue : Colors.red)),
                        ),
                      ),
                      Container(
                        height: (vailEmail) ? null : 22,
                        child: (vailEmail)
                            ? null
                            : Text(error_mail,
                                style: TextStyle(
                                  color: Colors.red,
                                )),
                      ),
                      Container(
                        height: vailEmail ? 22 : null,
                        //color: Colors.blue,
                      ),
                      Container(
                        height: 10,
                        //color: Colors.blue,
                      ),
                      /*Container(
                          color: Colors.red,
                          height: hasVailEmail ? null : 20,
                          child: vailEmail ? null : null
                          /*Text(
                                "Sai định dạng Email!",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),*/
                          ),*/
                      TextFormField(
                        controller: password,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'Password',
                          enabledBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: vailPass ? Colors.blue : Colors.red)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: vailPass ? Colors.blue : Colors.red)),
                        ),
                        validator: (value) {},
                        onChanged: (value) {
                          count_pass++;
                          setState(() {
                            isLoading = false;
                            vailPass = true;
                          });
                        },
                      ),
                      Container(
                        height: vailPass ? null : 22,
                        child: vailPass
                            ? null
                            : Text("Password không được để trống!",
                                style: TextStyle(
                                  color: Colors.red,
                                )),
                      ),
                      Container(
                        height: vailPass ? 22 : null,
                        //color: Colors.blue,
                      ),
                      Container(
                        height: 10,
                        //color: Colors.blue,
                      ),
                      Center(
                        child: !isLoading
                            ? FlatButton(
                                child: Text('Sign in',
                                    style: TextStyle(color: Colors.black)),
                                onPressed: () async {
                                  FormData formData = FormData(
                                      email: email.text,
                                      password: password.text);

                                  vailEmail = true;

                                  vailPass = true;
                                  if (password.text.isEmpty) {
                                    setState(() {
                                      vailPass = false;
                                    });
                                  }
                                  error_mail = "";
                                  if (email.text.length == 0) {
                                    setState(() {
                                      vailEmail = false;
                                      error_mail = "Email không được để trống!";
                                    });
                                  }

                                  bool check = false;
                                  if (email.text.length >= 1) {
                                    for (int i = 0;
                                        i < email.text.length;
                                        i++) {
                                      if ((email.text[i] == "@") &&
                                          ((i + 6) < (email.text.length))) {
                                        check = true;
                                      }
                                    }
                                  }
                                  if (email.text.length >= 1) {
                                    if (check == false) {
                                      setState(() {
                                        vailEmail = false;
                                        error_mail = "Sai định dạng Email!";
                                      });
                                    }
                                  }
                                  print(error_mail);

                                  //if (_formKey.currentState.validate()) {
                                  setState(() {
                                    vailEmail = vailEmail;
                                    vailPass = vailPass;
                                  });
                                  if (count_mail == 0) {
                                    setState(() {
                                      vailEmail = false;
                                      error_mail = "Email không được để trống!";
                                    });
                                  }
                                  if (count_pass == 0) {
                                    setState(() {
                                      vailPass = false;
                                    });
                                  }

                                  if ((count_mail > 0) &&
                                      (count_pass > 0) &&
                                      (vailEmail == true) &&
                                      (vailPass == true)) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    var result = await widget.httpClient.post(
                                        'http://192.168.1.124:3000/users/login',
                                        body: json.encode(formData.toJson()),
                                        headers: {
                                          'content-type': 'application/json'
                                        });

                                    if (result.statusCode == 200) {
                                      print('Succesfully signed in.');
                                      if (result.body == "Sucess") {
                                        GoTo.gotoFormWidget(context);
                                      } else {
                                        Alert(
                                          context: context,
                                          type: AlertType.error,
                                          title: "Lỗi!",
                                          desc:
                                              "Thông tin tài khoản hoặc mật khẩu không hợp lệ!",
                                          buttons: [
                                            DialogButton(
                                              child: Text(
                                                "Ok",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              width: 120,
                                            )
                                          ],
                                        ).show();
                                      }
                                    } else if (result.statusCode == 401) {
                                      Alert(
                                              context: context,
                                              title: "ERROR",
                                              desc: "lỗi kết nối")
                                          .show();
                                      print('Unable to sign in.');
                                    } else {
                                      print(
                                          'Something went wrong. Please try again.');
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                              )
                            : Positioned(
                                child: isLoading
                                    ? Container(
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    themeColor),
                                          ),
                                        ),
                                        color: Colors.white.withOpacity(0.8),
                                      )
                                    : Container(),
                              ),
                      ),
                    ],
                  )))),
    );
  }
}
