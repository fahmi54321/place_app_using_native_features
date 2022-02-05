import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places_provider.dart';
import '../screens/map_screen.dart';

//todo 3 (next main)
class PlaceDetailScreen extends StatelessWidget {

  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
    final selectPlace = Provider.of<GreatPlacesProvider>(
      context,
      listen: false,
    ).findById(id.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(selectPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectPlace.location?.address ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    initialLocation: selectPlace.location!,
                    isSelection: false,
                  ),
                ),
              );
            },
            child: Text('View on Map'),
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
