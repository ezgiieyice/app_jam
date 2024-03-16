import 'package:app_jam/screen/city_screen.dart';
import'package:app_jam/screen/profile_screen.dart';
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
      bottomNavigationBar:BottomNavigationBar(
        items:[
          BottomNavigationBarItem(
            icon:Icon(Icons.home),
            label:'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.explore),
            label:'Keşfet',
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.share_location_outlined),
            label:'Rotam',
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.account_circle),
            label:'Profil',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        currentIndex: 0,
        onTap:(int index){
          if(index==1){
            Navigator.push(
              context,
              MaterialPageRoute(builder:(context) => CityScreen()),
            );
          }
          if(index==3){
            Navigator.push(
              context,
              MaterialPageRoute(builder:(context) => ProfileScreen()),
            );
          }
        },
      ),
    );
  }



}
