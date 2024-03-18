import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_jam/firebase/firebase_service.dart';

class CategoryScreen extends StatefulWidget {
  final String category;

  const CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _updateFavorites(widget.category);
  }

  void _updateFavorites(String col) async {
    await _firestoreService.updateFavorites(col);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection(widget.category).snapshots(),
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
              String documentId = document.id;
              String cityName = document['isim'];
              bool isFavorite = _firestoreService.favorites.contains(documentId);

              return ListTile(
                title: Text(cityName),
                trailing: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () async {
                    bool newFavoriteState = !isFavorite;
                    await _firestoreService.updateFavoriteStatus(widget.category, documentId, newFavoriteState);
                    _updateFavorites(widget.category);
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
