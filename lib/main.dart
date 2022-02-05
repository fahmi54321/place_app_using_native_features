import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/great_places_provider.dart';
import './screens/place_list_screen.dart';
import './screens/add_place_screen.dart';
import './screens/place_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlacesProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlaceListScreen(),
        routes: {
          AddPlaceScreen.routeName : (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName : (ctx) => PlaceDetailScreen(), //todo 4 (next map_screen)
        },
      ),
    );
  }
}
