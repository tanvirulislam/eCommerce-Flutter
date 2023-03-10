import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/google_signin/google_sign_in.dart';
import 'package:test_project/providers/cart_provider.dart';
import 'package:test_project/providers/category_provider.dart';
import 'package:test_project/providers/product_provider.dart';
import 'package:test_project/providers/user_provider.dart';
import 'package:test_project/views/bottom_nav_controller.dart';
import 'package:test_project/views/login_screen.dart';
import 'package:test_project/views/product_overview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = LoginScreen();
  AuthClass authClass = AuthClass();
  checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = BottomNavController();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fast Food',
        theme: ThemeData(primarySwatch: Colors.cyan),
        home: currentPage,
        // home: ProductOverview(),
      ),
    );
  }
}
