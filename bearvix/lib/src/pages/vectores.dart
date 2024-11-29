import 'package:bearvix/src/pages/conceptos.dart';
import 'package:bearvix/src/pages/paralelogramo.dart';
import 'package:bearvix/src/share_prefs/preferencias_usuario.dart';
import 'package:bearvix/src/widgets/colores.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'pagesPrefer/home_page.dart';
import 'pagesPrefer/settings_page.dart';
import 'principal.dart';

class SumadeVectores extends StatelessWidget {
  final prefs = new PreferenciasUsario();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suma de Vectores',
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
  List<Vectores> vectors = [];
  double angle = 0;
  double length = 100;
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

  void _addVector() {
    setState(() {
      vectors.add(Vectores(angle, length, xCoord, yCoord));
    });
  }

  Vectores _calculateResultant() {
    double resultantX = 0;
    double resultantY = 0;

    // Sumar todos los vectores
    for (var vector in vectors) {
      double radians = vector.angle * pi / 180; // Convertir a radianes
      resultantX += vector.length * cos(radians);
      resultantY += vector.length * sin(radians);
    }

    // Calcular la longitud y el ángulo de la resultante
    double resultantLength = sqrt(resultantX * resultantX + resultantY * resultantY);
    double resultantAngle = atan2(resultantY, resultantX) * 180 / pi; // Convertir a grados

    return Vectores(resultantAngle, resultantLength, 0, 0); // Coordenadas de la resultante no importan
  }

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(
        title: Text('Suma de Vectores'),
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
                          height: constraints.maxHeight * 0.6, 
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView( // Hacemos que los controles sean desplazables
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _buildControls(),
                    ),
                  ),
                ),
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
        // Ángulo
        TextField(
          decoration: InputDecoration(labelText: 'Ángulo'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              angle = double.tryParse(value) ?? 0;
            });
          },
        ),
        SizedBox(height: 5),
        // Tamaño
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
        // Coordenada X
        TextField(
          decoration: InputDecoration(labelText: 'Coordenada X'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              xCoord = double.tryParse(value) ?? 0;
            });
          },
        ),
        SizedBox(height: 5),
        // Coordenada Y
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
          onPressed: _addVector,
          child: Text('Agregar Vector'),
        ),
        SizedBox(height: 20),
        Text(
          'Resultante: ${_calculateResultant().length.toStringAsFixed(2)} unidades, Ángulo: ${_calculateResultant().angle.toStringAsFixed(2)} grados',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            label: 'Conceptos',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: _currentIndex == 2 ? Colors.pinkAccent : Color.fromARGB(255, 255, 255, 255),
            ),
            label: 'Configuración',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.info,
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
  final List<Vectores> vectors;
  final double zoom;

  CartesianGridAndVectorPainter(this.vectors, this.zoom);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 0.5;

    double step = 20.0 * zoom; // Tamaño de la cuadrícula
    // Dibujar las líneas de la cuadrícula
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

    // Dibujar números en el eje X (positivos y negativos)
    for (double i = -size.width / 2; i <= size.width / 2; i += step) {
      if (i == 0) continue; // Evitar el cero
      final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: (i / step).toInt().toString(),
          style: TextStyle(color: Colors.black, fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(i + size.width / 2 - 10, size.height / 2 + 2));
    }

    // Dibujar números en el eje Y (positivos y negativos)
    for (double i = -size.height / 2; i <= size.height / 2; i += step) {
      if (i == 0) continue; // Evitar el cero
      final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: ((-i / step).toInt()).toString(),
          style: TextStyle(color: Colors.black, fontSize: 10),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(size.width / 2 + 2, i + size.height / 2 - 10));
    }

    // Dibujar los vectores
    for (var vector in vectors) {
      final double radians = vector.angle * pi / 180;
      final double xEnd = (vector.length * cos(radians)) * zoom;
      final double yEnd = (vector.length * sin(radians)) * zoom;

      final Paint vectorPaint = Paint()
        ..color = Colors.red
        ..strokeWidth = 2.0;

      canvas.drawLine(
        Offset(size.width / 2, size.height / 2),
        Offset(size.width / 2 + xEnd, size.height / 2 - yEnd),
        vectorPaint,
      );


      
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


class Vectores {
  final double angle;
  final double length;
  final double xCoord;
  final double yCoord;

  Vectores(this.angle, this.length, this.xCoord, this.yCoord);
}
