import 'package:flutter/material.dart';
import 'package:refined_feasts/home.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Poppins",
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

