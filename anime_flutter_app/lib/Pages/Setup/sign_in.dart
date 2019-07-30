import 'package:anime_flutter_app/Pages/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please type an email';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'Email'
                ),
              ),
              TextFormField(
                validator: (input) {
                  if (input.length < 6) {
                    return 'Your password must be atleast 6 characters';
                  }
                },
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                    labelText: 'Password'
                ),
                obscureText: true,
              ),
              RaisedButton(
                onPressed: SignIn,
                child: Text('Sign In'),
              )
            ],
          ),
      ),
    );
  }

  Future<void> SignIn() async {
    final formState = _formKey.currentState;

    if (formState.validate()) {
      formState.save();
      try {
        AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: result.user)));
      } catch(e) {
        print(e.message);
      }
    }
  }
}