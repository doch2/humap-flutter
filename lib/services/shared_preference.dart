import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static final SharedPreference _instance = SharedPreference._privateConstructor();
  factory SharedPreference() {
    return _instance;
  }

  late SharedPreferences _prefInstance;
  SharedPreference._privateConstructor() {
    SharedPreferences.getInstance().then((prefs) {
      _prefInstance = prefs;
    });
  }
}