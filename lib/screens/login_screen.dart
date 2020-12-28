import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'signup_screen.dart';
import 'home_screen.dart';
import '../models/authentication.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {'email': '', 'password': ''};

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occured'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    try {
      await Provider.of<Authentication>(context, listen: false)
          .logIn(_authData['email'], _authData['password']);
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } catch (error) {
      var errorMessage = 'Authentication Failed. Please try again later.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          actions: <Widget>[
            FlatButton(
              child: Row(
                children: <Widget>[Text('Signup'), Icon(Icons.person_add)],
              ),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(SignupScreen.routeName);
              },
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 80.0, 0.0, 0.0),
                    child: Text('Hello',
                        style: TextStyle(
                            fontSize: 70.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 145.0, 0.0, 0.0),
                    child: Text('There',
                        style: TextStyle(
                            fontSize: 70.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(220.0, 145.0, 0.0, 0.0),
                    child: Text('.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'EMAIL',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'invalid email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['email'] = value;
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'PASSWORD',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue))),
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty || value.length <= 5) {
                              return 'invalid password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['password'] = value;
                          },
                        ),
                       
                        SizedBox(height: 40.0),
                        Container(
                          height: 40.0,
                          child: RaisedButton(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                            onPressed: () {
                              _submit();
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: Colors.blue,
                            elevation: 7.0,
                            
                          ),
                        ),
   
                      ],
                    ))),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Create a New Profile?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
