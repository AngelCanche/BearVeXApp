import 'package:bearvix/src/pages/conceptos.dart';
import 'package:bearvix/src/pages/informacion.dart';
import 'package:bearvix/src/pages/pagesPrefer/home_page.dart';
import 'package:bearvix/src/pages/pagesPrefer/settings_page.dart';
import 'package:bearvix/src/pages/principal.dart';
import 'package:bearvix/src/share_prefs/preferencias_usuario.dart';
import 'package:bearvix/src/widgets/colores.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Poligono extends StatelessWidget {
  final prefs = new PreferenciasUsario();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poligono',
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
  List<Vectors> vectors = [];  // Lista de vectores
  double zoom = 1.0;
  int _currentIndex = 0;

  double startX = 0;
  double startY = 0; // Guarda el último punto de inicio

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navegación entre pantallas
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

  void _addVector(double angle, double length) {
    setState(() {
      // Calcular las coordenadas del nuevo vector basado en el ángulo y la longitud
      double radians = angle * pi / 180;
      double endX = length * cos(radians) * zoom;
      double endY = length * sin(radians) * zoom;

      // Añadir el vector a la lista
      vectors.add(Vectors(angle, length, endX, endY));

      // Actualizar las coordenadas para el siguiente vector
      startX += endX;
      startY += endY;
    });
  }

  // Método para calcular la resultante
  Vectors _calculateResultant() {
    double totalX = 0;
    double totalY = 0;

    // Sumar las componentes de X y Y de todos los vectores
    for (var vector in vectors) {
      totalX += vector.endX;
      totalY += vector.endY;
    }

    // Calcular la magnitud de la resultante
    double magnitude = sqrt(totalX * totalX + totalY * totalY);
    // Calcular el ángulo de la resultante
    double angle = atan2(totalY, totalX) * 180 / pi;

    return Vectors(angle, magnitude, totalX, totalY);
  }

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(
        title: Text('Método del Polígono'),
        centerTitle: true,
      ),
      body: isWideScreen
          ? Row(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return CustomPaint(
                        painter: CartesianGridAndVectorPainter(vectors, zoom),
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
                        painter: CartesianGridAndVectorPainter(vectors, zoom),
                        child: Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight*0.6,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(child: SingleChildScrollView(
                  child: 
                      Container(
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
    double angle = 0;
    double length = 0;

    // Obtener la resultante de todos los vectores
    Vectors resultant = _calculateResultant();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Información actual',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(labelText: 'Ángulo'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            angle = double.tryParse(value) ?? 0;
          },
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(labelText: 'Tamaño'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            length = double.tryParse(value) ?? 100;
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _addVector(angle, length),
          child: Text('Añadir Vector'),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _increaseZoom,
          child: Text('+ Zoom'),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _decreaseZoom,
          child: Text('- Zoom'),
        ),
        SizedBox(height: 20),
        // Mostrar el resultado de la resultante
        Text(
          'Resultante: \nÁngulo: ${resultant.angle.toStringAsFixed(2)}°\nMagnitud: ${resultant.length.toStringAsFixed(2)}\nComponente X: ${resultant.endX.toStringAsFixed(2)}\nComponente Y: ${resultant.endY.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
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
        onTap: onTabTapped,
        currentIndex: _currentIndex,
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
              color: _currentIndex == 3 ? Colors.pinkAccent : Color.fromARGB(255, 255, 255, 255),
            ),
            label: 'Perfil de Usuario',
          ),
        ],
      ),
    );
  }
}

class CartesianGridAndVectorPainter extends CustomPainter {
  final List<Vectors> vectors;
  final double zoom;

  CartesianGridAndVectorPainter(this.vectors, this.zoom);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint gridPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 0.5;

    final double step = 20 * zoom;

    // Dibujar la cuadrícula
    for (double i = 0; i < size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double i = 0; i < size.height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), gridPaint);
    }

    final Paint axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    // Dibujar los ejes X y Y
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

    // Dibujar los vectores
    Paint vectorPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3.0;

    double currentX = size.width / 2;  // Empezamos en el centro de la pantalla
    double currentY = size.height / 2;

    for (var vector in vectors) {
      // Calculamos la nueva posición final de cada vector
      double endX = currentX + vector.endX;
      double endY = currentY - vector.endY;

      // Dibujar el vector
      canvas.drawLine(
        Offset(currentX, currentY),
        Offset(endX, endY),
        vectorPaint,
      );

      // Actualizamos la posición de inicio para el siguiente vector
      currentX = endX;
      currentY = endY;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// Define the new Vectors class
class Vectors {
  final double angle;
  final double length;
  final double endX;
  final double endY;

  Vectors(this.angle, this.length, this.endX, this.endY);
}
