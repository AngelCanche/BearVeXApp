
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsario{


 static final PreferenciasUsario _instancia = PreferenciasUsario._internal();

 factory PreferenciasUsario(){
   return _instancia;
 }


  PreferenciasUsario._internal();

 late SharedPreferences _prefs;


 initPrefs()async{
   _prefs = await SharedPreferences.getInstance();
 }


  get genero{
   return _prefs.getInt('genero') ?? 1;
 }

 set setnero(int value){
   _prefs.setInt('genero', value);
 }


  get colores{
   return _prefs.getInt('colores') ?? 1;
 }

 set setcolores(int value){
   _prefs.setInt('colores', value);
 }


get colorSecundario{
   return _prefs.getBool('colorSecundario') ?? false;
 }

 set colorSec(bool value){
   _prefs.setBool('colorSecundario', value);
 }


get nombreUsuario{
   return _prefs.getString('nombreUsuario') ?? '';
 }

 set nomUsu(String value){
   _prefs.setString('nombreUsuario', value);
 }



get ultimapagina{
   return _prefs.getString('ultimaPagina') ?? 'home';
 }

 set ultimatepage(String value){
   _prefs.setString('ultimaPagina', value);
 }




}