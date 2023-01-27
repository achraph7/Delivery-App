import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sig_mobile_project/add.mission.dart';
import 'package:sig_mobile_project/mission.details.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:geolocator/geolocator.dart';

class LivrMap extends StatefulWidget {
  const LivrMap({super.key, required this.coord});
  final String coord;

  @override
  State<LivrMap> createState() => LivrMapState();
}

class LivrMapState extends State<LivrMap> {
  WebViewPlusController? _controller;
  String SelectedType = 'Map pour mission';
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
                // print(finalCoord);
              },
              child: const Icon(
                Icons.save,
                size: 26.0,
              ),
            )),
      ]),
      body: WebViewPlus(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        onPageFinished: (String url) async {
          Position position = await Geolocator.getCurrentPosition();
          _controller?.webViewController.runJavascript(
              "logCoord('${widget.coord}', '${position.latitude}', '${position.longitude}');");
        },
        initialUrl: "assets/map-livreur/index.html",
      ),
    );
  }
}
