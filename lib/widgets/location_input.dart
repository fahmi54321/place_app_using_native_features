import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {

  final Function onSelectPlace; //todo 3
  LocationInput(this.onSelectPlace); //todo 4

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationHelper().generatelocationPreviewImage(
      latitude: locData.latitude ?? 0.0,
      longitude: locData.longitude ?? 0.0,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });

    widget.onSelectPlace(locData.latitude,locData.longitude); //todo 5

  }

  //kenapa makai future dan navigator.push karena saat kembali dari map screen
  // dia akan memabawa data yang diperlukan
  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (ctx) => MapScreen(
        isSelection: true,
      ),
    ),);

    if(selectedLocation == null){
      return;
    }

    widget.onSelectPlace(selectedLocation.latitude,selectedLocation.longitude); //todo 6 (next add_place_screen)
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 170,
          alignment: Alignment.center,
          child: _previewImageUrl == null
              ? Text(
                  'No Location choosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          children: [
            FlatButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on map'),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
