import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dasar/login_page/inbox.dart';

class homepage1 extends StatefulWidget {
  final String username;
  const homepage1({super.key, required this.username}); // ✅ diperbaiki

  @override
  State<homepage1> createState() => _homepage1State();
}

class _homepage1State extends State<homepage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder:(context)=>Inbox()),);},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: [
              Text(
                "Assalamualaikum, ${widget.username}",
                style: const TextStyle(fontSize: 30),
              ),
              const Text("Selamat datang di Home Page!"),
            ],
          ),
        ),
      ),floatingActionButton: FloatingActionButton(onPressed: (){}, child: const Icon(Icons.camera_alt),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat ,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.home),),
            IconButton(onPressed: (){}, icon: const Icon(Icons.school),),
            SizedBox(width: 50,),
            IconButton(onPressed: (){}, icon: const Icon(Icons.person),),
            IconButton(onPressed: (){}, icon: const Icon(Icons.calendar_month),),

          ],
      )),
    );
  }
}
