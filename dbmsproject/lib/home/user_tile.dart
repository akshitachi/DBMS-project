// ignore_for_file: prefer_const_constructors

import 'package:dbmsproject/profile/profilepage.dart';
import 'package:flutter/material.dart';

class UserTile extends StatefulWidget {
  var userData;
  UserTile({Key? key, this.userData}) : super(key: key);

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    var imageUrl = widget.userData['image_url'];
    var name = widget.userData['name'];
    var username = widget.userData['username'];
    var uid = widget.userData['uid'];
    return ListTile(
      leading: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(uid: uid),
            ),
          );
        },
        child: CircleAvatar(
          backgroundImage: imageUrl == null || imageUrl == ''
              ? null
              : NetworkImage(imageUrl),
          maxRadius: 18,
        ),
      ),
      title: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(uid: uid),
            ),
          );
        },
        child: Text(username),
      ),
      subtitle: InkWell(
        child: Text(name),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(uid: uid),
            ),
          );
        },
      ),
    );
  }
}
