import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dasar/login_page/catatan.dart';
import 'package:flutter_dasar/login_page/jadwal.dart';
import 'package:flutter_dasar/login_page/tugas.dart';

class School extends StatefulWidget {
  const School({super.key});

  @override
  State<School> createState() => _SchoolState();
}

class _SchoolState extends State<School> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.school,color: Color(0xFFD2C1B6),),
            SizedBox(width: 8),
            Text("School", style:TextStyle(color: Color(0xFFD2C1B6),fontSize: 18,) ,)
          ],
        ),

         backgroundColor: const Color(0xFF1B3C53),

      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Catatan()));
                          },
                          child:  Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF1B3C53).withOpacity(0.3), // warna shadow
                                blurRadius: 10, // seberapa lembut blur
                                spreadRadius: 2, // seberapa besar area shadow
                                offset: const Offset(5, 5), // posisi x,y bayangan
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Icon(Icons.edit_note,size: 50,),
                                Text("Catatan")
                              ],
                            ),
                          ),
                        ),
                        ),
                        GestureDetector(
                           onTap: () {
                          Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => const Jadwal()),
                          );
                        },
                        child:  Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                              BoxShadow(
                                color: Color(0xFF1B3C53).withOpacity(0.3), // warna shadow
                                blurRadius: 10, // seberapa lembut blur
                                spreadRadius: 2, // seberapa besar area shadow
                                offset: const Offset(5, 5), // posisi x,y bayangan
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Icon(Icons.event,size: 50,),
                                Text("Jadwal")
                              ],
                            ),
                          ),
                          
                        ),
                        ),
                        GestureDetector(
                           onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Tugas()),
                            );
                          },
                          child:  Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                              BoxShadow(
                                color: Color(0xFF1B3C53).withOpacity(0.3), // warna shadow
                                blurRadius: 10, // seberapa lembut blur
                                spreadRadius: 2, // seberapa besar area shadow
                                offset: const Offset(5, 5), // posisi x,y bayangan
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Icon(Icons.assignment,size: 50,),
                                Text("Tugas")
                              ],
                            ),
                          ),
                        ), 
                        ),
                      
                        
                      ],
                    ),
        ],
      ),
      backgroundColor: const Color(0xFFD2C1B6),

    );
  }
}