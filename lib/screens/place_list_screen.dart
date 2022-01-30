import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';
import '../providers/great_places_provider.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: FutureBuilder( //todo 5
        future: Provider.of<GreatPlacesProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState == //todo 6 (finish)
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlacesProvider>(
                child: const Text('Got no places yet, start adding some'),
                builder: (ctx, greatPlace, ch) => greatPlace.items.length <= 0
                    ? ch!
                    : ListView.builder(
                        itemCount: greatPlace.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                              greatPlace.items[i].image,
                            ),
                          ),
                          title: Text(
                            greatPlace.items[i].title,
                          ),
                          onTap: () {},
                        ),
                      ),
              ),
      ),
    );
  }
}
