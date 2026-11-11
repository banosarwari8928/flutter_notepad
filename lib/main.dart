import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
  Future<void> changeLanguage()async{}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: [Locale('en'), Locale('fa')],
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Directionality(
          textDirection: _locale.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: child!,
        );
      },
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber.shade800,
          foregroundColor: Colors.white,
          title: Text(_localization['appbar_title']),
          actions: [
            MaterialButton(
              onPressed: () async {
                final file = "assets/l10n/en.json";
                final rawData = await rootBundle.loadString(file);
                setState(() {
                  _localization = jsonDecode(rawData);
                  _locale = Locale('en');
                });
              },
              child: Text('English'),
            ),
            MaterialButton(
              onPressed: () async {
                final file = "assets/l10n/fa.json";
                final rawData = await rootBundle.loadString(file);
                setState(() {
                  _localization = jsonDecode(rawData);
                  _locale = Locale('fa');
                });
              },
              child: Text('فارسی'),
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(child: Text(_localization["appbar_title"])),
              ListTile(
                leading: Icon(Icons.home),
                title: Text(_localization['home']),
              ),
              ListTile(
                leading: Icon(Icons.note_alt_outlined),
                title: Text(_localization['add_note']),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(_localization['settings']),
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text(
                  _locale.languageCode == 'en' ? "فارسی " : "English",)
                  onTap: (){

                  },
              ),
            ],
          ),
        ),
        body: Center(child: Text(_localization['title'])),
      ),
    );
  }
}
