import 'package:flutter/material.dart';

checkAvatar(BuildContext context, String image) {
  return image != ''
      ? CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: image != null ? NetworkImage(image) : null,
      )
      : Container(
        padding: EdgeInsets.all(10.0),
        child: Image.asset(
          'assets/images/user_not_found.png',
          color: Theme.of(context).primaryColorLight,
        ),
      );
}

avatarSquare(BuildContext context, String image) {
  return image != ''
      ? Container(
        child: Image.network(
          image,
          fit: BoxFit.cover,
          // color: Theme.of(context).primaryColorLight,
        ),
      )
      : Container(
        padding: EdgeInsets.all(10.0),
        child: Image.asset(
          'assets/images/user_not_found.png',
          color: Theme.of(context).primaryColorLight,
        ),
      );
}
