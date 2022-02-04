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

  Future <void> addPlace(String pickedTitle, File pickedImage, PlaceLocation pickedLocation) async{ //todo 9

    //todo 10
    final address = await LocationHelper.getPlaceAddress(
      pickedLocation.latitude,
      pickedLocation.longitude,
    );

    //todo 11
    final updateLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );

    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: updateLocation, //todo 12 (next db_helper)
      image: pickedImage,
    );

    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat' : newPlace.location?.latitude, //todo 14
      'loc_lng' : newPlace.location?.longitude, //todo 15
      'address' : newPlace.location?.address, //todo 16
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (e) => Place(
            id: e['id'],
            title: e['title'],
            location: PlaceLocation( //todo 17 (next place_list_screen)
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
