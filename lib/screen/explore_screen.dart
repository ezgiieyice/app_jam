// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
import 'package:app_jam/buttons/navigation_bar.dart';
import 'package:app_jam/screen/city_screen.dart';
import'package:flutter/material.dart';
class CitiesScreen extends StatefulWidget {
  @override
  State<CitiesScreen> createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('En Popüler Şehirler'),
            _buildCityList(),
            _buildSectionTitle('Tüm Şehirler'),
            _buildCityGrid(),
          ],
        ),
      ),
      bottomNavigationBar: navigation(page: 1),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCityList() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        itemExtent: 130, // Kartların genişliği
        padding: EdgeInsets.all(8.0),
        children: [
          _buildCityCard('İstanbul', 'assets/istanbul.jpg'),
          _buildCityCard('Ankara', 'assets/istanbul.jpg'),
          _buildCityCard('İzmir', 'assets/istanbul.jpg'),
          _buildCityCard('Trabzon', 'assets/istanbul.jpg'),
          _buildCityCard('Diyarbakır', 'assets/istanbul.jpg'),
          _buildCityCard('Şanlıurfa', 'assets/istanbul.jpg'),
        ],
      ),
    );
  }

  Widget _buildCityGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      padding: EdgeInsets.all(8.0),
      children: [
        _buildCityCard('İstanbul', 'assets/istanbul.jpg'),
        _buildCityCard('Ankara', 'assets/istanbul.jpg'),
        _buildCityCard('İzmir', 'assets/istanbul.jpg'),
        _buildCityCard('Trabzon', 'assets/istanbul.jpg'),
        _buildCityCard('Diyarbakır', 'assets/istanbul.jpg'),
        _buildCityCard('Şanlıurfa', 'assets/istanbul.jpg'),
        
      ],
    );
  }

  Widget _buildCityCard(String cityName, String imagePath) {
    return InkWell(
      onTap: () {
        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cityscreen(cityname: cityName,)),
            );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                cityName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
