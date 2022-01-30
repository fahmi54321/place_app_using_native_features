import 'package:flutter/material.dart';

import '../models/place.dart';

//todo 2 (next main)
class GreatPlacesProvider with ChangeNotifier{

  //set
  List<Place> _items = [];

  //get
  List<Place> get items{
    return [..._items];
  }

}