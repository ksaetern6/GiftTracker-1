import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) => value.isEmpty ? 'Email cannot be empty'
                  : null,
                  onSaved: (value) => _email = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) => value.isEmpty ? 'Password cannot be empty'
                  : null,
                  onSaved: (value) => _password = value,
                ),
                RaisedButton(
                  child: Text('Login', style: TextStyle(fontSize: 20.0)),
                  onPressed: validate,
                ),
              ],
            ),
          ),
        ),
    );
  }//build

  void validate() {
    //formKey allows us to call validator on TextFormFields
    final form = formKey.currentState;
    if (form.validate()) {
      //form.save() calls on onSaved parameters in the form
      form.save();
      print('Form is valid. Email: $_email, password: $_password');
    }
    else {
      print('Form is invalid');
    }
  }//validate
}

