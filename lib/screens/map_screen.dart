import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';

class MapScreen extends StatefulWidget {

  final PlaceLocation initialLocation;
  final bool isReadyOnly;
  MapScreen({
    this.initialLocation = const PlaceLocation(
      latitude: 37.419857,
    longitude: -122.078827,
  ),
    this.isReadyOnly = false
  });



  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  LatLng _pickedPosition;

  void _selectedPosition(LatLng position){
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecione..."),
        actions: <Widget>[
          if(!widget.isReadyOnly)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedPosition == null? null :(){
                Navigator.of(context).pop(_pickedPosition);
              },
            )
        ],
      ),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude),
            zoom: 13
          ),
        onTap: widget.isReadyOnly ? null : _selectedPosition,
        markers:(_pickedPosition ==null && !widget.isReadyOnly) ? null
            :{
            Marker(
              markerId: MarkerId('p1'),
              position: _pickedPosition ?? widget.initialLocation.toLatLng()
            )
        },
      ),
    );
  }
}
