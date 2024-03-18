import 'package:app_jam/buttons/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorilerim'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collectionGroup('your_collection').where('fav', isEqualTo: true).snapshots(),
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

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('Favorilerinizde herhangi bir içerik bulunmamaktadır.'),
            );
          }

          // Verileri kullanarak gösterim oluşturun
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              // Her bir doküman için ListTile oluşturun
              return ListTile(
                title: Text(document['title']),
                subtitle: Text(document['subtitle']),
                trailing: IconButton(
                  icon: Icon(Icons.favorite),
                  color: Colors.red,
                  onPressed: () {
                    // Favoriyi kaldırma işlemi
                    _removeFromFavorites(document.id);
                  },
                ),
                // İsterseniz tıklanabilirliği buradan ayarlayabilirsiniz
                onTap: () {
                  // Tıklama işlemi buraya ekleyebilirsiniz
                },
              );
            }).toList(),
          );
        },
      ),
      bottomNavigationBar: Navigation(page: 2,),
    );
  }

  // Firestore'dan belgeyi favorilerden kaldıran fonksiyon
  void _removeFromFavorites(String documentId) {
    FirebaseFirestore.instance.collection('your_collection').doc(documentId).update({'fav': false}).then((value) {
      setState(() {
        // Favori kaldırıldıktan sonra favori listesini yeniden yükleyin
      });
    }).catchError((error) {
      print("Favori kaldırılırken bir hata oluştu: $error");
      // Hata durumunda kullanıcıya bildirim gösterebilirsiniz
    });
  }
}
