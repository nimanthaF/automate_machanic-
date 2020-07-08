import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {

  final firestoreInstance = Firestore.instance;
   
  String _userId;
  String _name;
  String _bio;
  

  GoogleMapController _controller;
  Position position;
  Widget _child;

  final databaseReference = Firestore.instance;

  QuerySnapshot querySnapshot;

 

  @override
  void initState(){
    _child=SpinKitFadingCircle(color: Colors.black,);
    getCurrentLocation();
    super.initState();
    _onPressed();
  }



  void getCurrentLocation()async{
    Position res=await Geolocator().getCurrentPosition();
    setState(() {
      position=res;
      _child=mapWidget();
    });
  var firebaseUser = await FirebaseAuth.instance.currentUser();
  databaseReference.collection("mechanics location").document(firebaseUser.uid).setData(
  {
    'location':GeoPoint(position.latitude,position.longitude),
  });
  
  }

  

  Set<Marker> _createMarker(){
    
    return <Marker>[
      Marker(
        markerId: MarkerId(_name),
        position:LatLng(position.latitude,position.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: _name, snippet: _bio),
        onTap: (){
          _onPressed();
        }
        
      )
    ].toSet();
  }
  


  @override
  Widget build(BuildContext context) {
  

    FirebaseAuth.instance.currentUser().then((user) {
      _userId = user.uid;
    });
 
    
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Location'),
        centerTitle: true,
      ),
      body: _child,
      

    );
  }

  Widget mapWidget(){
    return GoogleMap(
      mapType: MapType.normal,
      markers: _createMarker(),
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude,position.longitude),
        zoom:12.0,
      ),
      onMapCreated: (GoogleMapController controller){
        _controller=controller;
      },
      
    );
  }


 getMechanicData()async{
   return await Firestore.instance.collection("Mechanics").getDocuments();
 }

 void _onPressed() async{
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection("Mechanics").document(firebaseUser.uid).get().then((value){
      _name=value.data['name'];
      _bio=value.data['bio'];
    });
  }
}

