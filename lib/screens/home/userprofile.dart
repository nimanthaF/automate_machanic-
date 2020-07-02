
import 'package:flutter/material.dart';
import 'package:mechanic_app/models/user.dart';
import 'package:mechanic_app/screens/services/database.dart';
import 'package:provider/provider.dart';


class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  final _formKey = GlobalKey<FormState>();

  //from values
  

  @override
  Widget build(BuildContext context) {

    final user= Provider.of<User>(context);

    return StreamBuilder<Object>(
        stream: DatabaseServices(uid: user.uid).mechanicDataModel,
        builder: (context, snapshot) {
          MechanicData mechanicData=snapshot.data;
        return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0,),
              //name
              Text(
                "Name ",
                style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w900,
                fontFamily: 'Open Sans',
                fontSize: 30
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                mechanicData.name,
                style: TextStyle(
                  color: Colors.grey[800],
                fontWeight: FontWeight.w900,
                fontFamily: 'Open Sans',
                fontSize: 30,
                ),
                textAlign: TextAlign.center,
                ),

                SizedBox(height: 20.0,),
                //vehicle type
                Text(
               "bio",
                style: TextStyle(
                  color: Colors.grey[800],
                fontWeight: FontWeight.w900,
                fontFamily: 'Open Sans',
                fontSize: 30,
                ),
                textAlign: TextAlign.center,
                ),
                Text(
                mechanicData.bio,
                style: TextStyle(
                  color: Colors.grey[800],
                fontWeight: FontWeight.w900,
                fontFamily: 'Open Sans',
                fontSize: 30,
                ),
                textAlign: TextAlign.center,
                ),

                SizedBox(height: 20.0,),
                //age
                Text(
                "telephone",
                style: TextStyle(
                  color: Colors.grey[800],
                fontWeight: FontWeight.w900,
                fontFamily: 'Open Sans',
                fontSize: 30,
                ),
                textAlign: TextAlign.center,
                ),Text(
                mechanicData.telephone,
                style: TextStyle(
                  color: Colors.grey[800],
                fontWeight: FontWeight.w900,
                fontFamily: 'Open Sans',
                fontSize: 30,
                ),
                textAlign: TextAlign.center,
                ),
                ListTile(
                  title: Text("Address"),
                  subtitle: Text(mechanicData.address),
                ),
                ListTile(
                  title: Text('Rating'),
                  subtitle: Text(mechanicData.rating),
                )
           
            ],
          ),
        );
      }
    );
  }
}