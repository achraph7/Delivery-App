import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:sig_mobile_project/widgets/drawer.item.widget.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  String getName() {
    String? name;
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        name = documentSnapshot.get('name');
      } else {
        return "";
      }
    });
    return name!;
  }

  @override
  Widget build(BuildContext context) {
    // String name = getName().toString();
    // print(name);
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
                  Text(""), //ma3ert malha
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
                    // print(name);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/Administrateur");
                  },
                ),
                DrawerItemWidget(
                  title: "Liste des livreurs",
                  leadingIcon: Icons.person,
                  TrailingIcon: Icons.arrow_forward,
                  onAction: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/listeLivreurs");
                  },
                ),
                DrawerItemWidget(
                  title: "Affecter une mission",
                  leadingIcon: Icons.add_box,
                  TrailingIcon: Icons.arrow_forward,
                  onAction: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/Addmission");
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
