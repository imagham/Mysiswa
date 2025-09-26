import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.person, color: Color(0xFFD2C1B6)),
            SizedBox(width: 8),
            Text(
              "Profile",
              style: TextStyle(color: Color(0xFFD2C1B6), fontSize: 18),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1B3C53),
      ),
    );
  }
}