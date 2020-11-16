import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {

  final Function onSelectPosition;
  LocationInput(this.onSelectPosition);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {

  void _showPreview(double latitude, double longitude){
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
        latitude: latitude,
        longitude: longitude
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  String _previewImageUrl;
  Future<void> _getCurrentUserLocation()async{
    try{
      final locData = await Location().getLocation();

      _showPreview(locData.latitude, locData.longitude);

      widget.onSelectPosition(LatLng(
          locData.latitude,
          locData.longitude
      ));
    }catch(e){
      return;
    }
  }

  Future<void> _selectOnMap()async{
   final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context)=>MapScreen())
    );

   if(selectedLocation==null){
     return ;
   }

   //...
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPosition(selectedLocation);

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.grey)
          ),
          child: _previewImageUrl == null ? Text("Nenhuma localização informada")
              : Image.network(_previewImageUrl,fit: BoxFit.cover,width: double.infinity,)
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
                onPressed: _getCurrentUserLocation,
                icon: Icon(Icons.location_on),
                label: Text("Localização atual"),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text("Selecione no mapa"),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
