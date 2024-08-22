import 'package:crypto_api/pages/home_page.dart';
import 'package:crypto_api/util.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
// import 'package:crypto_api/utils.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await registerServices();
  await registerControllers();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.quicksandTextTheme(),
      ),
      routes: {
        '/home': (context) => HomePage(),
      },
      initialRoute: '/home',
    );
  }
}
