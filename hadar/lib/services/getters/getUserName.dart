import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hadar/Design/basicTools.dart';
import 'package:hadar/utils/HelpRequest.dart';


/*
  documentId - is the id of the wanted user
  collectionReference - is the collection the user in
 */
class GetUserName extends StatelessWidget {
  final String documentId;
  final CollectionReference collectionReference;

  GetUserName(this.documentId , this.collectionReference);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = collectionReference;

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data;
          if(snapshot.data != null) {
            data = snapshot.data!.data() as Map<String,dynamic>?;
          }
          if(data == null){return Text('shouldnt be here , u might inserted request with wrong id');}
          return Text("${data['name']}"
                    , style: TextStyle(
              color: BasicColor.clr,
              fontWeight: FontWeight.bold,
            ),
          );
        }

        return Text("loading..");
      },
    );
  }
}

class GetUserInNeedInfo extends StatelessWidget {
  final String documentId;
  final HelpRequest helpRequest;
  final CollectionReference collectionReference;

  GetUserInNeedInfo(this.documentId , this.collectionReference,this.helpRequest);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = collectionReference;

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data;
          if(snapshot.data != null) {
            data = snapshot.data!.data() as Map<String,dynamic>?;
          }
          if(data == null){return Text('invalid id');}
          //"בן/בת " + userInNeed.Age.toString() + ", " + userInNeed.Location;
          return Text("בן/בת " + "${data['Age']}" + ", " + helpRequest.location
            , style: TextStyle(
              color: BasicColor.clr,
              fontWeight: FontWeight.bold,
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}

class GetHelpRequestTileUserInfo extends StatelessWidget {
  final String documentId;
  final HelpRequest? helpRequest;
  final CollectionReference collectionReference;

  GetHelpRequestTileUserInfo(this.documentId , this.collectionReference,this.helpRequest);

  @override
  Widget build(BuildContext context) {

    CollectionReference users = collectionReference;

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data;
          if(snapshot.data != null) {
            data = snapshot.data!.data() as Map<String,dynamic>?;
          }
          if(data == null){return Text('invalid id');}
          double fontSize = 15.0;
          return Column(
            children: [
              Text("${data['name']}"
                , style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w300
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Text("${data['phoneNumber']}"
                , style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w300
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Text("${data['email']}"
                , style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w300
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Text("${data['id']}"
                , style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w300
                ),
              ),
              SizedBox(
                height: 7,
              ),
              //TODO
              Text(helpRequest == null ? "${data['location']}" : helpRequest!.location
                , style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w300
                ),
              ),
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}

