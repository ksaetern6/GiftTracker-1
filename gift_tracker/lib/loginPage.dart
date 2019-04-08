import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType {
  login,
  register
}
class _LoginPageState extends State<LoginPage> {

  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.login;

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
              children: buildInputs() + buildButtons(),
            ),
          ),
        ),
    );
  }//build

  List<Widget> buildInputs() {
     return [
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
     ];
  }

  List<Widget> buildButtons() {
     if (_formType == FormType.login) {
       return [
         RaisedButton(
           child: Text('Login', style: TextStyle(fontSize: 20.0)),
           onPressed: submit,
         ),
         FlatButton(
           child: Text('Create Account', style: TextStyle(fontSize: 20.0),),
           onPressed: register,

         )
       ];
     } //if login
     else {
       return [
         RaisedButton(
           child: Text('Create Account', style: TextStyle(fontSize: 20.0)),
           onPressed: submit,
         ),
         FlatButton(
           child: Text('Have Account? Login', style: TextStyle(fontSize: 20.0),),
           onPressed: login,

         )
       ];
     } //else register
  }
  //originally void
  bool validate() {
    //formKey allows us to call validator on TextFormFields
    final form = formKey.currentState;
    if (form.validate()) {
      //form.save() calls on onSaved parameters in the form
      form.save();
      //print('Form is valid. Email: $_email, password: $_password');
      return true;
    }
    else {
      //print('Form is invalid');
      return false;
    }
  }//validate

  void submit() async {
     if (validate()) {
       //trim excess in email
       _email = _email.toString().trim();
       try {
         if (_formType == FormType.login) {
           FirebaseUser user = await FirebaseAuth.instance
               .signInWithEmailAndPassword(
             email: _email,
             password: _password,
           );
           print('Signed In: ${user.uid}');
         } //if login
         else {
           FirebaseUser user = await FirebaseAuth.instance.
           createUserWithEmailAndPassword(
               email: _email,
               password: _password,
           );
           print('Registered user: ${user.uid}');
         }//else register
       }
       catch (error) {
         print('Error: $error');
       }
     }//if

  }//submit

  void login() {
    //empties form of data/text
    formKey.currentState.reset();
    setState(() {
       _formType = FormType.login;
     });
  }
  void register() {
    //empties form of data/text
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }
}

