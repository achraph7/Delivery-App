import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:sig_mobile_project/widgets/drawer.item.widget.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  String getName() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var name = documentSnapshot.get('email').toString();
        var splitted = name.split("@");
        print(splitted[0]);
        return splitted[0];
      }
    });
    return "";
  }

  @override
  Widget build(BuildContext context) {
    String name = getName();
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white, Theme.of(context).primaryColor]),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("images/profile.jpeg"),
                  ),
                  Text(name), //ma3ert malha
                ],
              )),
          Expanded(
            child: ListView(
              children: [
                DrawerItemWidget(
                  title: "Home",
                  leadingIcon: Icons.home,
                  TrailingIcon: Icons.arrow_forward,
                  onAction: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/Livreur");
                  },
                ),
                DrawerItemWidget(
                  title: "Mission",
                  leadingIcon: Icons.person,
                  TrailingIcon: Icons.arrow_forward,
                  onAction: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/mission");
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
