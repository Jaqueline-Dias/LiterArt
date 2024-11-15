import 'package:flutter/material.dart';

class ContainerProfile extends StatelessWidget {
  const ContainerProfile({
    super.key,
    this.user,
  });

  final dynamic user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          width: 4,
          color: Colors.white,
        ),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 10,
            color: Colors.grey.withOpacity(0.1),
          )
        ],
        shape: BoxShape.circle,
        image: user != null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(user),
              )
            : const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/profile.png"),
              ),
      ),
    );
  }
}
