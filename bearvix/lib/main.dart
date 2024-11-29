import 'package:bearvix/src/app.dart';
import 'package:bearvix/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsario(); 
  await prefs.initPrefs ();
  runApp(myapp());
}
