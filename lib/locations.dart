library my_prj.globals;
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Location {
  String? address;
  String? city;
  LatLng? latLong;

  Location(this.address, this.city, this.latLong);
}

List<Location> latLonList = [
  Location("5954 Hwy 7", "Markham", LatLng(43.8739833, -79.337021)),
  Location("600 Highway 7", "Richmond Hill", LatLng(43.845703125, -79.38105010986328)),
  Location("3740 Midland Ave", "Scarborough", LatLng(43.816033, -79.293668)),
  Location("209 Victoria St", "Toronto", LatLng(43.654884338378906, -79.37899780273438)),
  Location("1365 Wilson Rd N", "Oshawa", LatLng(43.939078,-78.8598354))
];