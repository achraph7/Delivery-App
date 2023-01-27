import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sig_mobile_project/add.mission.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class AdmiMap extends StatefulWidget {
  const AdmiMap({super.key});

  @override
  State<AdmiMap> createState() => AdmiMapState();
}

class AdmiMapState extends State<AdmiMap> {
  late WebViewPlusController controller;
  String SelectedType = 'Nothing';
  static String finalCoord = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(SelectedType), actions: <Widget>[
        Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                finalCoord = SelectedType;
                print(finalCoord);
              },
              child: const Icon(
                Icons.save,
                size: 26.0,
              ),
            )),
      ]),
      body: WebViewPlus(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: "assets/projet-leaflet/index.html",
        onWebViewCreated: (controller) {
          this.controller = controller;
        },
        javascriptChannels: {
          JavascriptChannel(
              name: "jsChannel1",
              onMessageReceived: ((message) async {
                print(message.message);
                setState(() {
                  SelectedType = message.message;
                });
              }))
        },
      ),
    );
  }
}
