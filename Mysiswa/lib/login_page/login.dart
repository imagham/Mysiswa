  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';

  class Login extends StatefulWidget {
    const Login({super.key});

    @override
    State<Login> createState() => _MyWidgetState();
  }

  class _MyWidgetState extends State<Login> {
    @override
    Widget build(BuildContext context) {
      return Scaffold (
        appBar: AppBar(
          title: Text("LOGIN",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold) ,),backgroundColor: CupertinoColors.inactiveGray,
        ),body: Center(child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(controller:  TextEditingController(), decoration: InputDecoration(labelText: "Username",border: OutlineInputBorder(),prefixIcon: Icon(Icons.person)),),SizedBox(height: 25,),
              TextField(controller: TextEditingController(),obscureText: true, decoration: InputDecoration(labelText: "Password",border: OutlineInputBorder(),prefixIcon: Icon(Icons.lock),suffixIcon: Icon(Icons.repartition)),),
            ],
          ),
        ),)
      );
    }
  }