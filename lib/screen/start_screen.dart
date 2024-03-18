import 'package:flutter/material.dart';
import 'package:app_jam/screen/login_screen.dart';
import 'package:app_jam/screen/signup_screen.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo burada yer alacak
            Image.asset(
              'assets/uyLogo.jpg', // Logo dosyasının yolu
              width: 350, // Görüntü genişliği
              height: 350, // Görüntü yüksekliği
            ),
            SizedBox(height: 20), // Araya boşluk ekleyelim

            // Login butonu
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Giriş Yap'),
            ),

            SizedBox(height: 10), // Araya biraz daha boşluk ekleyelim

            // Sign Up butonu
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Text('Kayıt Ol '),
            ),
          ],
        ),
      ),
    );
  }
}
