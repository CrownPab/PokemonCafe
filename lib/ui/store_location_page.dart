import 'package:flutter/material.dart';
import 'package:pokemon_cafe/ui/checkout_page.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:pokemon_cafe/locations.dart' as locations;
import 'dart:math' show cos, sqrt, asin;

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
    Location("5954 Hwy 7", "Emerald City", LatLng(43.8739833, -79.337021),
        "assets/images/Emerald_City.jpg"),
    Location(
        "600 Highway 7",
        "Saffron City",
        LatLng(43.845703125, -79.38105010986328),
        "assets/images/Saffron_City.jpg"),
    Location("3740 Midland Ave", "Lavender Town", LatLng(43.816033, -79.293668),
        "assets/images/Lavender_Town.jpg"),
    Location(
        "209 Victoria St",
        "Vermilion City",
        LatLng(43.654884338378906, -79.37899780273438),
        "assets/images/Vermilion_City.jpg"),
    Location("1365 Wilson Rd N", "Pewter City", LatLng(43.939078, -78.8598354),
        "assets/images/Pewter_City.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select a store")),
      body: ScaffoldBodyContent(latLonList),
    );
  }
}

class Location {
  String? address;
  String? city;
  LatLng? latLong;
  String? imagePath;

  Location(this.address, this.city, this.latLong, this.imagePath);
}

class ScaffoldBodyContent extends StatefulWidget {
  List<Location> latLonList;

  ScaffoldBodyContent(this.latLonList);

  @override
  _ScaffoldBodyContentState createState() => _ScaffoldBodyContentState();
}

class _ScaffoldBodyContentState extends State<ScaffoldBodyContent> {
  static const IconData catching_pokemon_sharp =
  IconData(0xe844, fontFamily: 'MaterialIcons');
  var center = LatLng(43.856098, -79.337021);
  late Location selectedStore;

  @override
  void initState() {
    super.initState();
    setCurrentLocation();
  }

  void setCurrentLocation() async {
    var position = await getCurrentLocation();
    if (mounted) {
      setState(() {
        center = LatLng(position.latitude, position.longitude);
      });
    }
  }

  Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

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
                setState(() {
                  setCurrentLocation();
                });
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  content: Container(
                      height: 75,
                      child: Row(children: [
                        Image.asset(list[i].imagePath!, width: 75, height: 75),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              list[i].city.toString(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(list[i].address.toString()),
                            Text(calculateDistance(
                                center.latitude,
                                center.longitude,
                                list[i].latLong!.latitude,
                                list[i].latLong!.longitude)
                                .toStringAsFixed(1) +
                                " km"),
                          ],
                        ),
                      ])),
                  duration: const Duration(days: 1),
                  backgroundColor: Colors.red,
                  action: SnackBarAction(
                    label: 'Confirm',
                    onPressed: () {
                      print('Action is clicked');
                      setState(() {
                        selectedStore = list[i];
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutPage(selectedStore: selectedStore)),
                      );
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
    markers.add(Marker(
        point: center,
        builder: (BuildContext context) {
          return IconButton(
            onPressed: () {
              print("PIN CLICKED!");
            },
            icon: const Icon(Icons.my_location),
            iconSize: 20.0,
            color: Colors.blueAccent,
          );
        }));
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

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(zoom: 10.0, minZoom: 1, maxZoom: 200, center: center),
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
          markers: markerList(widget.latLonList),
        ),
      ],
    );
  }
}
