import 'package:app_jam/buttons/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_jam/buttons/favourite_card.dart';
import 'category_screen.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anında'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: TextField(
              controller: TextEditingController(),
              obscureText: false,
              textAlign: TextAlign.start,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14,
                color: Color(0xffffffff),
              ),
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Color(0x00ffffff), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Color(0x00ffffff), width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Color(0x00ffffff), width: 1),
                ),
                hintText: "Ne keşfetmek istiyorsun...",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0x86ffffff),
                ),
                filled: true,
                fillColor: Color(0xffdea270),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                prefixIcon: Icon(Icons.search, color: Color(0x86ffffff), size: 20),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('categories').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  return Row(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      return Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        child: GestureDetector(
                          onTap: () {
                            print("Tıklanan kategori: ${data['name']}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryScreen(category: data['name']),
                              ),
                            );
                          },
                          child: Chip(
                            labelPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                            label: Text(data['name']),
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                            ),
                            backgroundColor: const Color.fromARGB(255, 208, 69, 27),
                            elevation: 0,
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 16),

          Expanded(
             child: Padding(
               padding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
               child:
                  _buildCityGridFromFirestore()
             ),
           ),
        ],
      ),
      bottomNavigationBar: Navigation(page: 0,),
    );
  }

  Widget _buildCityGridFromFirestore() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('cities').orderBy('like',descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(); // Veri yüklenene kadar dönme animasyonu göster
        }
        List<Widget> cityCards = [];
        snapshot.data!.docs.forEach((doc) {
          String cityName = doc['isim'];
          int cityLike = doc['like'];
          //String imagePath = doc['imagePath'];
          String id = doc['plaka'];
          cityCards.add(BuildFavouriteCard(name: cityName, imagePath: 'assets/istanbul.jpg',like: cityLike,id: id,));
        });
        return GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          padding: EdgeInsets.all(8.0),
          children: cityCards,
        );
      },
    );
  }
}
