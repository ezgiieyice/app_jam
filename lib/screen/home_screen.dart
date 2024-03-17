// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_jam/buttons/navigation_bar.dart';
import'package:flutter/material.dart';
class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text('YerelGezgin'),
        automaticallyImplyLeading: false,
      ),
      body:SingleChildScrollView(
        child:Column(
          children:[
            Padding(
              padding:const EdgeInsets.symmetric(horizontal:16.0,vertical:8.0),
              child:Text(
                'Keşfet',
                style:TextStyle(fontSize:24,fontWeight:FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:navigation(page: 0),
    );
  }
}
