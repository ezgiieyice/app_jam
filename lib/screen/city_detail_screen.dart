import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_jam/firebase/firebase_service.dart';

class CityDetailscreen extends StatefulWidget {
  final String cityName;
  final String cityId;

  const CityDetailscreen({Key? key, required this.cityName,required this.cityId})
      : super(key: key);

  @override
  CityDetailscreenState createState() => CityDetailscreenState();
}
class CityDetailscreenState extends State<CityDetailscreen> {

  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _updateFavorites(widget.cityName);
  }

  void _updateFavorites(String col) async {
    await _firestoreService.updateFavorites(col);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cityName),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('cities').doc(widget.cityId).collection(widget.cityName).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Veri alınırken bir hata oluştu.'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              String innerData = document['isim'];
              return ListTile(
                title: Text(innerData),
                // Burada favori durumunu göstermek için bir IconButton ekle
                // Örneğin, favorilere ekleme/çıkarma işlemleri için _updateFavorites fonksiyonunu çağır
              );
            }).toList(),
          );
        },
      ),
    );
  }
}


