// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, prefer_const_constructors_in_immutables, avoid_unnecessary_containers
import 'package:app_jam/screen/explore_screen.dart';
import 'package:app_jam/screen/home_screen.dart';
import 'package:app_jam/screen/settings_screen.dart';
import 'package:app_jam/screen/favourite.dart';
import'package:flutter/material.dart';
class Navigation extends StatelessWidget {
  final int page; //bulunan sayfaya göre buton aktif oluyor.

  Navigation({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: BottomNavigationBar(
        fixedColor: const Color.fromARGB(255, 208, 69, 27),
        elevation: 1,
        iconSize: 20,
        unselectedItemColor: Color.fromARGB(255, 111, 82, 71),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Keşfet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorilerim',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
        ],
        currentIndex: page,
        onTap: (int index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CitiesScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FavoritesScreen()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          }
        },
      ),
    );
  }
}