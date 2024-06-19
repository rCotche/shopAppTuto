import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/cart_provider.dart';
import 'package:shop_app_flutter/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //widget Provider provient du package provider
    //Provider pour le state management, equivalent de la session en web

    //Provider(
    //create: (context) => 'Hello, world !',//exemple

    //4 type de provider : Provider, ChangeNotifierProvider, FutureProvider, StreamProvider

    //ChangeNotifierProvider un autre type de provider du package provider
    return ChangeNotifierProvider(
      //dans ChangeNotifierProvider la propriete create
      //crée un ChangeNotifier qui provient de Flutter

      //donc la classe doit herite de ChangeNotifier
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Shopping App',
        theme: ThemeData(
          //set up la typo ici pour que toute l'application
          // utilise la mm typo sans le mentionner à chaque fois
          fontFamily: 'Lato',
          //ColorScheme.fromSeed, Les couleurs de l'application vont dérivé à partir d'une seul couleur
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(254, 206, 1, 1),
            //override la primary color de la seed
            primary: const Color.fromRGBO(254, 206, 1, 1),
          ),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            centerTitle: true,
          ),
          //tous les textfiels auront le mm style
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
          ),
          textTheme: const TextTheme(
            //certaib widget utilise ces propriete par default
            //par exemple app bar utilise titleLarge
            titleLarge: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            titleMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            bodySmall: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );

    //Dans le cas où j'ai besoin de plusieur provider

    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(
    //       create: (context) => CartProvider(),
    //     ),
    //     ChangeNotifierProvider(
    //       create: (context) => CartProviderBis(),
    //     ),
    //     ...
    //   ],
    //   child: MyApp(),
    // );
  }
}
