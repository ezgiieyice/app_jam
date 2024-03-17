// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, prefer_const_constructors_in_immutables, avoid_unnecessary_containers
import 'package:app_jam/screen/explore_screen.dart';
import 'package:app_jam/screen/home_screen.dart';
import 'package:app_jam/screen/profile_screen.dart';
import 'package:app_jam/screen/favourite.dart';
import'package:flutter/material.dart';
class navigation extends StatefulWidget {
  final int page; //bulunan sayfaya göre buton aktif oluyor.

   navigation({super.key, required this.page});
  @override
  State<navigation> createState() => _navigationState();
}

class _navigationState extends State<navigation> {
  

  @override
  Widget build(BuildContext context) {
              
    return Container(padding: EdgeInsets.all(5),
      child: BottomNavigationBar(fixedColor: const Color.fromARGB(255, 208, 69, 27),
        elevation: 1,
          iconSize: 20,
          //selectedItemColor: Colors.blue,
          unselectedItemColor: Color.fromARGB(255, 111, 82, 71),
          
          items:[
            BottomNavigationBarItem(
              icon:Icon(Icons.home),
              label:'Anasayfa'
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.explore),
              label:'Keşfet',
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.favorite),
              label:'Favorilerim',
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.account_circle),
              label:'Profil',
            ),
          ],
      
          currentIndex:widget.page,
          onTap:(int index){
            if(index==0){
              Navigator.push(
                context,
                MaterialPageRoute(builder:(context) => HomeScreen()),
                
              );
                          
              
            }
            if(index==1){
              Navigator.push(
                context,
                MaterialPageRoute(builder:(context) => CitiesScreen()),
              );
               
            }
            if(index==2){
              Navigator.push(
                context,
                MaterialPageRoute(builder:(context) =>ExploreScreen() ),
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