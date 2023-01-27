import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sig_mobile_project/map.livreur.dart';
import 'package:sig_mobile_project/services/manage.misson.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class MissionDetails extends StatelessWidget {
  late WebViewPlusController controller;

  MissionDetails(
      {Key? key, this.name, this.description, this.quantite, this.coord})
      : super(key: key);
  final String? name;
  final String? description;
  final String? quantite;
  final String? coord;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Details Missions"),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("images/profile.jpeg"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Nom: " + name!,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Description: " + description!,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Quantite: " + quantite!,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Coordonnées: ",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "long: " + coord!.split(',')[0],
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "lat: " + coord!.split(',')[1],
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: FloatingActionButton.extended(
                      label: const Text('voir sur map'), // <-- Text
                      backgroundColor: Theme.of(context).primaryColor,
                      icon: const Icon(
                        Icons.add_location_alt_outlined,
                        size: 24.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LivrMap(coord: coord!),
                            ));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: FloatingActionButton.extended(
                      label: const Text('Done'), // <-- Text
                      backgroundColor: Theme.of(context).primaryColor,
                      icon: const Icon(
                        Icons.done,
                        size: 24.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LivrMap(coord: coord!),
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
