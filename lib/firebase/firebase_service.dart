import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Kullanıcının favori olarak işaretlediği öğelerin kimliklerini tutacak set
  Set<String> favorites = {};

  Future<List<DocumentSnapshot>> getDocumentsFromCollection(String collectionName) async {
    QuerySnapshot querySnapshot = await _firestore.collection(collectionName).get();
    return querySnapshot.docs;
  }
  // Seçilen yerin favori durumunu günceller
  Future<void> updateFavoriteStatus(String collectionName, String documentId, bool isFavorite) async {
    await _firestore.collection(collectionName).doc(documentId).update({'fav': isFavorite});
  }

  // Kullanıcının favori öğelerini günceller
  Future<void> updateFavorites(String col) async {
    // Firestore'dan favorileri  getir
    QuerySnapshot querySnapshot = await _firestore.collection(col).where('fav', isEqualTo: true).get();
    // Her bir favori belgesinin kimliğini set'e ekle
    favorites = querySnapshot.docs.map((doc) => doc.id).toSet();
  }
}
