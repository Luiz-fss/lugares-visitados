import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/utils/db_util.dart';
import 'package:great_places/utils/location_util.dart';

class GreatPlace with ChangeNotifier{
  List<Place> _items = [];

  //carregando locais já cadastrados
  Future<void> loadPlaces()async{
    final dataList = await DbUtil.getData("places");
    _items = dataList.map((item){
      return Place(
        id: item["id"],
        title: item["title"],
        image: File(item["image"]),
        location: PlaceLocation(
          latitude: item["lat"],
          longitude: item["long"],
          address: item["adress"]
        )
      );
    }).toList();
    notifyListeners();
  }

  List<Place> get items {
    //spread para retornar um clone
    return [...items];
  }

  int get itemsCount{
    return _items.length;
  }

  //pegando item pelo id
  Place itemByIndex(int index){
    return _items[index];
  }

  Future<void> addPlace(String title, File image, LatLng position)async{
    final String address = await LocationUtil.getAddressFrom(position);
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location: PlaceLocation(latitude: position.latitude,longitude: position.longitude)
    );
    _items.add(newPlace);
    DbUtil.insert("places", {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': position.latitude,
      'long':position.longitude,
      'address': address
    });
    notifyListeners();
  }

}