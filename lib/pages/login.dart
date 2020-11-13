import 'package:boysbrigade/pages/home.dart';
import 'package:boysbrigade/provider/auth_prodiver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

final _firestore = FirebaseFirestore.instance;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String userId;
    // getCurrentUser() async {
    //   _firestore
    //       .collection('js')
    //       .where("userId", isEqualTo: "js@bb78.com")
    //       .snapshots();

    //   User user = await FirebaseAuth.instance.currentUser;
    //   setState(() {
    //     userId = user.uid;
    //   });
    //   print("js handled");
    // }

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 50, 40, 0),
          child: Form(
            key: _loginFormKey,
            child: ListView(
              children: <Widget>[
                Image.asset(
                  'assets/logo.png',
                  height: 200,
                ),
                SizedBox(
                  height: 30,
                ),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '請輸入電郵地址',
                      hintStyle:
                          TextStyle(fontSize: 16, color: Colors.grey[700]),
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                    ),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '請輸入電郵地址';
                      } else if (!EmailValidator.validate(value)) {
                        return '請輸入正確電郵地址';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '請輸入密碼',
                      hintStyle:
                          TextStyle(fontSize: 16, color: Colors.grey[700]),
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                    ),
                    controller: _passwordController,
                    obscureText: true,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return '請輸入密碼';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  child: Text(
                    '登錄',
                    style: TextStyle(fontSize: 16),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: Colors.blueGrey[900],
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20.0),
                  onPressed: () async {
                    if (_loginFormKey.currentState.validate()) {
                      try {
                        AuthProvider()
                            .login(
                                _emailController.text, _passwordController.text)
                            .then((_) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        });
                      } catch (e) {
                        print('Error Happened!!!: $e');
                      }
                    }
                    //getCurrentUser();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
