import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wecode_2021/src/services/auth_service.dart';
import 'package:wecode_2021/src/services/firestore_service.dart';

import 'add_new_job_screen.dart';

class FavouriteJobScreen extends StatefulWidget {
  const FavouriteJobScreen({Key? key}) : super(key: key);

  @override
  _FavouriteJobScreenState createState() => _FavouriteJobScreenState();
}

class _FavouriteJobScreenState extends State<FavouriteJobScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favs"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
         actions: <Widget>[
         Padding(
           padding: const EdgeInsets.all(10.0),
           child: IconButton(onPressed: () {
             Get.isDarkMode 
             ? Get.changeTheme(ThemeData.light()) : Get.changeTheme(ThemeData.dark());
           }, icon: Icon(Get.isDarkMode? Icons.mode_night: Icons.brightness_7), color: Colors.white,),
         ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: Icon(FontAwesomeIcons.plus),
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NewJobScreen()),
              )),
      body: Container(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(Provider.of<AuthService>(context, listen: false)
                  .generalUser!
                  .uid)
              .collection('favs')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return LinearProgressIndicator();
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Text(snapshot.data!.docs[index].data()["jobTitle"]);
              },
            );
          },
        ),
      ),
    );
  }
}
