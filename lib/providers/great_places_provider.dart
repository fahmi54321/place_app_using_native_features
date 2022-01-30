import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlacesProvider with ChangeNotifier {
  //set
  List<Place> _items = [];

  //get
  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: null,
      image: pickedImage,
    );

    _items.add(newPlace);
    notifyListeners();

    //todo 3
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  //todo 4 (next place_list_screen)
  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (e) => Place(
            id: e['id'],
            title: e['title'],
            location: null,
            image: File(
              e['image'],
            ),
          ),
        ).toList();
    notifyListeners();
  }
}
