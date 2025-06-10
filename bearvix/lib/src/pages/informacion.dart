import 'package:bearvix/src/pages/pagesPrefer/home_page.dart';
import 'package:bearvix/src/pages/pagesPrefer/settings_page.dart';
import 'package:flutter/material.dart';

import '../share_prefs/preferencias_usuario.dart';

class Informacion extends StatelessWidget {
  

  final prefs = PreferenciasUsario();

  Informacion({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preferencias',
      initialRoute: prefs.ultimapagina,
      routes: {
    HomePage.routeName:(BuildContext context) => const HomePage(),
    SettingsPage.routeName:(BuildContext context)=> const SettingsPage(),
      },
    );
  }
}




