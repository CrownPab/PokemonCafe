import 'package:flutter/material.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:pokemon_cafe/locations.dart' as locations;

class StoreSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store Selection',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Location> latLonList = [
    Location("5954 Hwy 7", "Emerald City", LatLng(43.8739833, -79.337021)),
    Location("600 Highway 7", "Saffron City", LatLng(43.845703125, -79.38105010986328)),
    Location("3740 Midland Ave", "Lavender Town", LatLng(43.816033, -79.293668)),
    Location("209 Victoria St", "Vermilion City", LatLng(43.654884338378906, -79.37899780273438)),
    Location("1365 Wilson Rd N", "Pewter City", LatLng(43.939078,-78.8598354))
  ];

  Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select a store")),
      body: ScaffoldBodyContent(latLonList),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      */
    );
  }
}

class Location {
  String? address;
  String? city;
  LatLng? latLong;

  Location(this.address, this.city, this.latLong);
}

class ScaffoldBodyContent extends StatelessWidget {
  List<Location> latLonList;
  static const IconData catching_pokemon_sharp =
      IconData(0xe844, fontFamily: 'MaterialIcons');

  ScaffoldBodyContent(this.latLonList);

  List<Marker> markerList(List<Location> list) {
    List<Marker> markers = [];
    for (var i = 0; i < list.length; i++) {
      LatLng? lat = list[i].latLong;
      markers.add(Marker(
          point: lat!,
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                print("PIN CLICKED!");
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Container(
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(list[i].address.toString(), style: TextStyle(fontSize: 18),),
                          Text(list[i].city.toString()),
                        ],
                      )),
                  duration: const Duration(days: 1),
                  backgroundColor: Colors.red,
                  action: SnackBarAction(
                    label: 'Hide',
                    onPressed: () {
                      print('Action is clicked');
                    },
                    textColor: Colors.white,
                    disabledTextColor: Colors.grey,
                  ),
                ));
              },
              icon: const Icon(catching_pokemon_sharp,
                  size: 25.0, color: Colors.red),
              iconSize: 20.0,
              color: Colors.blueAccent,
            );
          }));
    }
    return markers;
  }

  List<LatLng> pointsList(List<Location> list) {
    List<LatLng> points = [];
    for (var i = 0; i < list.length; i++) {
      LatLng? lat = list[i].latLong;
      points.add(lat!);
    }
    return points;
  }

  final center = LatLng(43.856098, -79.337021);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(zoom: 12.0, minZoom: 1, maxZoom: 200, center: center),
      layers: [
        TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/archer546546544862/ckwif12vc23wq15rp8dv33lda/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXJjaGVyNTQ2NTQ2NTQ0ODYyIiwiYSI6ImNrd2k5YnhqczEwcXoyb3AyNXh5emFzOHEifQ.XR8xde1W5IZs5AGQXM_XVg",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoiYXJjaGVyNTQ2NTQ2NTQ0ODYyIiwiYSI6ImNrd2k5YnhqczEwcXoyb3AyNXh5emFzOHEifQ.XR8xde1W5IZs5AGQXM_XVg',
              'id': 'mapbox.mapbox-streets-v8'
            }),
        MarkerLayerOptions(
          markers: markerList(latLonList),
        ),
      ],
    );
  }
}
