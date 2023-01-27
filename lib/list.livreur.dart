import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sig_mobile_project/profile.livreur.dart';

class ListLivreur extends StatefulWidget {
  const ListLivreur({super.key});

  @override
  State<ListLivreur> createState() => _ListLivreurState();
}

class _ListLivreurState extends State<ListLivreur> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("List des livreurs"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection('users')
              .where("rool", isEqualTo: "Livreur")
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
                    String email = document['email'];
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
                              builder: (context) => ProfilePage(
                                name: document['name'],
                                email: document['email'],
                              ),
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
                          title: new Text(document['name']),
                          subtitle: new Text(document['email']),
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
