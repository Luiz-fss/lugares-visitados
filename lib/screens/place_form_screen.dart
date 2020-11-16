import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {

  final _titleControlle = TextEditingController();
  File _pickedImage;
  LatLng _pickedPosition;

  void _selectPosition(LatLng position){
    setState(() {
      _pickedPosition = position;
    });
  }

  void _selectImage(File pickedImage){
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  bool _isValidForm(){
    return _titleControlle.text.isNotEmpty || _pickedImage==null || _pickedPosition==null;
  }

  void _submitForm(){
    if(_isValidForm()){
      return ;
    }
    Provider.of<GreatPlace>(context, listen: false).addPlace(_titleControlle.text, _pickedImage,_pickedPosition);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Lugar"),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
         //Expanded vai expandir a tela ao maximo, fazendo com que o Raised
         //fique encostado na parte inferior
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleControlle,
                      decoration: InputDecoration(
                        labelText: "Título"
                      ),
                    ),
                    SizedBox(height: 10,),
                    ImageInput(this._selectImage),
                    SizedBox(height: 10,),
                    LocationInput(_selectPosition)
                  ],
                ),
              ),
            ),
          ),
          
          RaisedButton.icon(
              onPressed: _isValidForm() ?_submitForm : null,
              icon: Icon(Icons.add),
              label: Text("Adicionar"),
            color: Theme.of(context).accentColor,

            elevation: 0,
            /*shirink = vai "encolher"
            * com isso vai remover a sobra do espaçamento que estava
            * Manterá o botão encostado na parte inferiror*/
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          )
        ],
      ),
    );
  }
}
