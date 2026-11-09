import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newforflutter/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _locale = Locale('en');
  Map<String, dynamic> _localization = {};
  @override
  void initState() {
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final file = _locale == 'en'
        ? "assets/l10n/en.json"
        : "assets/l10n/fa.json";
    final rawData = rootBundle.loadString(file);
    _localization = jsonDecode(file);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}
