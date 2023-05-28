import 'package:enam_dua_teknologi/provider/multiproviders.dart';
import 'package:enam_dua_teknologi/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: multiProvider,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: '62 Teknologi',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
