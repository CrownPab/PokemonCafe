import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

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
  List<Location> latLonList = [];

  String address = '';
  String name = '';

  Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  getAddress(double latitude, double longitude) async {
    List<Placemark> places =
        await placemarkFromCoordinates(latitude, longitude);
    address =
        "${places.first.street}, ${places.first.locality}, ${places.first.postalCode}, ${places.first.country}";
    name = "${places.first.name}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Select a store")),
        body: ScaffoldBodyContent(latLonList),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var position = await getCurrentLocation();
            setState(() {
              latLonList.add(Location(address, name,
                  LatLng(position.latitude, position.longitude)));

              getAddress(position.latitude, position.longitude);

              print(position);
              print(address);
            });
          },
          child: Icon(Icons.add),
        ));
  }
}

class Location {
  String? address;
  String? name;
  LatLng? latLong;

  Location(this.address, this.name, this.latLong);
}

class ScaffoldBodyContent extends StatelessWidget {
  List<Location> latLonList;

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
              },
              icon: Icon(Icons.circle),
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

  final center = LatLng(43.899550, -79.239590);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(zoom: 16.0, minZoom: 1, maxZoom: 200, center: center),
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
        PolylineLayerOptions(polylines: [
          Polyline(
              color: Colors.blueAccent,
              strokeWidth: 3.0,
              points: pointsList(latLonList)),
        ]),
      ],
    );
  }
}
