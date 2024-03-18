import 'package:app_jam/buttons/navigation_bar.dart';
import 'package:app_jam/screen/city_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        title: Text('Anında'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('En Popüler Şehirler'),
            _buildPopularCityList(),
            _buildSectionTitle('Tüm Şehirler'),
            _buildCityGridFromFirestore(),
          ],
        ),
      ),
      bottomNavigationBar: Navigation(page: 1,),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 12.0), // Sol kenar boşluğu
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 12.0), // Sağ kenar boşluğu
        ],
      ),
    );
  }

  //like sayısına göre ilk 5 şehiri getiren fonk
  Widget _buildPopularCityList() {
    return SizedBox(
      height: 100,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('cities').orderBy('like', descending: true).limit(5).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          List<Widget> cityCards = [];
          snapshot.data!.docs.forEach((doc) {
            String cityName = doc['isim'];
            String cityId = doc['plaka'];
            cityCards.add(_buildCityCard(cityName, 'assets/istanbul.jpg',cityId));
            //_buildCityCard(cityName, cityId);
          });
          return ListView(
            scrollDirection: Axis.horizontal,
            itemExtent: 130,
            padding: EdgeInsets.all(8.0),
            children: cityCards,
          );
        },
      ),
    );
  }

  Widget _buildCityGridFromFirestore() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('cities').orderBy('isim').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(); // Veri yüklenene kadar dönme animasyonu göster
        }
        List<Widget> cityCards = [];
        snapshot.data!.docs.forEach((doc) {
          String cityName = doc['isim'];
          //String imagePath = doc['imagePath'];
          String cityId = doc['plaka'];
          cityCards.add(_buildCityCard(cityName, 'assets/istanbul.jpg',cityId));
        });
        return GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // GridView'in kendi scroll'u olmasın
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          padding: EdgeInsets.all(8.0),
          children: cityCards,
        );
      },
    );
  }

  Widget _buildCityCard(String cityName,String image, String cityId) {
    return InkWell(
      onTap: () {
        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CityDetailscreen(cityName: cityName, cityId: cityId,)),
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
                'assets/istanbul.jpg',
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
