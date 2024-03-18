import 'package:app_jam/screen/change_password_screen.dart';
import 'package:app_jam/screen/start_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../buttons/navigation_bar.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late ThemeMode _currentThemeMode; // Güncel tema modunu saklamak için değişken
  late ThemeMode _savedThemeMode; // Kaydedilmiş tema modunu saklamak için değişken

  @override
  void initState() {
    super.initState();
    _currentThemeMode = ThemeMode.system; // Başlangıçta sistem temasını kullan
    _savedThemeMode = _currentThemeMode; // Başlangıçta kaydedilmiş tema modunu güncel tema moduna eşitle
  }

  // Tema modunu değiştiren fonksiyon
  void _changeThemeMode(ThemeMode mode) {
    setState(() {
      _currentThemeMode = mode; // Güncel tema modunu değiştir
    });
  }

  // Tema modunu kaydeden fonksiyon
  void _saveThemeMode() {
    _savedThemeMode = _currentThemeMode; // Güncel tema modunu kaydet
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _currentThemeMode,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black, // Karanlık modda scaffold arka plan rengi
        iconTheme: IconThemeData(color: Colors.white), // Karanlık modda sembollerin rengi
        textTheme: ThemeData.dark().textTheme.apply(bodyColor: Colors.white), // Karanlık modda metin rengi
      ),
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 208, 69, 27), // Aydınlık modda AppBar rengi turuncu
        ),
      ),
      home: Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Ayarlar"),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.light_mode), // Başında sembol ekleyin
                    title: Text(_currentThemeMode == ThemeMode.dark ? 'Aydınlık Tema' : 'Karanlık Tema'),
                    onTap: () {
                      // Tema modunu değiştir
                      if (_currentThemeMode == ThemeMode.dark) {
                        _changeThemeMode(ThemeMode.light); // Karanlık mod ise aydınlık moda geç
                      } else {
                        _changeThemeMode(ThemeMode.dark); // Aydınlık mod ise karanlık moda geç
                      }
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.lock), // Başında sembol ekleyin
                    title: Text('Şifre Değiştir'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout), // Başında sembol ekleyin
                    title: Text('Çıkış Yap'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Çıkış Yap"),
                            content: Text("Çıkış yapmak istediğinize emin misiniz?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("İptal"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (await signOut()) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => StartScreen()),
                                    );
                                  }
                                },
                                child: Text('Çıkış Yap'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Navigation(page: 3),
      ),
    );
  }

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut(); // Firebase Authentication'dan çıkış yap
      print("Çıkış yapıldı.");
      return true;
    } catch (e) {
      print("Çıkış yapılırken bir hata oluştu: $e");
      return false;
    }
  }
}
