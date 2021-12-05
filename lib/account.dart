import 'package:flutter/material.dart';
import 'auth.dart';

class Account {
  static const ProgressTypes = ['Task', 'Deadline', 'Time'];
  static const SortingTypes = ['Date Created', 'Deadline', 'Duration'];
  String id;
  bool swapActivationSide;
  String profileImageURL;
  String name;
  String email;
  bool darkTheme;
  late Image profileImage;
  String progressType, sortingType;
  List<String> joinedProjects = [];
  Account(
      {required this.id,
      required this.profileImageURL,
      required this.name,
      required this.email,
      required this.swapActivationSide,
      required this.joinedProjects,
      required this.sortingType,
      required this.progressType,
      required this.darkTheme});

  Map<String, dynamic> mapTo({required Auth auth}) {
    var dataMap = new Map<String, dynamic>();
    dataMap['name'] = this.name;
    //dataMap['profileImageURL'] = this.profileImageURL;
    dataMap['email'] = (auth != null) ? auth.email : this.email;
    dataMap['joinedProjects'] = this.joinedProjects;
    dataMap['progressType'] = this.progressType;
    dataMap['darkTheme'] = this.darkTheme;
    dataMap['sortingType'] = this.sortingType;
    dataMap['swapActivationSide'] = this.swapActivationSide;
    return dataMap;
  }

  factory Account.NewAccount(String id, String email) {
    return Account(
      id: id,
      profileImageURL: '',
      email: email,
      darkTheme: false,
      progressType: 'Time',
      sortingType: SortingTypes[0],
      joinedProjects: [],
      name: 'Untitled',
      swapActivationSide: false,
    );
  }
  factory Account.fromMap(String id, Map<String, dynamic> map) {
    return Account(
        id: id,
        profileImageURL: map['profileImageURL'],
        name: map['UserName'],
        email: map['Email'],
        darkTheme: (map.containsKey('darkTheme')) ? map['darkTheme'] : false,
        joinedProjects: (map.containsKey('joinedProjects'))
            ? map['joinedProjects'].cast<String>()
            : [],
        progressType:
            (map.containsKey('progressType')) ? map['progressType'] : 'Task',
        sortingType: (map.containsKey('sortingType'))
            ? map['sortingType']
            : SortingTypes[0],
        swapActivationSide: (map.containsKey('swapActivationSide'))
            ? map['swapActivationSide']
            : false);
  }
}
