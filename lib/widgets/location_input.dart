import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

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
  }

  //kenapa makai future dan navigator.push karena saat kembali dari map screen
  // dia akan memabawa data yang diperlukan
  Future<void> _selectOnMap() async { //todo 7
    final selectedLocation = await Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (ctx) => MapScreen(
        isSelection: true,
      ),
    ),);

    if(selectedLocation == null){
      return;
    }
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
              onPressed: _selectOnMap, //todo 8 (finish)
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
