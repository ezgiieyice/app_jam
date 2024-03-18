import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuildCityCard extends StatefulWidget {
  const BuildCityCard({Key? key});

  @override
  State<BuildCityCard> createState() => _BuildCityCardState();
}

class _BuildCityCardState extends State<BuildCityCard> {
  late Color color;
  late String placeName;
  late String imageURL;

  @override
  void initState() {
    super.initState();
    // Firestore'dan verileri almak için initState içinde kullanabiliriz
    _fetchData();
  }

  Future<void> _fetchData() async {
    // Firestore'dan verileri al
    final snapshot = await FirebaseFirestore.instance.collection('cities').doc('YOUR_DOCUMENT_ID').get();
    // Firestore'dan alınan verileri kullanarak state'i güncelle
    setState(() {
      placeName = snapshot['isim'];
      imageURL = snapshot['url'];
      color = Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(imageURL), // Firestore'dan alınan görsel
          ),
          Center(child: Text(placeName)), // Firestore'dan alınan yer adı
          Padding(
            padding: EdgeInsets.only(left: 70, right: 70),
            child: IconButton(
              color: color,
              onPressed: () {
                setState(() {
                  color = color == Colors.grey ? Colors.red : Colors.grey;
                });
              },
              icon: Icon(Icons.favorite),
            ),
          ),
        ],
      ),
    );
  }
}
