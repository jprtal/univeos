import 'package:flutter/material.dart';

class UserBanner extends StatelessWidget {

  final String firstName;
  final String lastName;
  final String url;

  UserBanner({this.firstName, this.lastName, this.url});

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        CircleAvatar(backgroundImage: NetworkImage(url), radius: 25.0,),
        SizedBox(width: 15.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(firstName, style: TextStyle(color: Colors.white, fontFamily: "Open Sans", fontWeight: FontWeight.bold)),
            Text(lastName, style: TextStyle(color: Colors.white, fontFamily: "Open Sans", fontWeight: FontWeight.bold))
          ],
        )
      ],
    );
  }
  
}