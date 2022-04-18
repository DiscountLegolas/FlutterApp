import 'package:example/Api/Models/Therapist.dart';

import 'package:example/main.dart';
import 'package:provider/provider.dart';
import 'package:example/Provider/Models/TherapistModel.dart';
import 'package:flutter/material.dart';

class TherapistsPage extends StatelessWidget {
  const TherapistsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Kekemelik Therapist App"),
        ),
        drawer: MyApp.BuildDrawer(context),
        body: TherapistsGrid());
  }
}

class TherapistsGrid extends StatelessWidget {
  TherapistsGrid({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var therapist = context.watch<TherapistsModel>();
    // TODO: implement build
    return Column(children: <Widget>[
      Container(
          height: 25,
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.red),
          )),
          child: TextField(
            decoration: new InputDecoration.collapsed(hintText: 'Enter Name-Surname of Therapist'),
            keyboardType: TextInputType.text,
            onSubmitted: (String str) {
              therapist.GetTherapistsByNameSurname(str);
            },
          )),
      Container(
          height: (MediaQuery.of(context).size.height / 4) * 3,
          child: FutureBuilder(
              future: therapist.therapists,
              builder: (BuildContext bcontext, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Text("${snapshot.data[index].Name}");
                      });
                }
              }))
    ]);
  }
}
