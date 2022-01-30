import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../providers/great_places_provider.dart';
import '../widgets/location_input.dart';


class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _addPlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      print('null');
      return;
    }

    Provider.of<GreatPlacesProvider>(
      context,
      listen: false,
    ).addPlace(_titleController.text, _pickedImage!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _titleController,
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    ImageInput(_selectImage),

                    SizedBox(
                      height: 10,
                    ),

                    LocationInput(), //todo 2
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add place'),
            onPressed: _addPlace,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }
}

//todo 3 tambahkan permisson location ios (finish)

/*
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>location permission</string>
    <key>NSLocationAlwaysUsageDescription</key>
    <string>location permission</string>
 */
