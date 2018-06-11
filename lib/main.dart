import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

void main() => runApp(new Linkky());

class Linkky extends StatefulWidget {
  @override
  State<StatefulWidget> createState () {
    return new LinkkyState();
  }
}

class LinkkyState extends State<Linkky> {

  String _email = "";
  String _password = "";

  _fetchData() async {
    print("premiere ligne fetch data");
    final url = "http://192.168.1.15:3000/oauth/token";
    var body = {"grant_type": "password", "username": this._email, "password": this._password};

    final response = await http.post(
      url,
      body: json.encode(body),
      headers: {HttpHeaders.ACCEPT: 'application/vnd.api+json', HttpHeaders.CONTENT_TYPE: 'application/vnd.api+json'}
    );
    print(response.body);
    print("on a print response");
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: new Color.fromARGB(255, 215, 165, 66),
      ),
      home: new Scaffold(
        appBar: new AppBar(
          textTheme: new TextTheme(
            title: new TextStyle(color: Colors.white, fontSize: 25.0)
          ),
          title: new Text("Linkky")
        ),
        body: new Container(
          margin: new EdgeInsets.only(top: 100.0, left: 50.0, right: 50.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Text("Connexion",
                style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: new Color.fromARGB(255, 215, 165, 66))),
                new Container(
                  margin: new EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: new TextField(
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                      print(_email);
                    },
                    decoration: new InputDecoration(
                      hintText: "Email"
                    )
                  )
                ),
                new Container(
                  margin: new EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: new TextField(
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                      print(_password);
                    },
                    decoration: new InputDecoration(
                      hintText: "Mot de passe"
                    )
                  )
                ),
                new Container(
                  constraints: new BoxConstraints(maxWidth: 100.0),
                  child: new RaisedButton(
                    color: new Color.fromARGB(255, 215, 165, 66),
                    textColor: Colors.white,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      verticalDirection: VerticalDirection.down,
                      children: <Widget>[
                        new Text("VALIDER")
                      ],
                    ),
                    onPressed: () {
                      print("on lance fetchData");
                      _fetchData();
                    },
                  ),
                ) 
              ],
            )
          ) 
        )
      )
    );
  }
}