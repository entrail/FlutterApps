import 'package:flutter/material.dart';

import './home.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (BuildContext context) => HomePage()));
          },
          child: Text('LOGIN'),
        ),
      ),
    );
  }
}
