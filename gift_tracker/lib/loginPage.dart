import 'package:flutter/material.dart';
import 'auth.dart';
import 'HomePage.dart';

class LoginPage extends StatefulWidget {

  //when creating login page, creates instance of BaseAuth abstract class
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  //function that takes no parameters and returns no parameters
  final VoidCallback onSignedIn;

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
         maxLines: 1,
         decoration: InputDecoration(
             labelText: 'Email',
             icon: Icon(
               Icons.mail,
             ),
         ),
         keyboardType: TextInputType.emailAddress,
         validator: (value) => value.isEmpty ? 'Email cannot be empty'
             : null,
         onSaved: (value) => _email = value,
       ),
       TextFormField(
         decoration: InputDecoration(
             labelText: 'Password',
             icon: Icon(
               Icons.lock
             ),
         ),
         obscureText: true,
         validator: (value) => value.isEmpty ? 'Password cannot be empty'
             : null,
         onSaved: (value) => _password = value,
       ),
     ];
  }

  List<Widget> buildButtons() {
     return [
       Padding(
         padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
         child: SizedBox(
          height: 40.0,
          child: RaisedButton(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: _formType == FormType.login
            ? Colors.yellow
            : Colors.yellowAccent,
            child: _formType == FormType.login
                ? Text('Login', style: TextStyle(fontSize: 20.0))
                : Text('Create Account', style: TextStyle(fontSize: 20.0)),
            onPressed: submit,
          ),
        ),
       ),
         FlatButton(
           child: _formType == FormType.login
           ? Text('Create Account',
               style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300))
           : Text('Already have an account? Sign In',
               style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300)),
           onPressed: _formType == FormType.login
           ? register
           : login,

         )
     ];
   }

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
     //if forms aren't empty
     if (validate()) {
       //trim excess in email
       _email = _email.toString().trim();
       try {
         //use 'widget.' property to access BaseAuth auth
         if (_formType == FormType.login) {
           String userId = await widget.auth.signInEmailAndPass(
               _email,
               _password
           );
           print('Signed In: ${userId}');
         } //if login
         else {
           String userId = await widget.auth.registerEmailAndPass(
               _email,
               _password
           );
           print('Registered user: ${userId}');
         }//else register

         //Sign user into HomePage
         widget.onSignedIn();
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

