

import 'package:flutter/material.dart';
import 'package:mechanic_app/screens/home/settings_from.dart';
import 'package:mechanic_app/screens/home/userprofile.dart';
import 'package:mechanic_app/screens/services/auth.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth=AuthService();


  @override
  Widget build(BuildContext context) {

    void _showSettingdPanel(){
      showModalBottomSheet(context: context, builder: (context){
        
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Home sweet home"),
        actions: <Widget>[/*
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("log out"),
              onPressed: ()async{
                await _auth.signOut();
              }, 
          ), */
          FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: ()=> _showSettingdPanel(),
            )
        ],
      ),
      body:Card(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: UserProfile(),

            )
          ],
        ),
        color: Colors.lime[400],
      ),
      drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: Text('Menu'),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
      ListTile(
        title: Text('Log out'),
        leading: Icon(Icons.person),
        onTap: () async {
          await _auth.signOut();
        },
      ),
      
      
    ],
  ),
),
       
  );
  }
}