// ignore_for_file: prefer_const_constructors

import 'package:app_jam/buttons/navigation_bar.dart';
import'package:flutter/material.dart';
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Favorilerim"),),
      body:SafeArea(child: Center(
        child: Text("Favorilerimiz burada"),
      )),
      bottomNavigationBar: navigation(page: 2),
    );
  }
}