import 'package:flutter/material.dart';
import 'package:minpro_todo/di/providers.dart';
import 'package:provider/provider.dart';

import 'view/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: globalProviders,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
