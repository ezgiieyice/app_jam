import 'package:app_jam/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_jam/screen/profile_screen.dart';

class CityScreen extends StatelessWidget {
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black,),
            label: 'Anasayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore, color: Colors.black,),
            label: 'Şehirler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share_location_outlined, color: Colors.black,),
            label: 'Rotam',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.black,),
            label: 'Profil',
          ),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.blue, // Seçilen öğe rengi
        unselectedItemColor: Colors.black, // Seçilmemiş öğe rengi

        onTap: (int index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
          else if (index == 1) {
          }
          else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          }
          else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          }
        },
      ),
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
        _buildCityCard('İstanbul', 'assets/istanbul.jpg'),
        _buildCityCard('Ankara', 'assets/istanbul.jpg'),
        _buildCityCard('İzmir', 'assets/istanbul.jpg'),
        _buildCityCard('Trabzon', 'assets/istanbul.jpg'),
        _buildCityCard('Diyarbakır', 'assets/istanbul.jpg'),
        _buildCityCard('Şanlıurfa', 'assets/istanbul.jpg'),
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
        // Şehir detay sayfasına yönlendirme yapılabilir
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
