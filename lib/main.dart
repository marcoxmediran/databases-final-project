import 'package:flutter/material.dart';
import 'package:databases_final_project/ui/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Databases Final Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
