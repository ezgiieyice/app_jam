import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuildFavouriteCard extends StatefulWidget {
  final String name;
  final String imagePath;
  int like;
  String id;

  BuildFavouriteCard({
    required this.name,
    required this.imagePath,
    required this.like,
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<BuildFavouriteCard> createState() => _BuildFavouriteCardState();
}

class _BuildFavouriteCardState extends State<BuildFavouriteCard> {
  Color color = Colors.grey;

  void _toggleLike() {
    int newLike = widget.like + (color == Colors.grey ? 1 : -1); // Yeni like değerini hesapla
    FirebaseFirestore.instance.collection('cities').doc(widget.id).update({
      'like': newLike, // Firestore'da like alanını güncelle
    }).then((value) {
      print('Like updated successfully');
      setState(() {
        widget.like = newLike; // State'i güncelle
        color = color == Colors.grey ? Colors.red : Colors.grey;
      });
    }).catchError((error) {
      print('Failed to update like: $error');
      // Eğer güncelleme başarısız olursa, rengi geri eski haline getir ve like sayısını düzeltme
      setState(() {
        color = color == Colors.grey ? Colors.red : Colors.grey;
      });
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
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8.0,
                  left: 8.0,
                  child: InkWell(
                    onTap: _toggleLike,
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: color,
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          widget.like.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(child: Text(widget.name)),
        ],
      ),
    );
  }
}
