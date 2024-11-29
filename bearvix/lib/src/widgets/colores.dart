import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

const Color color1 = Color(0xFF0097b2); // Azul
const Color color2 = Color(0xFF7ed957); // Verde
const Color customTealColor = Color(0xFF030F7E);

// Crear un mapa de tonos para el MaterialColor
Map<int, Color> colorSwatch = {
  50: customTealColor.withOpacity(0.1),
  100: customTealColor.withOpacity(0.2),
  200: customTealColor.withOpacity(0.3),
  300: customTealColor.withOpacity(0.4),
  400: customTealColor.withOpacity(0.5),
  500: customTealColor.withOpacity(0.6),
  600: customTealColor.withOpacity(0.7),
  700: customTealColor.withOpacity(0.8),
  800: customTealColor.withOpacity(0.9),
  900: customTealColor.withOpacity(1.0),
};
MaterialColor customTealMaterialColor = MaterialColor(customTealColor.value, colorSwatch);


MaterialColor getMaterialColorBasedOnPreference(int preference) {
  if (preference == 1) {
    return customTealMaterialColor; // Azul
  } else if (preference == 2) {
    return Colors.teal; // Verde
  } else if (preference == 3) {
    return Colors.red; 
  } else if (preference == 4) {
    return Colors.purple; 
  } else {
    return Colors.pink; // Color por defecto en caso de que no coincida con ninguna preferencia
  }
}