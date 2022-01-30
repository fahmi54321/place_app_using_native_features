import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';

class GreatPlacesProvider with ChangeNotifier {
  //set
  List<Place> _items = [];

  //get
  List<Place> get items {
    return [..._items];
  }

  //todo 8 (next add_place_screen)
  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: null,
      image: pickedImage,
    );

    _items.add(newPlace);
    notifyListeners();
  }
}
