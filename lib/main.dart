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
  dynamic _locale = Locale('en');
  Map<String, dynamic> _localization = {};
  @override
  void initState() {
    super.initState();
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final file = _locale.languageCode == 'en'
        ? "assets/l10n/en.json"
        : "assets/l10n/fa.json";
    final rawData = await rootBundle.loadString(file);
    _localization = jsonDecode(file);
  }

  Future<void> changeLanguage(String newLagnuage) async {
    final file = newLagnuage == 'en'
        ? "assets/l10n/en.json"
        : "assets/l10n/fa.json";
    final rawData = await rootBundle.loadString(file);
    setState(() {
      _localization = jsonDecode(rawData);
      _locale = Locale(newLagnuage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      supportedLocales: [Locale('en'), Locale('fa')],
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber.shade800,
          foregroundColor: Colors.white,
          title: Text(_localization['appbar_title']),
          actions: [
            MaterialButton(onPressed: () {}, child: Text('English')),
            MaterialButton(onPressed: () {}, child: Text('فارسی')),
          ],
        ),
        body: Center(child: Text(_localization['title'])),
      ),
    );
  }
}
