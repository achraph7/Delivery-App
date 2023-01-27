import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sig_mobile_project/list.livreur.dart';
// import 'package:sig_mobile_project/home.dart';
import 'package:sig_mobile_project/login.dart';
import 'package:sig_mobile_project/map.admin.dart';
import 'package:sig_mobile_project/Livreur.dart';
import 'package:sig_mobile_project/Administrateur.dart';
import 'package:sig_mobile_project/map.livreur.dart';

import 'add.mission.dart';
import 'list.mission.dart';
import 'register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.teal,
        ),
        // home: Register(),
        routes: {
          // '/': (BuildContext context) => ListLivreur(),

          '/': (BuildContext context) => LoginPage(),
          '/Livreur': (BuildContext context) => Livreur(),
          '/Administrateur': (BuildContext context) => Administrateur(),
          '/Addmission': (BuildContext context) => AddMisson(),
          '/map': (BuildContext context) => AdmiMap(),
          '/listeLivreurs': (BuildContext context) => ListLivreur(),
          '/mission': (BuildContext context) => ListMission(),
          // '/mapLivreur': (BuildContext context) => LivrMap(),

          // '/Map': (BuildContext context) => Map(),

          // '/listUser':(BuildContext context)=>ListStudent(),
        });
  }
}
