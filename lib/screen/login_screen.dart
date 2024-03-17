// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, use_build_context_synchronously
import 'package:app_jam/screen/home_screen.dart';
import 'package:app_jam/screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('User logged in successfully!'),
                    ),
                  );

                  // Kullanıcı başarıyla kaydedildikten sonra başka bir sayfaya yönlendirin
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(), // Yönlendirilecek sayfanın adını ve constructor'ını buraya ekleyin
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to log in - $e'),
                    ),
                  );
                }
              },
              child: Text('Log In'),
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()
              )
            );
            }, child: Text("Sign In")
            
            )
          ],
        ),
      ),
    );
  }
}