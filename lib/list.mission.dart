// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class ListMission extends StatefulWidget {
//   const ListMission({super.key});

//   @override
//   State<ListMission> createState() => _ListMissionState();
// }

// class _ListMissionState extends State<ListMission> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sig_mobile_project/profile.livreur.dart';

import 'mission.details.dart';

class ListMission extends StatefulWidget {
  const ListMission({super.key});

  @override
  State<ListMission> createState() => _ListMissionState();
}

class _ListMissionState extends State<ListMission> {
  String _name = "";
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _getName() async {
    User? user = FirebaseAuth.instance.currentUser;
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    if (snapshot.exists) {
      setState(() {
        _name = snapshot.get('name');
      });
    } else {
      setState(() {
        _name = "";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("List des missions"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection('missionLivreur')
              .where("nameLivreur", isEqualTo: _name)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return new ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    // String email = document['email'];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black12,
                            width: 1,
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MissionDetails(
                                  name: document['nameLivreur'],
                                  description: document['description'],
                                  quantite: document['quantite'],
                                  coord: document['lnglat']),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("images/profile.jpeg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: new Text(document['description']),
                          subtitle: new Text(document['quantite']),
                        ),
                      ),
                    );
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }
}
