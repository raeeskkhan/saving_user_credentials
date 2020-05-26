import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPageWidget extends StatefulWidget {
  @override
  _MainPageWidgetState createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  String _username = "";
  String _password = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = (prefs.getString('aUsername') ?? "Unknown");
      _password = (prefs.getString('aPassword') ?? "Unknown");
    });
  }

  _saveUserPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('aPassword', _password);
    });
  }

  _saveUserUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('aUsername', _username);
    });
  }

  _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      print("Username: ${prefs.getString('aUsername')}");
      print("Password: ${prefs.getString('aPassword')}");
    });
  }

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  clearTextInput() {
    _usernameController.clear();
    _passwordController.clear();
  }

  _loadUserDataInTextField() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernameController.text = "${prefs.getString('aUsername')}";
      _passwordController.text = "${prefs.getString('aPassword')}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: TextFormField(
              controller: _usernameController,
              onChanged: (textEntered) {
                setState(() {
                  _username = textEntered;
                  _saveUserUsername();
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter you Username',
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            child: TextFormField(
              controller: _passwordController,
              onChanged: (textEntered) {
                setState(() {
                  _password = textEntered;
                  _saveUserPassword();
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter your Password',
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Center(
            child: RaisedButton(
              child: Text("Get User Data"),
              onPressed: () {
                setState(() {
                  _getUserData();
                });
              },
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Center(
            child: RaisedButton(
              child: Text("Load User Data"),
              onPressed: () {
                setState(() {
                  _loadUserDataInTextField();
                });
              },
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Center(
            child: RaisedButton(
              child: Text("Clear Text"),
              onPressed: () {
                setState(() {
                  clearTextInput();
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
