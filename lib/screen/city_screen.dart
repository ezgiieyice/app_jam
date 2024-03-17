// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, camel_case_types, unused_element

import 'package:flutter/material.dart';
import "package:app_jam/buttons/favourite_card.dart";

class Cityscreen extends StatefulWidget {
  final String cityname; 
  const Cityscreen( {super.key, required this.cityname});

  @override
  State<Cityscreen> createState() => _CityscreenState();
}

class _CityscreenState extends State<Cityscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.cityname}"),),//seçilen şehrin ismi
      body: GridView.count(crossAxisCount:2,padding:EdgeInsets.all(15),
      children: [
        buildFavouriteCard(),  
      ],)
    );
  }
}


  
  
  

