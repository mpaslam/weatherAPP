import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/api.dart';
import 'package:weatherapp/theame/sharedprfrance.dart';
import 'package:weatherapp/ui/ui.dart';

Future<void> main() async {
    await dotenv.load();

  runApp( MyApp());
}
class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (context) => WeatherScreen(),),
         ChangeNotifierProvider(create: (context) => DarkThemePreference())
      ],
     child:  MaterialApp(
       debugShowCheckedModeBanner: false,
       //theme: Styles.themeData(themeChangeProvider.darkTheme, context),
       home: HomePage(),
     ),
  );
  }}