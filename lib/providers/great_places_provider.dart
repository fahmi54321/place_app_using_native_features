import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlacesProvider with ChangeNotifier {
  //set
  List<Place> _items = [];

  //get
  List<Place> get items {
    return [..._items];
  }

  Place findById(String id){ //todo 1 (next place_list_screen)
    return _items.firstWhere((element) => element.id == id);
  }

  Future <void> addPlace(String pickedTitle, File pickedImage, PlaceLocation pickedLocation) async{ //todo 9

    final address = await LocationHelper.getPlaceAddress(
      pickedLocation.latitude,
      pickedLocation.longitude,
    );

    final updateLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );

    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: updateLocation,
      image: pickedImage,
    );

    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat' : newPlace.location?.latitude,
      'loc_lng' : newPlace.location?.longitude,
      'address' : newPlace.location?.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (e) => Place(
            id: e['id'],
            title: e['title'],
            location: PlaceLocation(
                latitude: e['loc_lat'],
                longitude: e['loc_lng'],
                address: e['address']),
            image: File(
              e['image'],
            ),
          ),
        ).toList();
    notifyListeners();
  }
}
