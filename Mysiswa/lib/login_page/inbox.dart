 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Inbox extends StatelessWidget {
  const Inbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title: Center (child: const Text("Inbox",style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.grey,
      ),body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon( Icons.notifications_none, size: 50, color: Colors.grey,),
          Text("tidak ada notifikasi")
        
        ,],),), 
    );
  }
}