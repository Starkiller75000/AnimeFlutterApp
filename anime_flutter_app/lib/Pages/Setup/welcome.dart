import 'package:anime_flutter_app/Pages/Setup/sign_in.dart';
import 'package:anime_flutter_app/Pages/Setup/sign_up.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Anime App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            onPressed: NavigateToSignIn,
            child: Text('Sign in'),
          ),
          RaisedButton(
            onPressed: NavigateToSignUp,
            child: Text('Sign up'),
          )
        ],
      ),
    );
  }

  void NavigateToSignIn() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog: true));
  }

  void NavigateToSignUp() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(), fullscreenDialog: true));
  }

}
