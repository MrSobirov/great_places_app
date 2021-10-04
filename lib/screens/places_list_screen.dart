import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My places'),
        actions: [
          IconButton(
              icon: Icon(Icons.add_location_alt),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              }
              )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlace(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting ?
        Center(child: CircularProgressIndicator(),) :
        Consumer<GreatPlaces>(
          child: Center(child: const Text('Got no places yet, start adding some!'),),
          builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0 ? ch :
          ListView.builder(
            itemBuilder: (ctx, i) => ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: FileImage(greatPlaces.items[i].image),),
              title: Text(greatPlaces.items[i].title),
              subtitle: Text(greatPlaces.items[i].location.address),
              onTap: () { 
                Navigator.of(context).pushNamed(
                    PlaceDetailScreen.routeName,
                    arguments: greatPlaces.items[i].id
                );
              },
            ),
            itemCount: greatPlaces.items.length,
          ),
        ),
      ),
    );
  }
}
