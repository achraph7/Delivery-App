import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:sig_mobile_project/map.admin.dart';
// import 'package:sig_mobile_project/map.admin.dart';
import 'package:sig_mobile_project/services/manage.misson.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class AddMisson extends StatefulWidget {
  const AddMisson({super.key});

  @override
  State<AddMisson> createState() => _AddMissonState();
}

class _AddMissonState extends State<AddMisson> {
  // AdmiMapState admiMapState = AdmiMapState();
  // AdmiMap(message: message.message);
  final _missoin_desc = TextEditingController();
  final _missoin_quant = TextEditingController();
  final _missoin_Livreur_name = TextEditingController();
  final _mission_coord = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "              Nouvelle Mission",
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.04),
              Text("Ajouter Une mission",
                  style: TextStyle(
                      fontSize: 30, color: Theme.of(context).primaryColor)),
              Text("Ici",
                  style: TextStyle(
                      fontSize: 30, color: Theme.of(context).primaryColor)),
              SizedBox(
                height: height * 0.05,
              ),
              TextFormField(
                controller: _missoin_desc,
                decoration: const InputDecoration(
                    labelText: "Entrer une description de la mission"),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                    return "Entrer des données correct";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: height * 0.05,
              ),
              TextFormField(
                controller: _missoin_quant,
                decoration: const InputDecoration(
                    labelText: "Entre la quantité à livrer"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty || !RegExp(r'^[0-9]').hasMatch(value)) {
                    return "Entrer des données correct";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: height * 0.05,
              ),
              TextFormField(
                controller: _missoin_Livreur_name,
                decoration: const InputDecoration(
                    labelText: "Entrer Le nom de livreur"),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                    return "Localsation";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: height * 0.05,
              ),
              TextFormField(
                controller: _mission_coord,
                decoration:
                    InputDecoration(labelText: "Ajoute La destination: "),
                enabled: false,
                // initialValue: AdmiMapState.finalCoord
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton.extended(
                  label: const Text('Aller au map'), // <-- Text
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: const Icon(
                    Icons.add_location_alt_outlined,
                    size: 24.0,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/map");
                  },
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: FloatingActionButton.extended(
                    label: const Text('Save'), // <-- Text
                    backgroundColor: Color.fromARGB(255, 0, 75, 110),
                    icon: const Icon(
                      Icons.save,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      print("Final: ");
                      print(AdmiMapState.finalCoord.runtimeType);
                      if (formKey.currentState!.validate()) {
                        // print(_missoin_quant.text);
                        var response = await FirebaseServices.addMission(
                            desc: _missoin_desc.text,
                            quant: _missoin_quant.text,
                            nameLivreur: _missoin_Livreur_name.text,
                            lnglat: AdmiMapState.finalCoord);
                        if (response.code != 200) {
                          print("doooooooooooooone");
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(response.message.toString()),
                                );
                              });
                        } else {
                          print("Not doooooooooooooone");

                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(response.message.toString()),
                                );
                              });
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
