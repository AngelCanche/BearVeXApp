import 'package:bearvix/src/pages/conceptos.dart';
import 'package:bearvix/src/pages/principal.dart';
import 'package:bearvix/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'pagesPrefer/home_page.dart';
import 'pagesPrefer/settings_page.dart';

class Vector extends StatelessWidget {
  final prefs = new PreferenciasUsario();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vector',
      theme: ThemeData(
        primarySwatch: getMaterialColorBasedOnPreference(prefs.colores),
      ),
      home: VectorDrawer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class VectorDrawer extends StatefulWidget {
  @override
  _VectorDrawerState createState() => _VectorDrawerState();
}

class _VectorDrawerState extends State<VectorDrawer> {
  double angle = 0;
  double length = 0;
  double zoom = 1.0;
  Offset offset = Offset(0, 0);
  double xCoord = 0; // Coordenada X
  double yCoord = 0; // Coordenada Y
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => principal()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Conceptos()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
    }
  }

  void _increaseZoom() {
    setState(() {
      zoom += 0.1;
    });
  }

  void _decreaseZoom() {
    setState(() {
      if (zoom > 0.1) {
        zoom -= 0.1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(
        title: Text('Vectores'),
        centerTitle: true,
      ),
      body: isWideScreen
          ? Row(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return CustomPaint(
                        painter: CartesianGridAndVectorPainter(angle, length, zoom, xCoord, yCoord),
                        child: Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: 250,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _buildControls(),
                ),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return CustomPaint(
                        painter: CartesianGridAndVectorPainter(angle, length, zoom, xCoord, yCoord),
                        child: Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight * 0.6,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(

                child:Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _buildControls(),
                ),
                  )
                )
              ],
            ),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _buildControls() {
    return Column(
     
      children: [
        Text(
          'Información actual',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(labelText: 'Angulo'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              angle = double.tryParse(value) ?? 0;
            });
          },
        ),
        SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(labelText: 'Tamaño'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              length = double.tryParse(value) ?? 100;
            });
          },
        ),
        SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(labelText: 'Coordenada X'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              xCoord = double.tryParse(value) ?? 0;
            });
          },
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(labelText: 'Coordenada Y'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              yCoord = double.tryParse(value) ?? 0;
            });
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _increaseZoom,
          child: Text('+ Zoom'),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _decreaseZoom,
          child: Text('- Zoom'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Angulo: $angle grados, Magnitud: $length'),
        ),
      ],
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: const Color.fromRGBO(55, 57, 84, 1.0),
        primaryColor: Colors.pinkAccent,
        textTheme: Theme.of(context).textTheme.copyWith(
          caption: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      child: BottomNavigationBar(
        onTap: onTabTapped, // Establecer el método onTabTapped para manejar los taps
        currentIndex: _currentIndex, // Actualizar el índice actual
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.house_rounded,
              color: _currentIndex == 0 ? Colors.pinkAccent : Color.fromARGB(255, 255, 255, 255),
            ),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.feed,
              color: _currentIndex == 1 ? Colors.pinkAccent : Color.fromARGB(255, 255, 255, 255),
            ),
            label: 'Información',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: _currentIndex == 2 ? Colors.pinkAccent : Color.fromARGB(255, 255, 255, 255),
            ),
            label: 'Ajustes',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _currentIndex == 2 ? Colors.pinkAccent : Color.fromARGB(255, 255, 255, 255),
            ),
            label: 'Perfil de Usuario',
          ),
        ],
      ),
    );
  }
}

class CartesianGridAndVectorPainter extends CustomPainter {
  final double angle;
  final double length;
  final double zoom;
  final double xCoord;
  final double yCoord;

  CartesianGridAndVectorPainter(this.angle, this.length, this.zoom, this.xCoord, this.yCoord);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint gridPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 0.5;

    final double step = 20 * zoom;

    // Dibuja la cuadrícula
    for (double i = 0; i < size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double i = 0; i < size.height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), gridPaint);
    }

    // Dibuja los ejes X y Y
    final Paint axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      axisPaint,
    );
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      axisPaint,
    );

    // Añadir números al eje X (positivos y negativos)
    for (double i = -size.width / 2; i <= size.width / 2; i += step) {
      if (i == 0) continue; // Evitar el cero
      final TextPainter textPainter = TextPainter(
        text: TextSpan(text: (i / step).toInt().toString(), style: TextStyle(color: Colors.black, fontSize: 10)),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(i + size.width / 2 - 10, size.height / 2 + 2));
    }

    // Añadir números al eje Y (positivos y negativos)
    for (double i = -size.height / 2; i <= size.height / 2; i += step) {
      if (i == 0) continue; // Evitar el cero
      final TextPainter textPainter = TextPainter(
        text: TextSpan(text: ((-i / step).toInt()).toString(), style: TextStyle(color: Colors.black, fontSize: 10)),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(size.width / 2 + 2, i + size.height / 2 - 10));
    }

    // Calculamos las coordenadas ajustadas del vector con el zoom y el desplazamiento
    final double radians = angle * pi / 180;
    // Ajuste para la coordenada X y Y: trasladamos las coordenadas ingresadas a la vista del canvas
    final double adjustedXCoord = (xCoord * step) * zoom;  // Coordenada X ajustada
    final double adjustedYCoord = (yCoord * step) * zoom;  // Coordenada Y ajustada

    // Calcula las nuevas posiciones del final del vector basándonos en la longitud y el ángulo
    final double xEnd = (adjustedXCoord + length * cos(radians)) * zoom;
    final double yEnd = (adjustedYCoord + length * sin(radians)) * zoom;

    final Paint vectorPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0;

    // Dibuja el vector con la nueva coordenada ajustada
    canvas.drawLine(
      Offset(size.width / 2, size.height / 2),
      Offset(size.width / 2 + xEnd, size.height / 2 - yEnd),
      vectorPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}



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
