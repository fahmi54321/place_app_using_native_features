import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelection;

  MapScreen({
    this.initialLocation = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
    ),
    this.isSelection = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation; //todo 1

  void _selectLocation(LatLng position) {
    //todo 2
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: [
          if (widget.isSelection == true) //todo 5
            IconButton(
              onPressed: _pickedLocation == null ? null : () {
                Navigator.of(context).pop(_pickedLocation); //todo 6 (next location_input)
              },
              icon: Icon(
                Icons.check,
              ),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelection == true ? _selectLocation : null, //todo 3
        markers: _pickedLocation == null
            ? {}
            : {
                Marker(
                  //todo 4
                  markerId: MarkerId('m1'),
                  position: _pickedLocation!,
                ),
              },
      ),
    );
  }
}
