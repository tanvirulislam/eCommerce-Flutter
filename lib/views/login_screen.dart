import 'package:flutter/material.dart';
import 'package:test_project/google_signin/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Text(
                'Fast Food',
                textScaleFactor: 2,
                style: TextStyle(color: Colors.cyan),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(45),
                child: Image.network(
                  'https://www.daysoftheyear.com/wp-content/uploads/national-fast-food-day.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // SizedBox(height: 140),
            InkWell(
              onTap: () {
                authClass.handleSignIn(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 22,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.cyan),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/images/google.png'),
                      ),
                      Text('Sign in with Google'),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
